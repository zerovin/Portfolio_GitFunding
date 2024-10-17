package com.sist.web;
import com.sist.vo.*;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.service.*;
import java.util.*;
import java.io.*;
import java.net.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

@RestController
public class GitstaRestController {
	@Autowired
	private GitstaService gService;
	
	@GetMapping(value="gitsta/info_vue.do",produces = "text/plain;charset=UTF-8")
	public String mypage_menu(String userId) throws Exception {
		MemberVO vo=gService.gitstaInfoData(userId);
		ObjectMapper mapper=new ObjectMapper();
		String json=mapper.writeValueAsString(vo);
		return json;
	}
	
	@GetMapping(value = "gitsta/myfeed_vue.do", produces = "text/plain;charset=UTF-8")
	public String gitsta_myfeed(@RequestParam("userId") String userId, @RequestParam(defaultValue = "1") int page) {
	    try {
	        int rowSize = 10; // 페이지당 게시물 수
	        int start = (rowSize * page) - (rowSize - 1);
	        int end = rowSize * page;

	        List<GitstaVO> list = gService.gitstaTotalListData(userId, start, end);
	        int totalPostCount = gService.gitstaTotalCount(userId); // 총 게시물 수 가져오기
	        
	        boolean hasMore = (totalPostCount > end); // 더 많은 게시물이 있는지 여부

	        Map<String, Object> map = new HashMap<>();
	        map.put("list", list);
	        map.put("totalPostCount", totalPostCount);
	        map.put("hasMore", hasMore);
	        map.put("userId", userId);

	        ObjectMapper mapper = new ObjectMapper();
	        String json = mapper.writeValueAsString(map);
	        
	        return json;
	    } catch (Exception e) {
	        e.printStackTrace();
	        return "{\"error\":\"An error occurred while fetching data.\"}";
	    }
	}
	
	@PostMapping(value = "gitsta/create_post_vue.do", produces = "text/plain;charset=UTF-8")
	public String create_post(GitstaVO vo, HttpServletRequest request) {
	    String result = "";
	    try {
	        String path = request.getSession().getServletContext().getRealPath("/") + "profile\\";
	        File dir = new File(path);
	        if (!dir.exists()) {
	            dir.mkdir();
	        }
	        path = path.replace("\\", File.separator);

	        // 단일 파일 처리
	        MultipartFile file = vo.getFile(); // GitstaVO에서 단일 파일을 받도록 수정
	        if (file == null || file.isEmpty()) {
	            vo.setFilename("");
	            vo.setFilesize("");
	            vo.setFilecount(0);
	        } else {
	            String name = file.getOriginalFilename();
	            File savedFile = new File(path + name);
	            file.transferTo(savedFile); // 파일 저장

	            vo.setFilecount(1); // 파일 하나
	            vo.setFilename(name); // 파일 이름
	            vo.setFilesize(String.valueOf(file.getSize())); // 파일 크기
	        }

	        gService.feedInsert(vo);
	        result = "yes";

	    } catch (Exception ex) {
	        result = ex.getMessage();
	    }
	    return result;
	}

}
