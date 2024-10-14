package com.sist.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.*;

import javax.servlet.http.HttpSession;

import java.text.*;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.service.*;
import com.sist.vo.*;
@RestController
public class FundingRestController {
	@Autowired
	private FundingService fService;
	
	@GetMapping(value="funding/funding_list_vue.do",produces="text/plain;charset=UTF-8")
	public String funding_list(int page) throws Exception{
		int rowSize=12;
		int start=(rowSize*page)-(rowSize-1);
		int end=rowSize*page;
		Map map=new HashMap();
		map.put("start", start);
		map.put("end", end);
		
		List<FundingVO> list=fService.fundingListData(map);
		for(FundingVO vo:list) {
			vo.setFm_totalprice(new DecimalFormat("###,###").format(vo.getTotalprice()));
			int percent=(int)(Math.round(vo.getTotalprice()/(double)vo.getTargetprice()*100));
			vo.setFm_percent(new DecimalFormat("###,###").format(percent));
			if(percent>=100) {
				percent=100;
			}
			vo.setPercent(percent);
			
			Date today=new Date();
			Date endday=new SimpleDateFormat("yyyyMMdd").parse(vo.getEndday());
			long gap=endday.getTime()-today.getTime();
			vo.setDday((int)(gap/(24*60*60*1000)+1));
			
		}
		
		int totalpage=fService.fundingTotalPage();
		
		final int BLOCK=5;
		int startpage=((page-1)/BLOCK*BLOCK)+1;
		int endpage=((page-1)/BLOCK*BLOCK)+BLOCK;
		if(endpage>totalpage) {
			endpage=totalpage;
		}
		
		map=new HashMap();
		map.put("list", list);
		map.put("curpage", page);
		map.put("totalpage", totalpage);
		map.put("startpage", startpage);
		map.put("endpage", endpage);
		
		ObjectMapper mapper=new ObjectMapper();
		String json=mapper.writeValueAsString(map);
		return json;
	}
	
	@GetMapping(value="funding/open_list_vue.do", produces="text/plain;charset=UTF-8")
	public String funding_open_list(int page) throws Exception{
		int rowSize=12;
		int start=(rowSize*page)-(rowSize-1);
		int end=rowSize*page;
		Map map=new HashMap();
		map.put("start", start);
		map.put("end", end);
		
		List<FundingVO> list=fService.openListData(map);
		int totalpage=fService.openTotalPage();
		
		final int BLOCK=5;
		int startpage=((page-1)/BLOCK*BLOCK)+1;
		int endpage=((page-1)/BLOCK*BLOCK)+BLOCK;
		if(endpage>totalpage) {
			endpage=totalpage;
		}
		
		map=new HashMap();
		map.put("list", list);
		map.put("curpage", page);
		map.put("totalpage", totalpage);
		map.put("startpage", startpage);
		map.put("endpage", endpage);
		
		ObjectMapper mapper=new ObjectMapper();
		String json=mapper.writeValueAsString(map);
		return json;
	}
	
	@GetMapping(value="funding/alert_update.do", produces="text/plain;charset=UTF-8")
	public String funding_alert_update(int fno, HttpSession session) {
		String result="";
		try {
			String id=(String)session.getAttribute("userId");
			Map map=new HashMap();
			map.put("userId", id);
			map.put("fno", fno);
			fService.fundingAlertUpdate(fno);
			fService.fundingAlertInsert(map);
			result="ok";
		}catch(Exception ex) {
			result=ex.getMessage();
		}
		return result;			
	}
}
