package com.sist.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("community/")
public class CommunityController {
	@GetMapping("qna_list.do")
	public String qna_list() {
		return "community/qna_list";
	}
	@GetMapping("qna_insert.do")
	public String qna_insert() {
		return "community/qna_insert";
	}
}
