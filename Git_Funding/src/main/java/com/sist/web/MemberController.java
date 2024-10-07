package com.sist.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MemberController {
	@GetMapping("member/join.do")
	public String member_join() {
		return "member/join";
	}
	
	@RequestMapping("member/login.do")
	public String member_login() {
		return "member/login";
	}
}
