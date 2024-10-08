package com.sist.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("site/")
public class SiteController {
	@GetMapping("qna_list.do")
	public String qna_list() {
		return "site/qna_list";
	}
}
