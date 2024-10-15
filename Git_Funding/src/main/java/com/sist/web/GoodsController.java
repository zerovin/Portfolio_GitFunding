package com.sist.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

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
}
