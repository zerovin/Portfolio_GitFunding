package com.sist.web;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.sist.vo.*;

import oracle.net.aso.m;

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
	
	// 리워드 상세
	@GetMapping(value = "project/reward_detail_vue.do", produces = "text/plain; charset=UTF-8")
	public String reward_detail(int fno, HttpSession session) throws Exception {
		String userId = (String)session.getAttribute("userId");
		
		List<RewardVO> list = rService.project_rewardDetailList(fno);
		
		Map map = new HashMap();
		map.put("userId", userId);
		map.put("list", list);
		
		
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(map);
				
		return json;
	}
	
	// 리워드 등록
	@PostMapping(value = "project/reward_insert_vue.do", produces = "text/plain; charset=UTF-8")
	public String reward_insert(RewardVO vo, HttpSession session) {
		String result = "";
		vo.setUserId((String)session.getAttribute("userId"));
		vo.setAmount(vo.getLimit());
	    try {
	        rService.fundingRewardInsert(vo); // 리워드 정보 DB에 저장
	        result = "yes";
	    } catch (Exception ex) {
	        result = ex.getMessage(); // 에러 발생 시 메시지 반환
	    }
	    
	    return result; // 결과 반환
	}
	
	// 리워드 수정
	@PostMapping(value = "project/reward_update_vue.do", produces = "text/plain; charset=UTF-8")
	public String reward_update(int rno, HttpSession session) throws Exception {
		String result = "";
		Map map = new HashMap();
		map.put("rno", rno);
		
		RewardVO vo = rService.fundingRewardUpdateData(map);
		map.put("vo", vo);
		
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(map);
		
		return json;
	}
	
	// 리워드 수정OK
	@PostMapping(value = "project/reward_update_vue_ok.do", produces = "text/plain; charset=UTF-8")
	public String reward_update_ok(RewardVO vo, HttpSession session) {
		System.out.println(vo);
		String result = "";
		vo.setUserId((String)session.getAttribute("userId"));
		vo.setAmount(vo.getLimit());
		Map map = new HashMap();
		map.put("vo", vo);
		try {
			rService.fundingRewardUpdate(map); // 리워드 정보 DB에 저장
			result = "yes";
		} catch (Exception ex) {
			result = ex.getMessage(); // 에러 발생 시 메시지 반환
		}
		
		return result; // 결과 반환
	}
	
	
	// 리워드 삭제
	@GetMapping(value = "project/reward_delete_vue.do", produces = "text/plain; charset=UTF-8") 
	public String reward_delete(int rno) throws Exception {
	    String result = "";
	    try {
	    	Map map = new HashMap();
	    	map.put("rno", rno);
	        rService.rewardDelete(map);
	        
	        result = "yes";
	    } catch (Exception e) {
	        e.printStackTrace();
	        result = "no";
	    }

	    return result;
	}
}
