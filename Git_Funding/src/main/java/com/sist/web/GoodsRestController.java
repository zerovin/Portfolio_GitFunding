package com.sist.web;
import java.text.DecimalFormat;
import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
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
	public String goodsListData(int page , String cate) throws Exception {
		int rowsize=12;
		int start=(page*rowsize)-(rowsize-1);
		int end=page*rowsize;
		int discount;
		int price;
		List<GoodsVO> list=gService.goodsListData(start, end , cate);
		for(GoodsVO vo:list) {
			discount=Integer.parseInt(vo.getDiscount().replaceAll("[^0-9]", ""));
			price=Integer.parseInt(vo.getPrice().replaceAll("[^0-9]", ""));
			
			String realprice=df.format(price*(100-discount)/10000*100)+"원";
			vo.setRealprice(realprice);
		}
		int total=gService.goodsTotalData(cate);
		int totalpage=(int)Math.ceil(total/(double)rowsize);
		
		final int BLOCK=10;
		int startPage=((page-1)/BLOCK*BLOCK)+1;
		int endPage=((page-1)/BLOCK*BLOCK)+BLOCK;
		   
		if(endPage>totalpage)
			 endPage=totalpage;
		
		
		Map map=new HashMap();
		map.put("list", list);
		map.put("curpage", page);
		map.put("totalpage", totalpage);
		map.put("startpage", startPage);
		map.put("endpage", endPage);
		
		String json=jsonMaker(map);
		return json;
	}
	
	@PostMapping(value = "goods/buyInfo_vue.do",produces = "text/plain;charset=utf-8")
	public String goodsBuy(int gno) throws Exception{
		return "짜장";
	}
}
