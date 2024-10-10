package com.sist.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("mypage/")
public class MypageController {
	@GetMapping("menu.do")
	public String mypage_menu() {
		return "mypage/menu";
	}
}
