package com.sist.web;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class GoodsController {
	@GetMapping("goods/cart.do")
	public String goods_cart() {
		return "goods/cart";
	}
	@GetMapping("goods/list.do")
	public String goods_list() {
		return "goods/list";
	}
	@GetMapping("goods/order.do")
	public String goods_order() {
		return "goods/order";
	}
	@GetMapping("goods/order_ok.do")
	public String goods_order_ok() {
		return "goods/order_ok";
	}
	@GetMapping("goods/detail_before.do")
	   public String goods_detail_before(int fgno,HttpServletResponse response,RedirectAttributes ra)
	   {
		   // forward => Model를 이용해서 데이터 전송 
		   // redirect => RedirectAttributes이용해서 데이터 전송 
		   Cookie cookie=new Cookie("food_"+fgno, String.valueOf(fgno));
		   cookie.setMaxAge(60*60*24);
		   cookie.setPath("/");
		   response.addCookie(cookie);
		   ra.addAttribute("fgno", fgno);// ?fno=1
		   return "redirect:../goods/detail.do";
	   }
	@GetMapping("goods/detail.do")
	public String goods_detail(int fgno,Model model) {
		
		return "goods/detail";
	}
}
