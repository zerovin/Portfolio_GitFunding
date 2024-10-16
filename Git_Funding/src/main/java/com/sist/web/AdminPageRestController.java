package com.sist.web;

import java.util.*;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.sist.vo.*;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.service.*;

@RestController
public class AdminPageRestController {
	@Autowired
	private MypageService mService;
	
	@GetMapping(value = "adminpage/menu_vue.do", produces = "text/plain; charset = UTF-8")
	public String mypage_menu(HttpSession session) throws Exception {
		String userId = (String)session.getAttribute("userId");
		MemberVO vo = mService.mypageInfoData(userId);
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(vo);
		return json;
	}
}
