package com.sist.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ProjectController {
	@GetMapping("project/home.do")
	public String project_home() {
		return "project/home";
	}
}
