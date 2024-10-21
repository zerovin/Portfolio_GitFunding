package com.sist.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.*;

import javax.servlet.http.HttpSession;

import com.sist.vo.*;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.service.*;
@RestController
public class MemberRestController {
	@Autowired
	private MemberService mService;
	
	@GetMapping(value="member/idcheck_vue.do", produces="text/plain;charset=UTF-8")
	public String member_idcheck(String userId) {
		int count=mService.idCheck(userId);
		return String.valueOf(count);
	}
	
	@GetMapping(value="member/reward_delivery.do", produces="text/plain;charset=UTF-8")
	public String reward_delivery(HttpSession session) throws Exception{
		String userId=(String)session.getAttribute("userId");
		MemberVO vo=mService.rewardDeliveryMemberInfo(userId);
		ObjectMapper mapper=new ObjectMapper();
		String json=mapper.writeValueAsString(vo);
		return json;
	}
}
