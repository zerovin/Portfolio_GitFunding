package com.sist.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import java.text.DecimalFormat;
import java.util.*;

import javax.servlet.http.HttpSession;

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
	
	/*
	{"rno":this.rno},
	{"account":this.account},
	{"price":this.reward_vo.price},
	{"delivery":this.reward_vo.delivery},
	{"totalprice":this.reward_vo.price*this.account+this.reward_vo.delivery},
	{"name":this.reward_del_name},
	{"phone":this.reward_del_phone},
	{"post":$('.post').text()},
	{"addr1":$('.addr1').text()},
	{"addr2":this.reward_del_addr2},
	{"requestMsg":this.reward_del_request}
	
	private int rbno, rno, account, price, delivery, totalprice;
	private String userId, name, phone, post, addr1, addr2, requestMsg;
	private Date regdate
	 */
	@PostMapping(value="reward/buy_ok.do", produces="text/plain;charset=UTF-8")
	public String reward_buy_ok(RewardBuyVO vo, HttpSession session) {
		String result="";
		try {
			String userId=(String)session.getAttribute("userId");
			vo.setUserId(userId);
			rService.rewardBuyInsert(vo);
			rService.rewardBuyMinusAmount(vo);
			result="ok";
		}catch(Exception ex) {
			result=ex.getMessage();
		}
		return result;
	}
}
