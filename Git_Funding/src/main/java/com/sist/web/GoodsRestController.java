package com.sist.web;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.sist.vo.*;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.service.*;

@RestController
public class GoodsRestController {
	private GoodsService gService;
	private DecimalFormat df=new DecimalFormat();
	@Autowired
	public GoodsRestController(GoodsService service) {
		this.gService=service;
	}
	
	public String jsonMaker(Map map) throws Exception{
		  ObjectMapper mapper=new ObjectMapper();
		  String json=mapper.writeValueAsString(map);
		   
		  return json;
	}
	
	@GetMapping(value = "goods/list_vue.do",produces = "text/plain;charset=utf-8")
	public String goodsListData(int page) throws Exception {
		int rowsize=12;
		int start=(page*rowsize)-(rowsize-1);
		int end=page*rowsize;

		List<GoodsVO> list=gService.goodsListData(start, end);
		for(GoodsVO vo:list) {
			vo.setImg(gService.goodsImgdata(vo.getFgno()));
			int discount=Integer.parseInt(vo.getDiscount().replaceAll("[^0-9]", ""));
			int price=Integer.parseInt(vo.getPrice().replaceAll("[^0-9]", ""));
			
			String realprice=df.format(price*(100-discount)/100)+"원";
			vo.setRealprice(realprice);
			
		}
		
		Map map=new HashMap();
		map.put("list", list);
		
		String json=jsonMaker(map);
		return json;
	}

	private NumberFormat DecimalFormat(String string) {
		// TODO Auto-generated method stub
		return null;
	}
}
