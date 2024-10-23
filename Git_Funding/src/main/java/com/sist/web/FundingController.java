package com.sist.web;

import java.util.Date;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class FundingController {
	@GetMapping("funding/open_list.do")
	public String funding_open() {
		return "funding/open_list";
	}
	
	@GetMapping("funding/funding_list.do")
	public String funding_funding(String cate, Model model) {
		if(cate==null) {
			cate=String.valueOf(0);
		}
		model.addAttribute("cate", cate);			
		return "funding/funding_list";
	}
	
	@GetMapping("funding/detail_before.do")
	public String funding_detail_before(int fno, String type, HttpServletResponse response, RedirectAttributes ra) {
		Cookie cookie=new Cookie("funding_"+fno, String.valueOf(fno));
		cookie.setMaxAge(60*60*24);
		cookie.setPath("/");
		response.addCookie(cookie);
		
		ra.addAttribute("fno", fno);
		ra.addAttribute("type", type);
		return "redirect:../funding/funding_detail.do";
	}
	
	@GetMapping("funding/funding_detail.do")
	public String funding_funding_detail(int fno, String type, HttpSession session, Model model) {
		String id=(String)session.getAttribute("userId");
		model.addAttribute("fno", fno);
		model.addAttribute("sessionId", id);
		model.addAttribute("type", type);
		return "funding/funding_detail";
	}
	
	@GetMapping("project/create_project.do")
	public String create_project(HttpSession session) {
		String id = (String)session.getAttribute("userId");
		
		return "project/create_project";
	}
	
	@GetMapping("project/create_funding.do")
	public String create_funding() {
		
		return "project/create_funding";
	}
}
