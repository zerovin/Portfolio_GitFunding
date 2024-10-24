package com.sist.web;
import java.text.DecimalFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.sist.vo.*;
import com.fasterxml.jackson.core.JsonParser;
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
	public String goodsListData(int page , String cate , String cateInfo , String fd) throws Exception {
		int rowsize=12;
		int start=(page*rowsize)-(rowsize-1);
		int end=page*rowsize;
		int discount;
		int price;
		
		Map map=new HashMap();
		map.put("start", start);
		map.put("end", end);
		if(fd.equals("")) {
			map.put("cate", cate);
		}else {
			map.put("cate", fd);
		}
		map.put("cateInfo", cateInfo);
		List<GoodsVO> list=gService.goodsListData(map);
		for(GoodsVO vo:list) {
			discount=Integer.parseInt(vo.getDiscount().replaceAll("[^0-9]", ""));
			price=Integer.parseInt(vo.getPrice().replaceAll("[^0-9]", ""));
			
			String realprice=df.format(price*(100-discount)/10000*100)+"원";
			vo.setRealprice(realprice);
		}

		int total=0;
		if(cateInfo.equals("1") || cateInfo.equals("")) {
			map.put("cateInfo", "cate1");
		}else if(cateInfo.equals("2")) {
			map.put("cateInfo", "cate2");
		}else if(cateInfo.equals("3")) {
			map.put("cateInfo", "cate3");
		}else if(cateInfo.equals("4")) {
			map.put("cateInfo", "title");
		}
		total=gService.goodsTotalData(map);
		
		
		
		
		
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
		for(Goods2VO gvo:vo.getGvo()) {
			if(gvo.getEa()==0) {
				gvo.setOps(gvo.getOps()+"(품절)");
			}
		}
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
	public String order_ok(@RequestParam("cList") String cListJ,HttpServletRequest request,HttpSession session) throws Exception{
		String result="";
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
		if(email.equals("@")) {
			email=(String)session.getAttribute("email");
		}
		String address=request.getParameter("address");
		String send=request.getParameter("send");
		if(send.equals("")) {
			send=(String)session.getAttribute("userName");
		}
		String recv=request.getParameter("recv");
		String msg=request.getParameter("msg");
		String sendPhone=request.getParameter("sendPhone");
		if(sendPhone.equals("")) {
			sendPhone=(String)session.getAttribute("phone");
		}
		String recvPhone=request.getParameter("recvPhone");
		String id=(String)session.getAttribute("userId");
	
		Map map=new HashMap();
		
		
		
		try {
				
		
				if(!fg_no.equals("")) {
					String option=request.getParameter("option");
					String account=request.getParameter("account");
					int iaccount=Integer.parseInt(account);
					int fgno=Integer.parseInt(fg_no);
					map.put("fgno", fgno);
					map.put("ops", option);
					int ea=gService.goodsEaData(map);
					// 수량 검사
					if(ea<iaccount) {
						result=fg_no;
					}else {
						
						map.put("fgono", orderId);
						map.put("account", iaccount);
						
						gService.orderedDicInsert(map);
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
						
						result="ok";
					}
				}else if(fg_no.equals("")) {
					
					ObjectMapper mapper=new ObjectMapper();
					List<CartVO> cList= mapper.readValue( cListJ, mapper.getTypeFactory().constructCollectionType(List.class, CartVO.class));
					List<Integer> fgcnoList=new ArrayList<Integer>();
					for(int i=0;i<cList.size();i++) {
						map.put("fgno", cList.get(i).getFgno());
						map.put("ops", cList.get(i).getOps());
						int ea=gService.goodsEaData(map);
						if(ea<cList.get(i).getAccount()) {
							result=result+cList.get(i).getFgno()+",";
						}
						map.clear();
					}
					if(result.equals("")) {
						
						for(int i=0;i<cList.size();i++) {
							map.put("fgono", orderId);
							map.put("fgno", cList.get(i).getFgno());
							map.put("ops", cList.get(i).getOps());
							map.put("account", cList.get(i).getAccount());
							gService.orderedDicInsert(map);
							map.clear();
							fgcnoList.add(cList.get(i).getFgcno());
						}
						gService.cartDelete(fgcnoList);
						
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
						result="ok";
						
						
					}else {
						result.substring(0, result.length()-1);
					}
				}
				
		}
		catch(Exception ex) {
				result="no";
				ex.printStackTrace();
		}
		

		return result;
	}
	@GetMapping(value = "goods/order_ok_vue.do",produces = "text/plain;charset=utf-8")
	public String order_ok(String id) throws Exception{
		
			OrderGVO gvo=gService.orderSelect(id);
			gvo.setRecvAddress(gvo.getRecvAddress().replace("^", " "));
			List<OrderVO> oList=gService.orderInfo(gvo.getFgono());
			String info="";
			for(OrderVO vo:oList) {
				if(vo.getOps().equals("default")) {
					vo.setOps("기본");
				}
				info+=vo.getTitle()+"("+vo.getOps()+") : "+vo.getAccount()+"개 , ";
			}
			info=info.substring(0, info.lastIndexOf(",")-1);
			Map map=new HashMap();
			map.put("gvo", gvo);
			map.put("info", info);
			String json=jsonMaker(map);
		
		return json;
	}
}
