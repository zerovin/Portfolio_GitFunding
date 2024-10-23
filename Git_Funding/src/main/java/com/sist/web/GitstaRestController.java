package com.sist.web;

import com.sist.vo.*;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.service.*;
import java.util.*;
import java.io.*;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
    
    // 댓글
    public String commonsListData(int page,int no) throws Exception{
		Map map=new HashMap();
		int rowSize=5;
		int start=(rowSize*page)-(rowSize-1);
		int end=rowSize*page;
		
		map.put("start", start);
		map.put("end", end);
		map.put("no", no);
		
		List<GitstaReVO> list=gService.commentListData(map);
		int totalpage=gService.commentTotalPage(no);
		
		final int BLOCK=10;
		int startPage=((page-1)/BLOCK*BLOCK)+1;
		int endPage=((page-1)/BLOCK*BLOCK)+BLOCK;
		
		if(endPage>totalpage)
			endPage=totalpage;
		
		map=new HashMap();
		map.put("list", list);
		map.put("curpage", page);
		map.put("totalpage", totalpage);
		map.put("startPage", startPage);
		map.put("endPage", endPage);
		
		ObjectMapper mapper=new ObjectMapper();
		String json=mapper.writeValueAsString(map);
		
		return json;
	}

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

        Map map = new HashMap<>();
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
            GitstaVO fvo = gService.postUpdateData(vo.getNo());

            String path = request.getSession().getServletContext().getRealPath("/") + "profile" + File.separator;

            if (fvo.getFilecount() > 0 && fvo.getFilename() != null) {
                StringTokenizer st = new StringTokenizer(fvo.getFilename(), ",");
                while (st.hasMoreTokens()) {
                    String fileName = st.nextToken();
                    File file = new File(path + fileName);
                    if (file.exists()) {
                        file.delete(); 
                    }
                }
            }


            MultipartFile mf = vo.getFile();
            if (mf != null && !mf.isEmpty()) {
                String originalFilename = mf.getOriginalFilename();
                File file = new File(path + originalFilename);
                mf.transferTo(file);
                vo.setFilename(originalFilename);
                vo.setFilesize(String.valueOf(mf.getSize()));
                vo.setFilecount(1); 
            } else {
                vo.setFilename("");
                vo.setFilesize("");
                vo.setFilecount(0); 
            }

            result = gService.updatePost(vo);

        } catch (Exception ex) {
            ex.printStackTrace();
            result = "fail"; 
        }
        return result;
    }
    
    @GetMapping(value = "gitsta/comment_list_vue.do", produces = "text/plain;charset=UTF-8")
    public String comment_list(@RequestParam(value = "page", defaultValue = "1") int page,
                               @RequestParam(value = "no") int no) throws Exception {
        return commonsListData(page, no);
    }
    
 // 댓글 추가
    @PostMapping(value = "gitsta/comment_insert_vue.do", produces = "text/plain;charset=UTF-8")
    public String commentInsert(@RequestParam("rno") int rno, @RequestParam("msg") String msg, HttpSession session) throws Exception {
        // 세션에서 사용자 정보 가져오기
        String userId = (String) session.getAttribute("userId");
        String nickname = (String) session.getAttribute("nickname");

        // VO 생성 및 데이터 세팅
        GitstaReVO vo = new GitstaReVO();
        vo.setRno(rno);  // 게시글 번호
        vo.setMsg(msg);  // 댓글 내용
        vo.setUserId(userId);
        vo.setNickname(nickname);

        // 댓글 삽입 서비스 호출
        gService.commentInsert(vo);
        return commonsListData(1, vo.getRno());
    }

    // 대댓글 추가
    @PostMapping(value = "gitsta/comment_reply_insert_vue.do", produces = "text/plain;charset=UTF-8")
    public String commentReplyInsert(int gno, GitstaReVO vo, HttpSession session) throws Exception {
        // 세션에서 사용자 정보 가져오기
    	 System.out.println("msg: " + vo.getMsg());
        String userId = (String) session.getAttribute("userId");
        String nickname = (String) session.getAttribute("nickname");
        vo.setUserId(userId);
        vo.setNickname(nickname);

        // 대댓글 삽입 서비스 호출
        gService.commentReplyReplyInsert(gno, vo);
        return commonsListData(1, vo.getRno()); // rno를 사용하여 댓글 목록 갱신
    }

    // 댓글 삭제
    @GetMapping(value = "gitsta/comment_delete_vue.do", produces = "text/plain;charset=UTF-8")
    public String commentDelete(int gno, int rno) throws Exception {
        // 댓글 삭제 서비스 호출
        GitstaReVO vo = gService.commentDeleteInfoData(gno);
        Map<String, Object> map = new HashMap<>();
        map.put("gno", gno);
        map.put("group_id", vo.getGroup_id());
        map.put("group_step", vo.getGroup_step());
        gService.commentDelete(map);
        return commonsListData(1, rno); // rno를 사용하여 댓글 목록 갱신
    }

    // 댓글 수정
    @PostMapping(value = "gitsta/comment_update_vue.do", produces = "text/plain;charset=UTF-8")
    public String commentUpdate(GitstaReVO vo) throws Exception {
        gService.commentUpdate(vo);
        return commonsListData(1, vo.getRno());
    }
    // 마이페이지 카운트
    @GetMapping(value = "gitsta/stats_vue.do", produces = "application/json;charset=UTF-8")
	public String getGitstaStats(HttpSession session) throws Exception {
	    // 세션에서 사용자 ID를 가져옴
	    String userId = (String) session.getAttribute("userId");

	    // 사용자의 게시물 수, 팔로워 수, 팔로잉 수를 가져옴
	    int totalPosts = gService.gitstaMyTotalCount(userId);
	    int followerCount = gService.getFollowerCount(userId);
	    int followingCount = gService.getFollowingCount(userId);

	    // 결과를 Map에 담아서 반환
	    Map<String, Object> resultMap = new HashMap<>();
	    resultMap.put("totalPosts", totalPosts);
	    resultMap.put("followerCount", followerCount);
	    resultMap.put("followingCount", followingCount);

	    // JSON으로 변환
	    ObjectMapper mapper = new ObjectMapper();
	    String json = mapper.writeValueAsString(resultMap);

	    return json;
	}
    
    @GetMapping(value = "gitsta/follow_total_vue.do", produces = "application/json;charset=UTF-8")
    public String follow_total_list(String userId) throws Exception {
        // 팔로잉 목록과 팔로잉 수 가져오기
        List<MemberVO> followingList = gService.gitstaFollowingListData(userId);
        int followingCount = gService.getFollowingCount(userId);

        // 팔로워 목록과 팔로워 수 가져오기
        List<MemberVO> followerList = gService.gitstaFollowerListData(userId);
        int followerCount = gService.getFollowerCount(userId);

        // 맵에 팔로잉 및 팔로워 정보를 통합
        Map map = new HashMap<>();
        map.put("followingList", followingList); // 팔로잉 목록
        map.put("followerList", followerList);   // 팔로워 목록
        map.put("followingCount", followingCount); // 팔로잉 수
        map.put("followerCount", followerCount);   // 팔로워 수

        // JSON 형태로 반환
        ObjectMapper mapper = new ObjectMapper();
        String json = mapper.writeValueAsString(map);
        return json;
    }

}