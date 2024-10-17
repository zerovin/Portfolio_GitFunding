package com.sist.web;

import java.text.SimpleDateFormat;
import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.sist.vo.*;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.service.*;

@RestController
public class NoticeRestController {
	@Autowired
	private NoticeService nService;
	
	@GetMapping(value = "notice/list_vue.do", produces = "text/plain; charset=UTF-8")
	public String notice_list(int page) throws Exception {
		int rowSize = 10;
		int start = (rowSize * page) - (rowSize - 1);
		int end = (rowSize * page);
		
		Map map = new HashMap();
		map.put("start", start);
		map.put("end", end);
		
		List<NoticeVO> list = nService.noticeListData(map);
		int count = nService.noticeRowCount();
		int totalpage = (int)(Math.ceil(count / (double) rowSize));
		count = count - ((page * rowSize) - rowSize);
		   
		String today = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		
		map.put("list", list);
		map.put("count", count);
		map.put("curpage", page);
		map.put("totalpage", totalpage);
		map.put("today", today);
		   
		   
	   ObjectMapper mapper = new ObjectMapper();
	   String json = mapper.writeValueAsString(map);
	   
	   return json;
	}
}
