package com.sist.web;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
	@GetMapping("mypage/buy.do")
	public String mypage_buy(HttpSession session) {
		String userId=(String)session.getAttribute("userId");
		MemberVO vo=mService.mypageInfoData(userId);
		return "mypage/buy";
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
	@GetMapping("mypage/info_update.do")
	public String mypage_info_update(HttpSession session) {
		String userId=(String)session.getAttribute("userId");
		MemberVO vo=mService.mypageInfoData(userId);
		return "mypage/info_update";
	}
}
