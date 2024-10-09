package com.sist.web;
import com.sist.vo.*;
import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.service.*;
@RestController
@RequestMapping("community/")
public class CommunityRestController {
	@Autowired
	private CommunityService cService;
	
	@GetMapping(value="faq_list_vue.do", produces = "text/plain;charset=UTF-8")
	public String faq_list(String cate) throws Exception {
		List<FaqVO> list=cService.faqListData(cate);
		ObjectMapper mapper=new ObjectMapper();
		String json=mapper.writeValueAsString(list);
		return json;
	}
}
