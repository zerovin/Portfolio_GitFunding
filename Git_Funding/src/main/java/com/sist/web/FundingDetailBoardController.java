package com.sist.web;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
@Controller
public class FundingDetailBoardController {
	@GetMapping("funding/detail_notice_detail.do")
	public String funding_notice_detail(int fno, int dnno, HttpSession session, Model model) {
		String id=(String)session.getAttribute("userId");
		model.addAttribute("fno", fno);
		model.addAttribute("dnno", dnno);
		model.addAttribute("sessionId", id);
		return "funding/notice_detail";
	}
}
