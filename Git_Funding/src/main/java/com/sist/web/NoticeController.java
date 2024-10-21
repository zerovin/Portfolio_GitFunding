package com.sist.web;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class NoticeController {

	@GetMapping("notice/list.do")
	public String notice_list(Model model, HttpSession session) {
		String id = (String)session.getAttribute("userId");
		String nickname = (String)session.getAttribute("nickname");

		return "notice/list";
	}
	
	@GetMapping("notice/insert.do")
	public String notice_insert(HttpSession session) {
		String nickname = (String)session.getAttribute("nickname");
		
		return "notice/insert";
	}
	
	@GetMapping("notice/detail.do")
	public String notice_detail(int no, Model model, HttpSession session) {
		String id = (String)session.getAttribute("userId");
		String nickname = (String)session.getAttribute("nickname");
		
		model.addAttribute("no", no);
		model.addAttribute("sessionId", id);
		model.addAttribute("nickname", nickname);
		
		return "notice/detail";
	}
	
	@GetMapping("notice/update.do")
	public String notice_update() {
		return "notice/update";
	}
	
	@GetMapping("notice/delete.do")
	public String notice_delete() {
		return "notice/delete";
	}
}
