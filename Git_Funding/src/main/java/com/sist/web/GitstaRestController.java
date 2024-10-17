package com.sist.web;

import com.sist.vo.*;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.service.*;
import java.util.*;
import java.io.*;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

@RestController
public class GitstaRestController {
    @Autowired
    private GitstaService gService;

    @Autowired
    private ServletContext servletContext;

    @GetMapping(value = "gitsta/info_vue.do", produces = "text/plain;charset=UTF-8")
    public String mypage_menu(String userId) throws Exception {
        MemberVO vo = gService.gitstaInfoData(userId);
        ObjectMapper mapper = new ObjectMapper();
        return mapper.writeValueAsString(vo);
    }

    @GetMapping(value = "gitsta/myfeed_vue.do", produces = "text/plain;charset=UTF-8")
    public String gitsta_myfeed(@RequestParam("userId") String userId, @RequestParam(defaultValue = "1") int page) {
        try {
            int rowSize = 10;
            int start = (rowSize * page) - (rowSize - 1);
            int end = rowSize * page;

            List<GitstaVO> list = gService.gitstaTotalListData(userId, start, end);
            int totalPostCount = gService.gitstaTotalCount(userId);

            boolean hasMore = (totalPostCount > end);

            Map<String, Object> map = new HashMap<>();
            map.put("list", list);
            map.put("totalPostCount", totalPostCount);
            map.put("hasMore", hasMore);
            map.put("userId", userId);

            ObjectMapper mapper = new ObjectMapper();
            return mapper.writeValueAsString(map);
        } catch (Exception e) {
            e.printStackTrace();
            return "{\"error\":\"An error occurred while fetching data.\"}";
        }
    }

    @PostMapping(value = "gitsta/create_post_vue.do", produces = "text/plain;charset=UTF-8")
    public String create_post(GitstaVO vo) {
        String result = "";
        try {
            String path = servletContext.getRealPath("/profile") + File.separator;

            File dir = new File(path);
            if (!dir.exists()) {
                dir.mkdirs();
            }

            MultipartFile file = vo.getFile();
            if (file == null || file.isEmpty()) {
                vo.setFilename("");
                vo.setFilesize("");
                vo.setFilecount(0);
            } else {
                String name = file.getOriginalFilename();
                File savedFile = new File(path + name);
                try {
                    file.transferTo(savedFile);
                } catch (IOException e) {
                    e.printStackTrace();
                    return "파일 저장 중 오류가 발생했습니다.";
                }

                vo.setFilecount(1);
                vo.setFilename(name);
                vo.setFilesize(String.valueOf(file.getSize()));
            }

            gService.feedInsert(vo);
            result = "yes";

        } catch (Exception ex) {
            ex.printStackTrace();
            result = ex.getMessage();
        }
        return result;
    }

    @GetMapping("/profile/{filename}")
    public void getProfileImage(@PathVariable("filename") String filename, HttpServletResponse response) {
        try {
        	String path = servletContext.getRealPath("/profile") + File.separator;
            File file = new File(path + filename);
            if (file.exists()) {
                FileInputStream fis = new FileInputStream(file);
                response.setContentType("image/jpeg");
                response.getOutputStream().write(fis.readAllBytes());
                fis.close();
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
    
    
}