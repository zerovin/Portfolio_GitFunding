package com.sist.web;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
@Controller
public class FundingDetailBoardController {
	@GetMapping("funding/detail_notice.do")
	public String funding_detail_notice(int fno, String type, HttpSession session, Model model) {
		String id=(String)session.getAttribute("userId");
		model.addAttribute("fno", fno);
		model.addAttribute("type", type);
		model.addAttribute("sessionId", id);
		return "funding/funding_detail_notice";
	}
	
	@GetMapping("funding/detail_community.do")
	public String funding_detail_community(int fno, String type, HttpSession session, Model model) {
		String id=(String)session.getAttribute("userId");
		model.addAttribute("fno", fno);
		model.addAttribute("type", type);
		model.addAttribute("sessionId", id);
		return "funding/funding_detail_community";
	}
	
	@GetMapping("funding/detail_notice_detail.do")
	public String funding_notice_detail(int fno, String type, int dnno, HttpSession session, Model model) {
		String id=(String)session.getAttribute("userId");
		model.addAttribute("fno", fno);
		model.addAttribute("type", type);
		model.addAttribute("dnno", dnno);
		model.addAttribute("sessionId", id);
		return "funding/notice_detail";
	}
}
