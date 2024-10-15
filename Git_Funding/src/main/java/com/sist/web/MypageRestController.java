package com.sist.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.*;

import javax.servlet.http.HttpSession;

import com.sist.vo.*;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.service.*;
@RestController
public class MypageRestController {
	@Autowired
	private MypageService mService;
	
	@GetMapping(value="mypage/menu_vue.do",produces = "text/plain;charset=UTF-8")
	public String mypage_menu(HttpSession session) throws Exception {
		String userId=(String)session.getAttribute("userId");
		MemberVO vo=mService.mypageInfoData(userId);
		ObjectMapper mapper=new ObjectMapper();
		String json=mapper.writeValueAsString(vo);
		return json;
	}
	
	@PostMapping(value="mypage/set_nick_vue.do",produces = "text/plain;charset=UTF-8")
	   public String board_insert(HttpSession session,String nickname) throws Exception {
		   String result="";
		   String userId=(String)session.getAttribute("userId");
		   if (userId == null) {
			   return "no"; 
		   }
		   Map map=new HashMap();
		   map.put("userId", userId);
		   map.put("nickname", nickname);
		   try
		   {
			   result="yes";
			   mService.SetNickname(map);
		   }catch(Exception ex)
		   {
			   ex.printStackTrace();
			   result="no";   
		   }
		   return result;
	   }
}
