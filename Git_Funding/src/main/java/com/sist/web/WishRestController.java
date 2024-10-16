package com.sist.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.*;

import javax.servlet.http.HttpSession;

import com.sist.service.*;
import com.sist.vo.*;
@RestController
public class WishRestController {
	@Autowired
	private WishService wService;
	
	@GetMapping("wish/update.do")
	public String wish_update(int fno, int cate, HttpSession session) {
		String result="";
		try {
			String id=(String)session.getAttribute("userId");
			wService.fundingWishUpdate(fno);
			
			WishVO vo=new WishVO();
			vo.setUserId(id);
			vo.setPno(fno);
			vo.setCate(cate);
			wService.fundingWishInsert(vo);
			result="ok";
		}catch(Exception ex) {
			result=ex.getMessage();
		}
		return result;
	}
	
	@GetMapping("wish/delete.do")
	public String wish_delete(int fno, int cate, HttpSession session) {
		String result="";
		try {
			String id=(String)session.getAttribute("userId");
			wService.fundingWishtDecr(fno);
			
			WishVO vo=new WishVO();
			vo.setUserId(id);
			vo.setPno(fno);
			vo.setCate(cate);
			wService.fundingWishDelete(vo);
			result="ok";
		}catch(Exception ex) {
			result=ex.getMessage();
		}
		return result;
	}
}
