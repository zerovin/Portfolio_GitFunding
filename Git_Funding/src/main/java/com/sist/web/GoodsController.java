package com.sist.web;

import java.text.DecimalFormat;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sist.service.GoodsService;
import com.sist.vo.GoodsVO;

@Controller
public class GoodsController {
	private GoodsService gService;
	
	@Autowired
	public GoodsController(GoodsService service) {
		this.gService=service;
	}
	
	@GetMapping("goods/cart.do")
	public String goods_cart() {
		return "goods/cart";
	}
	@GetMapping("goods/list.do")
	public String goods_list(String cate,String cateInfo,Model model) {
		
		model.addAttribute("cate",cate);
		model.addAttribute("cateInfo",cateInfo);
		
		return "goods/list";
	}
	@GetMapping("goods/order.do")
	public String goods_order() {
		return "goods/order";
	}
	@PostMapping("goods/orderDic.do")
	public String goods_orderDic(HttpServletRequest request,Model model) {
		String account=request.getParameter("account");
		String optionSelect=request.getParameter("optionSelect");
		String fg_no=request.getParameter("fg_no");
		
		model.addAttribute("account");
		model.addAttribute("option",optionSelect);
		model.addAttribute("fg_no",fg_no);
		
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
		
		model.addAttribute("fg_no",fgno);
		
		return "goods/detail";
	}
}
