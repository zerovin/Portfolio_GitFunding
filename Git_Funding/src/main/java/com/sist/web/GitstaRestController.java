package com.sist.web;

import com.sist.vo.*;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.service.*;
import java.util.*;
import java.io.*;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
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
    public String gitsta_myfeed(String userId, int page) throws Exception{
    	int rowSize = 9;
    	int start = (rowSize * page) - (rowSize - 1);
    	int end = rowSize * page;

    	List<GitstaVO> list = gService.gitstaMyTotalListData(userId, start, end);
    	int totalPostCount = gService.gitstaMyTotalCount(userId);

    	boolean hasMore = (totalPostCount > end);

    	Map<String, Object> map = new HashMap<>();
    	map.put("list", list);
    	map.put("totalPostCount", totalPostCount);
    	map.put("hasMore", hasMore);
    	map.put("userId", userId);

    	ObjectMapper mapper = new ObjectMapper();
    	String json=mapper.writeValueAsString(map);

    	return json;
    }
    
    @GetMapping(value = "gitsta/total_feed_vue.do", produces = "text/plain;charset=UTF-8")
    public String gitstaMyFeed() throws Exception {
        List<GitstaVO> list = gService.gitstaTotalListData();  // 전체 피드 가져오기

        // 각 포스트의 경과 시간(dbday) 설정
        gService.setFeedDisplayDate(list);

        int totalPostCount = gService.gitstaTotalCount();

        Map<String, Object> map = new HashMap<>();
        map.put("list", list);
        map.put("totalPostCount", totalPostCount);

        ObjectMapper mapper = new ObjectMapper();
        String json = mapper.writeValueAsString(map);
        return json;
    }
    
    @GetMapping(value = "gitsta/following_list_vue.do", produces = "application/json;charset=UTF-8")
    public String following_list(String userId) throws Exception {
        List<MemberVO> list = gService.gitstaFollowingListData(userId);
        int followingCount = gService.getFollowingCount(userId);

        Map<String, Object> map = new HashMap<>();
        map.put("list", list);
        map.put("followerCount", followingCount); 

        ObjectMapper mapper = new ObjectMapper();
        String json = mapper.writeValueAsString(map);
        return json;
    }
    
    @GetMapping(value = "gitsta/follower_list_vue.do", produces = "application/json;charset=UTF-8")
    public String follower_list(String userId) throws Exception {
        // 사용자를 팔로우하는 사람들의 목록을 가져옴
        List<MemberVO> list = gService.gitstaFollowerListData(userId);

        // 사용자를 팔로우하고 있는 사람들의 수를 가져옴 (팔로워 수)
        int followerCount = gService.getFollowerCount(userId);

        Map<String, Object> map = new HashMap<>();
        map.put("list", list);    // 사용자를 팔로우하는 사람들의 목록
        map.put("followerCount", followerCount);  // 사용자를 팔로우하고 있는 사람들의 수 (팔로워 수)

        ObjectMapper mapper = new ObjectMapper();
        String json = mapper.writeValueAsString(map);
        return json;
    }
    
    @GetMapping(value = "gitsta/follower_count_vue.do", produces = "application/json;charset=UTF-8")
    public String follow_count(String userId) throws Exception {
        // 사용자를 팔로우하는 사람들의 목록을 가져옴

        // 사용자를 팔로우하고 있는 사람들의 수를 가져옴 (팔로워 수)
        int followerCount = gService.getFollowerCount(userId);
        int followingCount = gService.getFollowingCount(userId);
        Map<String, Object> map = new HashMap<>();
        map.put("followingCount",followingCount);
        map.put("followerCount", followerCount);  // 사용자를 팔로우하고 있는 사람들의 수 (팔로워 수)

        ObjectMapper mapper = new ObjectMapper();
        String json = mapper.writeValueAsString(map);
        return json;
    }
    
    @PostMapping(value = "gitsta/create_post_vue.do", produces = "text/plain;charset=UTF-8")
    public String create_post(GitstaVO vo,HttpServletRequest request) {
        String result = "";
        try {
        	String path=request.getSession().getServletContext().getRealPath("/")+"profile\\";

            File dir = new File(path);
            if (!dir.exists()) {
                dir.mkdirs();
            }
            path=path.replace("\\", File.separator);
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
    public void getProfileImage(@PathVariable("filename") String filename, HttpServletResponse response,HttpServletRequest request) {
        try {
        	String path=request.getSession().getServletContext().getRealPath("/")+"profile\\";
        	path=path.replace("\\", File.separator);
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
    
    @PostMapping(value = "gitsta/follow.do", produces = "text/plain;charset=UTF-8")
    public String followUser(String followerId, String followingId) {
        try {
            gService.insertFollow(followerId, followingId);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }
    @PostMapping(value = "gitsta/unfollow.do", produces = "text/plain;charset=UTF-8")
    public String unfollowUser(String followerId, String followingId) {
        try {
            gService.deleteFollow(followerId, followingId);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }
    
    @GetMapping(value="gitsta/post_detail_vue.do", produces = "text/plain;charset=UTF-8")
    public String post_detail(int no) throws Exception {
    	GitstaVO vo=gService.gitstaDetailData(no);
    	ObjectMapper mapper=new ObjectMapper();
    	String json=mapper.writeValueAsString(vo);
    	
    	return json;
    }
    
    @GetMapping(value="gitsta/post_delete_vue.do", produces = "text/plain;charset=UTF-8")
    public String post_delete(int no,HttpServletRequest request) {
    	GitstaVO vo=gService.deleteInfoData(no);
    	String result=gService.deletePost(no);
    	if(result.equals("yes")) {
    		String path=request.getSession().getServletContext().getRealPath("/")+"profile\\";
			path=path.replace("\\", File.separator);
			if(vo.getType()==1) {
				StringTokenizer st=new StringTokenizer(vo.getFilename(),",");
				while(st.hasMoreTokens()) {
					File file=new File(path+st.nextToken());
					file.delete();
				}
			}
		}
		return result;
	}
    
    @GetMapping(value="gitsta/post_update_vue.do", produces = "text/plain;charset=UTF-8")
    public String post_update(int no) throws Exception {
    	GitstaVO vo=gService.postUpdateData(no);
    	ObjectMapper mapper=new ObjectMapper();
		String json=mapper.writeValueAsString(vo);
		return json;
    }
    @PostMapping(value = "gitsta/post_update_ok_vue.do", produces = "text/plain;charset=UTF-8")
    public String post_update_ok(GitstaVO vo, HttpServletRequest request) throws Exception {
        String result = "";
        try {
            // 기존 게시물 데이터를 가져옴
            GitstaVO fvo = gService.postUpdateData(vo.getNo());

            // 파일 경로 설정
            String path = request.getSession().getServletContext().getRealPath("/") + "profile" + File.separator;

            // 기존 파일이 있는 경우 삭제
            if (fvo.getFilecount() > 0 && fvo.getFilename() != null) {
                StringTokenizer st = new StringTokenizer(fvo.getFilename(), ",");
                while (st.hasMoreTokens()) {
                    String fileName = st.nextToken();
                    File file = new File(path + fileName);
                    if (file.exists()) {
                        file.delete(); // 기존 파일 삭제
                    }
                }
            }

            // 새로 업로드한 파일 처리
            MultipartFile mf = vo.getFile();
            if (mf != null && !mf.isEmpty()) {
                String originalFilename = mf.getOriginalFilename();
                File file = new File(path + originalFilename);
                mf.transferTo(file); // 새 파일 업로드
                vo.setFilename(originalFilename);
                vo.setFilesize(String.valueOf(mf.getSize()));
                vo.setFilecount(1); // 파일이 존재하므로 filecount 1로 설정
            } else {
                vo.setFilename("");
                vo.setFilesize("");
                vo.setFilecount(0); // 파일이 없으므로 filecount 0으로 설정
            }

            // 게시물 수정 처리
            result = gService.updatePost(vo);

        } catch (Exception ex) {
            ex.printStackTrace();
            result = "fail"; // 오류 발생 시 실패 메시지 반환
        }
        return result;
    }
    
}