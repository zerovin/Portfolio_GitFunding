package com.sist.web;
import java.text.DecimalFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
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
	public String goodsListData(int page , String cate , String cateInfo) throws Exception {
		int rowsize=12;
		int start=(page*rowsize)-(rowsize-1);
		int end=page*rowsize;
		int discount;
		int price;
		
		Map map=new HashMap();
		map.put("start", start);
		map.put("end", end);
		map.put("cate", cate);
		map.put("cateInfo", cateInfo);
		List<GoodsVO> list=gService.goodsListData(map);
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
		
		
		
		
		map.clear();
		map.put("list", list);
		map.put("curpage", page);
		map.put("totalpage", totalpage);
		map.put("startpage", startPage);
		map.put("endpage", endPage);
		
		String json=jsonMaker(map);
		return json;
	}
	@GetMapping(value = "goods/detail_vue.do",produces = "text/plain;charset=utf-8")
	public String goodsDetail(int fg_no) throws Exception{
		
		
		GoodsVO vo=gService.goodsDetailData(fg_no);
		int discount=Integer.parseInt(vo.getDiscount().replaceAll("[^0-9]", ""));
		int price=Integer.parseInt(vo.getPrice().replaceAll("[^0-9]", ""));
		
		DecimalFormat df=new DecimalFormat();
		
		String realprice=df.format(price*(100-discount)/10000*100)+"원";
		
		vo.setRealprice(realprice);
		
		Map map=new HashMap();
		map.put("fg_no", fg_no);
		map.put("vo", vo);
		map.put("imgs", vo.getImgs());
		map.put("detail",vo.getDetail());
		map.put("gvo", vo.getGvo());
		map.put("thumb", vo.getImgs().get(0));
		map.put("ops", vo.getGvo().get(0).getOps());
		String json=jsonMaker(map);
		return json;
	}
	
	@PostMapping(value = "goods/cart_insert_vue.do",produces = "text/plain;charset=utf-8")
	public String cart_insert(int ea,int fg_no,String price,String ops,HttpSession session) throws Exception{
		String result="no";
		String id=(String)session.getAttribute("userId");
		Map map=new HashMap();
		map.put("fgno", fg_no);
		map.put("id", id);
		map.put("account", ea);
		map.put("ops", ops);
		map.put("price", price);
		
		int count=gService.cartCount(map);
		if(count>0) {
			try {
				gService.cartUpdate(map);
				result="ok";
			}catch(Exception ex) {
				ex.printStackTrace();
			}
		}else {
			try {
				gService.cartInsert(map);
				result="ok";
			}catch(Exception ex) {
				ex.printStackTrace();
			}
		}
		return result;
	}
	@PostMapping(value = "goods/cartList_vue.do",produces = "text/plain;charset=utf-8")
	public String cart_list(String id) throws Exception{
		
		List<CartVO> list=gService.cartListData(id);
		
		Map map=new HashMap();
		map.put("cList", list);
		
		String json=jsonMaker(map);
		return json;
	}
	@PostMapping(value="goods/cart_delete.do",produces = "text/plain;charset=utf-8")
	public String cart_delete(@RequestParam List<Integer> selected) {
		String result="no";
		try {
			for(int i:selected) {
				gService.cartDelete(i);
			}
			result="ok";
		}catch(Exception ex) {
			
		}

		return result;
	}
}
