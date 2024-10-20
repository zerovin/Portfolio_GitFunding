package com.sist.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.text.DecimalFormat;
import java.util.*;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.service.*;
import com.sist.vo.*;
@RestController
public class RewardRestController {
	@Autowired
	private RewardService rService;
	
	@GetMapping(value="reward/buy_vue.do", produces="text/plain;charset=UTF-8")
	public String reward_buy(int rno) throws Exception{
		FundingRewardVO vo=rService.rewardBuyData(rno);
		vo.setFm_price(new DecimalFormat("###,###").format(vo.getPrice()));
		if(vo.getDelivery()==0) {
			vo.setFm_del("무료배송");
		}else {
			vo.setFm_del((new DecimalFormat("###,###").format(vo.getDelivery()))+"원");				
		}
		
		ObjectMapper mapper=new ObjectMapper();
		String json=mapper.writeValueAsString(vo);
		return json;
	}
}
