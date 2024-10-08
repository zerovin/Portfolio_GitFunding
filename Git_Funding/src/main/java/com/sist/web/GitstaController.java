package com.sist.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("gitsta/")
public class GitstaController {
	@GetMapping("main.do")
	public String gitsta_main() {
		return "gitsta/main";
	}
	@GetMapping("feed.do")
	public String gitsta_feed() {
		return "gitsta/feed";
	}
}
