package com.sist.web;
import com.sist.vo.*;
import java.util.*;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
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
	
	@GetMapping(value="qna_list_vue.do", produces = "text/plain;charset=UTF-8")
	public String qna_list(int page) throws Exception {
		int rowSize=10;
	    if (page < 1) {
	        page = 1; // 페이지 번호가 1보다 작으면 1로 설정
	    }
		int start=(rowSize*page)-(rowSize-1);
		int end=rowSize*page;
		List<QnaVO> list=cService.qnaListData(start,end);
		int count=cService.qnaRowCount();
		int totalpage=(int)(Math.ceil(count/(double)rowSize));
		count=count-((page*rowSize)-rowSize);
		
		final int BLOCK=10;
		int startPage=((page-1)/BLOCK*BLOCK)+1;
		int endPage=startPage+BLOCK-1;
		if(endPage>totalpage)
			endPage=totalpage; 
		
		
		Map map=new HashMap();
		map.put("list", list);
		map.put("startPage", startPage);
		map.put("endPage", endPage);
		map.put("count", count);
		map.put("curpage", page);
		map.put("totalpage", totalpage);
		
		ObjectMapper mapper=new ObjectMapper();
		String json=mapper.writeValueAsString(map);
		return json;
	}
	@PostMapping(value="qna_insert_vue.do", produces = "text/plain;charset=UTF-8")
	public String qnaInsert(QnaVO qnaVO, HttpSession session) throws Exception {
	    // 세션에서 ID 가져오기
	    String id = (String) session.getAttribute("userId");
	    qnaVO.setId(id); // QnaVO에 ID 설정
	    String name = (String) session.getAttribute("userName");
	    qnaVO.setName(name); // QnaVO에 ID 설정
	    String nickname = cService.nicknameNullCheck(id);
	    qnaVO.setNickname(nickname); // nickname 설정
	    // 서비스에서 닉네임 체크 및 QnaVO에 설정
	    cService.qnaInsert(qnaVO); // QnaService 호출
	    
	    return "success";
	}
}
