package com.sist.web;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.sist.vo.*;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.service.*;

@RestController
public class ProjectRestController {
	@Autowired
	private MypageService mService;
	
	@Autowired
	private RewardService rService;
	
	@GetMapping(value = "project/home_vue.do", produces = "application/json; charset=UTF-8")
	public String homePage(HttpSession session) throws JsonProcessingException {
	    Map<String, Object> response = new HashMap<>();
	    String nickname = (String) session.getAttribute("nickname");
	    String userName = (String) session.getAttribute("userName"); // 필요하다면 userName도 가져옵니다.
	    
	    response.put("nickname", nickname);
	    response.put("userName", userName);
	    
	    ObjectMapper mapper = new ObjectMapper();
	    return mapper.writeValueAsString(response);
	}
	
	// 프로젝트 관리자 펀딩 내역
	@GetMapping(value="funding/my_funding_list_vue.do", produces="text/plain;charset=UTF-8")
	public String myFundingList(int page, HttpSession session) throws Exception {
		// 세션에서 userId 가져오기
		String userId = (String)session.getAttribute("userId");
		
		// 세션에 userId가 없는 경우 처리
		if (userId == null) {
			return "{\"error\": \"User not logged in\"}";
		}
		
	    int rowSize = 4;  // 페이지당 4개의 펀딩 정보
	    int start = (rowSize * page) - (rowSize - 1);
	    int end = rowSize * page;
	    
	    Map<String, Object> map = new HashMap<>();
	    map.put("userId", userId);
	    map.put("start", start);
	    map.put("end", end);
	    
	    List<FundingVO> list = mService.myFundingListData(map);
	    for (FundingVO vo : list) {
	        vo.setFm_totalprice(new DecimalFormat("###,###").format(vo.getTotalprice()));
	        int percent = (int) (Math.round(vo.getTotalprice() / (double) vo.getTargetprice() * 100));
	        vo.setFm_percent(new DecimalFormat("###,###").format(percent));

	        Date today = new Date();
	        Date endday = new SimpleDateFormat("yyyyMMdd").parse(vo.getEndday());
	        long gap = endday.getTime() - today.getTime();
	        vo.setDday((int) (gap / (24 * 60 * 60 * 1000) + 1));
	    }

	    int totalpage = mService.myFundingTotalPage(userId);

	    final int BLOCK = 5;
	    int startpage = ((page - 1) / BLOCK * BLOCK) + 1;
	    int endpage = ((page - 1) / BLOCK * BLOCK) + BLOCK;
	    if (endpage > totalpage) {
	        endpage = totalpage;
	    }
	    int count=mService.myFundingTotalCount(userId);
	    
	    List<FundingVO> total_list=mService.myFundingTotalData(userId);
	    int allalert=0;
	    int allwish=0;
	    int allbacking=0;
	    int allprice=0;
	    for(FundingVO tvo:total_list) {
	    	allalert+=tvo.getAlert();
	    	allwish+=tvo.getWish();
	    	allbacking+=tvo.getBacking();
	    	allprice+=tvo.getTotalprice();
	    }
	    
	    map = new HashMap<>();
	    map.put("list", list);
	    map.put("curpage", page);
	    map.put("totalpage", totalpage);
	    map.put("startpage", startpage);
	    map.put("endpage", endpage);
	    map.put("count", count);
	    map.put("allalert", allalert);
	    map.put("allwish", allwish);
	    map.put("allbacking", allbacking);
	    map.put("allprice", allprice);

	    ObjectMapper mapper = new ObjectMapper();
	    String json = mapper.writeValueAsString(map);
	    return json;
	}
	
	@GetMapping(value = "project/reward_detail_vue.do", produces = "text/plain; charset=UTF-8")
	public String reward_detail(int fno) throws Exception {
		List<RewardVO> list = rService.project_rewardDetailList(fno);
			
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(list);
				
		return json;
	}
}
