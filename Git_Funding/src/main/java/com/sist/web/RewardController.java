package com.sist.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.sist.vo.FundingVO;
import com.sist.service.*;

@Controller
public class RewardController {
	@Autowired
	private FundingService fService;
	
	@GetMapping("reward/reward_buy.do")
	public String reward_buy(int fno, int rno, Model model) {
		model.addAttribute("fno", fno);
		model.addAttribute("rno", rno);
		return "funding/reward_buy";
	}
	
	@GetMapping("funding/reward_insert.do")
	public String reward_insert(int fno, Model model) {
		
		model.addAttribute("fno", fno);
		
		return "funding/reward_insert";
	}
	
	// 상세 페이지 이동
//    @GetMapping("/funding/funding_detail.do")
//    public String funding_reward_detail(int fno, Model model) {
//        FundingVO vo = fService.getFundingDetail(fno);
//        List<RewardVO> rewards = service.getFundingRewards(fno);
//
//        model.addAttribute("funding", funding);
//        model.addAttribute("rewards", rewards);
//
//        return "funding/funding_detail";
//    }
//
//    // 리워드 추가 기능
//	@PostMapping("/funding/reward_insert.do")
//	public String insertFundingReward(RewardVO reward, HttpSession session) {
//        String userId = (String) session.getAttribute("userId");
//        reward.setUserId(userId);
//        service.insertFundingReward(reward);
//
//        return "redirect:/funding/funding_detail.do?fno=" + reward.getFno();
    }
	
	
}