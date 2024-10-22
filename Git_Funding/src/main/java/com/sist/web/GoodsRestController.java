package com.sist.web;
import java.text.DecimalFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections.map.HashedMap;
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

				gService.cartDelete(selected);

			result="ok";
		}catch(Exception ex) {
			
		}

		return result;
	}
	@PostMapping(value = "goods/order_ok_vue.do",produces = "text/plain;charset=utf-8")
	public String order_ok(@RequestParam("cList") String cList,HttpServletRequest request,HttpSession session) {
		String result="no";
		/*
    		     	formData.append("cList",JSON.stringify(this.orderList))
    		     	formData.append("fg_no",this.fg_no)
    		     	formData.append("option",this.option)
    		     	formData.append("totalpay",this.totalpay)
    		     	formData.append("orderId","F_GOODS_"+new Date().getTime()+this.id)
    		     	formData.append("email",this.email+this.email_domain)
    		     	formData.append("address",this.post+this.addr1+this.addr2)
    		     	formData.append("send",this.send)
    		     	formData.append("recv",this.recv)
    		     	formData.append("msg",this.msg)
    		     	formData.append("sendPhone",this.sendPhone)
    		     	formData.append("recvPhone",this.recvPhone)
		 */
		
		String fg_no=request.getParameter("fg_no");
		
		String totalpay=request.getParameter("totalpay");
		String orderId=request.getParameter("orderId");
		String email=request.getParameter("email");
		String address=request.getParameter("email");
		String send=request.getParameter("send");
		String recv=request.getParameter("recv");
		String msg=request.getParameter("msg");
		String sendPhone=request.getParameter("sendPhone");
		String recvPhone=request.getParameter("recvPhone");
		String id=(String)session.getAttribute("userId");
	
		Map map=new HashMap();
		map.put("fgono", orderId);
		map.put("email", email);
		map.put("recvaddress",address);
		map.put("send", send);
		map.put("recv", recv);
		map.put("msg", msg);
		map.put("sendPhone", sendPhone);
		map.put("recvPhone", recvPhone);
		map.put("id", id);
		map.put("payment", totalpay);
		gService.orderInsert(map);
		map.clear();
		try {
				if(fg_no!=null) {
					String option=request.getParameter("option");
					String account=request.getParameter("account");
					int iaccount=Integer.parseInt(account);
					int fgno=Integer.parseInt(fg_no);
		
					map.put("fgono", orderId);
					map.put("ops", option);
					map.put("account", iaccount);
					map.put("fgno", fgno);
					gService.orderedDicInsert(map);
					
					result="ok";
				}else if(fg_no==null) {
			
				
					ObjectMapper mapper=new ObjectMapper();
					List<CartVO> cartList= mapper.readValue(cList, List.class);
					List<Integer> fgcnoList=new ArrayList<Integer>();
					for(int i=0;i<cartList.size();i++) {
						map.put("fgono", orderId);
						map.put("ops", cartList.get(i).getOps());
						map.put("account", cartList.get(i).getAccount());
						map.put("fgno", cartList.get(i).getFgno());
						gService.orderedDicInsert(map);
						map.clear();
						fgcnoList.add(cartList.get(i).getFgcno());
						
					}
					
					gService.cartDelete(fgcnoList);
					result="ok";
				
				}
		}
		catch(Exception ex) {
				result=ex.getMessage();
		}
		

		return result;
	}
}
