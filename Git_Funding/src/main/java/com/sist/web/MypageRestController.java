package com.sist.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import java.util.*;

import javax.servlet.http.HttpSession;

import com.sist.vo.*;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.service.*;
@RestController
public class MypageRestController {
	@Autowired
	private MypageService mService;
	
	@GetMapping(value="mypage/menu_vue.do",produces = "text/plain;charset=UTF-8")
	public String mypage_menu(HttpSession session) throws Exception {
		String userId=(String)session.getAttribute("userId");
		MemberVO vo=mService.mypageInfoData(userId);
		ObjectMapper mapper=new ObjectMapper();
		String json=mapper.writeValueAsString(vo);
		return json;
	}
	
	@PostMapping(value="mypage/set_nick_vue.do",produces = "text/plain;charset=UTF-8")
	   public String board_insert(HttpSession session,String nickname) throws Exception {
		   String result="";
		   String userId=(String)session.getAttribute("userId");
		   if (userId == null) {
			   return "no"; 
		   }
		   Map map=new HashMap();
		   map.put("userId", userId);
		   map.put("nickname", nickname);
		   try
		   {
			   result="yes";
			   mService.SetNickname(map);
		   }catch(Exception ex)
		   {
			   ex.printStackTrace();
			   result="no";   
		   }
		   return result;
	   }
	@PostMapping(value = "mypage/update_user_info.do", produces = "text/plain;charset=UTF-8")
	public String update_user_info(HttpSession session,MemberVO vo) throws Exception {
		String result="";
		String userId=(String)session.getAttribute("userId");
		vo.setUserId(userId);
		try {
			mService.mypageInfoUpdate(vo);
			result="yes";
		}catch(Exception ex) {
			result=ex.getMessage();
		}
		return result;
	}
	// 마이페이지 펀딩 찜
	@GetMapping(value="mypage/jjim_vue.do",produces = "text/plain;charset=UTF-8")
	public String mypage_jjim(HttpSession session) throws Exception {
		String userId=(String)session.getAttribute("userId");
		List<WishVO> list = mService.fundingWishList(userId);
		ObjectMapper mapper=new ObjectMapper();
		String json=mapper.writeValueAsString(list);
		return json;
	}
	@GetMapping(value="mypage/jjim_count_vue.do", produces = "application/json;charset=UTF-8")
	public int mypage_jjim_count(HttpSession session) throws Exception {
	    String userId = (String) session.getAttribute("userId");
	    int count = mService.fundingWishCount(userId);
	    return count; 
	}
	// 펀딩 오픈 알림
	@GetMapping(value="mypage/alert_vue.do",produces = "text/plain;charset=UTF-8")
	public String alert_jjim(HttpSession session) throws Exception {
		String userId=(String)session.getAttribute("userId");
		List<AlertVO> list = mService.fundingAlertList(userId);
		ObjectMapper mapper=new ObjectMapper();
		String json=mapper.writeValueAsString(list);
		return json;
	}
	@GetMapping(value="mypage/alert_count_vue.do", produces = "application/json;charset=UTF-8")
	public int mypage_alert_count(HttpSession session) throws Exception {
		String userId = (String) session.getAttribute("userId");
		int count = mService.fundingAlertCount(userId);	
		return count; 
	}
	
	@GetMapping(value="mypage/funding_buy_vue.do", produces = "text/plain;charset=UTF-8")
	public String mypagePurchaseList(HttpSession session, int page) throws Exception {
	    int rowSize = 8; // 한 페이지에 보여줄 항목 수
	    int start = (rowSize * page) - (rowSize - 1);
	    int end = rowSize * page;
	    String userId=(String)session.getAttribute("userId");

	    Map map = new HashMap();
	    map.put("userId", userId);
	    map.put("start", start);
	    map.put("end", end);
	    int totalpage=mService.getTotalRewardBuyCount(userId);
		
		final int BLOCK=8;
		int startpage=((page-1)/BLOCK*BLOCK)+1;
		int endpage=((page-1)/BLOCK*BLOCK)+BLOCK;
		if(endpage>totalpage) {
			endpage=totalpage;
		}
		List<RewardBuyVO> list=mService.getRewardBuyList(map);

	    map = new HashMap();
	    map.put("list", list);
	    map.put("curpage", page);
	    map.put("startpage", startpage);
	    map.put("totalpage", totalpage);

	    ObjectMapper mapper = new ObjectMapper();
	    String json = mapper.writeValueAsString(map);

	    return json;
	}

	@GetMapping(value="mypage/funding_buy_detail_vue.do", produces = "text/plain;charset=UTF-8")
	public String mypagePurchaseDetail(int rbno) throws Exception {

	    // 특정 구매 항목의 상세 정보 가져오기
	    RewardBuyVO vo = mService.getPurchaseDetail(rbno);

	    // ObjectMapper를 사용하여 JSON 문자열로 변환
	    ObjectMapper mapper = new ObjectMapper();
	    String json = mapper.writeValueAsString(vo);

	    return json;
	}

}
