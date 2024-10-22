package com.sist.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class RewardController {
	@GetMapping("reward/reward_buy.do")
	public String reward_buy(int fno, int rno, Model model) {
		model.addAttribute("fno", fno);
		model.addAttribute("rno", rno);
		return "funding/reward_buy";
	}
}
