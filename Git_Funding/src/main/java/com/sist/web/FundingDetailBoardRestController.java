package com.sist.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.*;

import javax.servlet.http.HttpSession;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.service.*;
import com.sist.vo.*;
@RestController
public class FundingDetailBoardRestController {
	@Autowired
	private FundingDetailBoardService bService;
	
	@GetMapping(value="funding/notice_list_vue.do", produces="text/plain;charset=UTF-8")
	public String funding_notice_list(int fno, int page) throws Exception{
		int rowSize=10;
		int start=(rowSize*page)-(rowSize-1);
		int end=rowSize*page;
		Map map=new HashMap();
		map.put("fno", fno);
		map.put("start", start);
		map.put("end", end);
		List<FundingDetailNoticeVO> list=bService.fundingNoticeListData(map);
		int totalpage=bService.fundingNoticeTotalPage();
		
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
	
	@GetMapping(value="funding/notice_detail_vue.do", produces="text/plain;charset=UTF-8")
	public String funding_notice_detail(int dnno) throws Exception{
		FundingDetailNoticeVO vo=bService.fundingNoticeDetailData(dnno);
		ObjectMapper mapper=new ObjectMapper();
		String json=mapper.writeValueAsString(vo);
		return json;
	}
	
	@PostMapping(value="funding/community_insert.do", produces="text/plain;charset=UTF-8")
	public String funding_community_insert(FundingDetailCommVO vo, HttpSession session) {
		String result="";
		try {
			String id=(String)session.getAttribute("userId");
			vo.setUserId(id);
			bService.fundingCommInsert(vo);
			result="ok";
		}catch(Exception ex) {
			result=ex.getMessage();
		}
		return result;
	}
	
	@GetMapping(value="funding/comm_list_vue.do", produces="text/plain;charset=UTF-8")
	public String funding_comm_list(int fno) throws Exception{
		List<FundingDetailCommVO> list=bService.fundingCommListData(fno);
		for(FundingDetailCommVO vo:list) {
			if(vo.getMvo().getNickname()==null) {
				vo.getMvo().setNickname(vo.getMvo().getUserName());
			}
		}
		ObjectMapper mapper=new ObjectMapper();
		String json=mapper.writeValueAsString(list);
		return json;
	}
	
	@GetMapping(value="funding/comm_update_data.do", produces="text/plain;charset=UTF-8")
	public String funding_comm_update_data(int dcno) throws Exception{
		FundingDetailCommVO vo=bService.fundingCommUpdateData(dcno);
		ObjectMapper mapper=new ObjectMapper();
		String json=mapper.writeValueAsString(vo);
		return json;
	}
	
	@PostMapping(value="funding/comm_update.do", produces="text/plain;charset=UTF-8")
	public String funding_comm_update(FundingDetailCommVO vo) {
		String result="";
		try {
			bService.fundingCommUpdate(vo);
			result="ok";
		}catch(Exception ex) {
			result=ex.getMessage();
		}
		return result;
	}
	
	@GetMapping(value="funding/comm_delete.do", produces="text/plain;charset=UTF-8")
	public String funding_comm_delete(int dcno) {
		String result="";
		try {
			bService.fundingCommDelete(dcno);
			result="ok";
		}catch(Exception ex) {
			result=ex.getMessage();
		}
		return result;
	}
	
	@PostMapping(value="funding/reply_insert.do", produces="text/plain;charset=UTF-8")
	public String funding_comm_reply_insert(int dcno, FundingDetailCommVO vo, HttpSession session) {
		String result="";
		try {
			String userId=(String)session.getAttribute("userId");
			vo.setUserId(userId);
			bService.commReplyInsert(dcno, vo);
			result="ok";
		}catch(Exception ex) {
			result=ex.getMessage();
		}
		return result;
	}
}
