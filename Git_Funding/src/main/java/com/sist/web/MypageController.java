package com.sist.web;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.sist.service.MypageService;
import com.sist.vo.*;

@Controller
public class MypageController {
	@Autowired
	private MypageService mService;
	
	@GetMapping("mypage/main.do")
	public String mypage_main(HttpSession session) {
		String userId=(String)session.getAttribute("userId");
		MemberVO vo=mService.mypageInfoData(userId);
		return "mypage";
	}
	@GetMapping("mypage/funding_buy.do")
	public String mypage_funding_buy(HttpSession session) {
		String userId=(String)session.getAttribute("userId");
		MemberVO vo=mService.mypageInfoData(userId);
		return "mypage/funding_buy";
	}
	@GetMapping("mypage/qna.do")
	public String mypage_qna(HttpSession session) {
		String userId=(String)session.getAttribute("userId");
		MemberVO vo=mService.mypageInfoData(userId);
		return "mypage/qna";
	}
	@GetMapping("mypage/info.do")
	public String mypage_info(HttpSession session) {
		String userId=(String)session.getAttribute("userId");
		MemberVO vo=mService.mypageInfoData(userId);
		return "mypage/info";
	}
	@GetMapping("mypage/follow.do")
	public String mypage_follow(HttpSession session) {
		String userId=(String)session.getAttribute("userId");
		MemberVO vo=mService.mypageInfoData(userId);
		return "mypage/follow";
	}
	@GetMapping("mypage/info_update.do")
	public String mypage_info_update(HttpSession session) {
		String userId=(String)session.getAttribute("userId");
		MemberVO vo=mService.mypageInfoData(userId);
		return "mypage/info_update";
	}
	@GetMapping("mypage/jjim_alert.do")
	public String jjim_alert(Model model,HttpSession session) {
		String userId=(String)session.getAttribute("userId");
		int jjimCount = mService.fundingWishCount(userId);
	    model.addAttribute("jjimCount", jjimCount);
	    int AlertCount = mService.fundingAlertCount(userId);
	    model.addAttribute("AlertCount", AlertCount);
	    
		MemberVO vo=mService.mypageInfoData(userId);
		return "mypage/jjim_alert";
	}
	@GetMapping("mypage/store_ordered.do")
	public String store_ordered() {
		return "mypage/store_ordered";
	}
}
