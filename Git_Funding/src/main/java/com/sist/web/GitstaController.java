package com.sist.web;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sist.vo.GitstaVO;

@Controller
@RequestMapping("gitsta/")
public class GitstaController {
	@GetMapping("getSessionId.do")
	@ResponseBody
	public String getSessionId(HttpSession session) {
	    String sessionId = (String) session.getAttribute("userId");
	    return sessionId != null ? sessionId : "";
	}
	
	@GetMapping("main.do")
	public String gitsta_main(String userId, Model model, HttpSession session) {
	    String sessionId = (String) session.getAttribute("userId");
	    model.addAttribute("sessionId", sessionId);
	    model.addAttribute("userId", userId);
	    return "gitsta/main"; // main.jsp로 이동
	}
	@GetMapping("feed.do")
	public String gitsta_feed(Model model,String userId,HttpSession session) {
		String sessionId = (String) session.getAttribute("userId");
		model.addAttribute("userId",userId);
		model.addAttribute("sessionId", sessionId);
		return "gitsta/feed";
	}
	@GetMapping("create_post.do")
	public String create_post(Model model,String userId,HttpSession session) {
		String sessionId = (String) session.getAttribute("userId");
		model.addAttribute("userId",userId);
		model.addAttribute("sessionId", sessionId);
		return "gitsta/create_post";
	}
	@GetMapping("post_detail.do")
	public String post_detail(int no, Model model,String userId,HttpSession session) {
		String sessionId = (String) session.getAttribute("userId");
		model.addAttribute("no",no);
		model.addAttribute("userId",userId);
		model.addAttribute("sessionId", sessionId);
		return "gitsta/post_detail";
	}
	
}
