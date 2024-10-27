package com.sist.web;

import java.util.*;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.sist.vo.*;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.service.*;

@Controller
public class AdminPageController {
	@Autowired
	public MemberService mService;
	
	@GetMapping("adminpage/home.do")
	public String adminpage_home(HttpSession session) {
		String userId = (String)session.getAttribute("userId");
		
		MemberVO vo = mService.memberSessionData(userId);
		
		return "adminpage/home";
	}
	
	@GetMapping("member/list.do")
	public String adminpage_memberList(Map map) {
		return "adminpage/memberList";
	}
}
