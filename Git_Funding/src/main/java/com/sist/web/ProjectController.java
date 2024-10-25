package com.sist.web;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ProjectController {
	@GetMapping("project/home.do")
	public String project_home() {
		return "project/home";
	}
	
	@GetMapping("project/reward_detail.do")
	public String reward_detail(int fno, Model model) {
		model.addAttribute("fno", fno);
		
		return "project/reward_detail";
	}
	
	// 리워드 추가
	@GetMapping("project/reward_insert.do")
	public String add_reward(@RequestParam int fno, Model model, HttpSession session) {
	    String userId = (String) session.getAttribute("userId");

	    model.addAttribute("fno", fno);
	    model.addAttribute("userId", userId);

	    return "project/reward_insert";
	}
	
	@GetMapping("project/reward_update.do")
	public String fundingRewardUpdate(int rno, int fno, Model model) {
		
		model.addAttribute("rno", rno);
		model.addAttribute("fno", fno);
		
		return "project/reward_update";
	}
}
