package com.sist.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.sist.vo.*;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.service.*;
@RestController
public class MypageRestController {
	@Autowired
	private MypageService mService;
	@Autowired
	private FundingService fService;
	@Autowired
	private GoodsService gService;
	
	@GetMapping(value="mypage/menu_vue.do", produces = "text/plain;charset=UTF-8")
	public String mypage_menu(HttpSession session,HttpServletRequest request) throws Exception {
	    String userId = (String) session.getAttribute("userId");

	    // 사용자 기본 정보 가져오기
	    MemberVO vo = mService.mypageInfoData(userId);

	    // 알림 신청 수 가져오기
	    int alertCount = mService.fundingAlertCount(userId);

	    // 펀딩 구매 목록 수 가져오기
	    int fundingCount = mService.getTotalRewardBuyCount(userId);
	    
	    // 상품 구매 목록 수 가져오기
	    int storeCount = mService.goodsBuyTotalCount(userId);
	    
	    Cookie[] cookies = request.getCookies();
	    List<FundingVO> cookie_list = new ArrayList<>();
	    if (cookies != null) {
	        for (int i = cookies.length - 1; i >= 0; i--) {
	            if (cookies[i].getName().startsWith("funding_")) {
	                String fno = cookies[i].getValue();
	                FundingVO fundingVO = fService.mainCookieListData(Integer.parseInt(fno));
	                int percent = (int) (Math.round(fundingVO.getTotalprice() / (double) fundingVO.getTargetprice() * 100));
	                fundingVO.setFm_percent(new DecimalFormat("###,###").format(percent));
	                // 상태 설정 (오픈 전/후 여부 판단)
	                SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	                Date now = new Date();
	                if (now.before(fundingVO.getStartdate())) {
	                    fundingVO.setOf(1);  // 오픈 전 상태
	                }
	                cookie_list.add(fundingVO);
	            }
	        }
	    }


	    // 알림 신청 수와 구매 목록 수를 VO에 포함하거나 새로운 Map에 담기
	    Map map= new HashMap<>();
	    map.put("userInfo", vo);
	    map.put("alertCount", alertCount);
	    map.put("fundingCount", fundingCount);
	    map.put("storeCount", storeCount);
	    map.put("latest_list", cookie_list);
	    // JSON으로 변환
	    ObjectMapper mapper = new ObjectMapper();
	    String json = mapper.writeValueAsString(map);

	    return json;
	}
	
	@PostMapping(value="mypage/set_nick_vue.do",produces = "text/plain;charset=UTF-8")
	   public String board_insert(HttpSession session,String nickname) throws Exception {
		   String result="";
		   String userId=(String)session.getAttribute("userId");
		   if (userId == null) {
			   return "no"; 
		   }
		   Map map=new HashMap();
		   map.put("userId", userId);
		   map.put("nickname", nickname);
		   try
		   {
			   result="yes";
			   mService.SetNickname(map);
		   }catch(Exception ex)
		   {
			   ex.printStackTrace();
			   result="no";   
		   }
		   return result;
	   }
	@PostMapping(value = "mypage/update_user_info.do", produces = "text/plain;charset=UTF-8")
	public String update_user_info(HttpSession session,MemberVO vo) throws Exception {
		String result="";
		String userId=(String)session.getAttribute("userId");
		vo.setUserId(userId);
		try {
			mService.mypageInfoUpdate(vo);
			result="yes";
		}catch(Exception ex) {
			result=ex.getMessage();
		}
		return result;
	}
	// 마이페이지 펀딩 찜
	@GetMapping(value="mypage/jjim_vue.do",produces = "text/plain;charset=UTF-8")
	public String mypage_jjim(HttpSession session) throws Exception {
		String userId=(String)session.getAttribute("userId");
		List<WishVO> list = mService.fundingWishList(userId);
		ObjectMapper mapper=new ObjectMapper();
		String json=mapper.writeValueAsString(list);
		return json;
	}
	@GetMapping(value="mypage/jjim_count_vue.do", produces = "application/json;charset=UTF-8")
	public int mypage_jjim_count(HttpSession session) throws Exception {
	    String userId = (String) session.getAttribute("userId");
	    int count = mService.fundingWishCount(userId);
	    return count; 
	}
	// 펀딩 오픈 알림
	@GetMapping(value="mypage/alert_vue.do",produces = "text/plain;charset=UTF-8")
	public String alert_jjim(HttpSession session) throws Exception {
		String userId=(String)session.getAttribute("userId");
		List<AlertVO> list = mService.fundingAlertList(userId);
		ObjectMapper mapper=new ObjectMapper();
		String json=mapper.writeValueAsString(list);
		return json;
	}
	@GetMapping(value="mypage/alert_count_vue.do", produces = "application/json;charset=UTF-8")
	public int mypage_alert_count(HttpSession session) throws Exception {
		String userId = (String) session.getAttribute("userId");
		int count = mService.fundingAlertCount(userId);	
		return count; 
	}
	
	@GetMapping(value="mypage/funding_buy_vue.do", produces = "text/plain;charset=UTF-8")
	public String mypagePurchaseList(HttpSession session, int page) throws Exception {
	    int rowSize = 6; // 한 페이지에 보여줄 항목 수
	    int start = (rowSize * page) - (rowSize - 1);
	    int end = rowSize * page;
	    String userId=(String)session.getAttribute("userId");

	    Map map = new HashMap();
	    map.put("userId", userId);
	    map.put("start", start);
	    map.put("end", end);
	    int totalpage=mService.getTotalRewardBuyCount(userId);
		
		final int BLOCK=6;
		int startpage=((page-1)/BLOCK*BLOCK)+1;
		int endpage=((page-1)/BLOCK*BLOCK)+BLOCK;
		if(endpage>totalpage) {
			endpage=totalpage;
		}
		List<RewardBuyVO> list=mService.getRewardBuyList(map);

	    map = new HashMap();
	    map.put("list", list);
	    map.put("curpage", page);
	    map.put("startpage", startpage);
	    map.put("totalpage", totalpage);

	    ObjectMapper mapper = new ObjectMapper();
	    String json = mapper.writeValueAsString(map);

	    return json;
	}
	
	
	@GetMapping(value="mypage/community_vue.do", produces = "text/plain;charset=UTF-8")
	public String mypageCommunity(HttpSession session, int page) throws Exception {
		int rowSize = 4; // 한 페이지에 보여줄 항목 수
		int start = (rowSize * page) - (rowSize - 1);
		int end = rowSize * page;
		String userId=(String)session.getAttribute("userId");
		
		Map map = new HashMap();
		map.put("userId", userId);
		map.put("start", start);
		map.put("end", end);
		int totalpage=mService.myFundingCommuTotalPage(userId);
		int count=mService.myFundingCommuListCount(userId);
		
		final int BLOCK=5;
		int startpage=((page-1)/BLOCK*BLOCK)+1;
		int endPage=((page-1)/BLOCK*BLOCK)+BLOCK;
		if(endPage>totalpage) {
			endPage=totalpage;
		}
		List<FundingDetailCommVO> list=mService.myFundingCommuList(map);
		
		map = new HashMap();
		map.put("list", list);
		map.put("curpage", page);
		map.put("startpage", startpage);
		map.put("endPage", endPage);
		map.put("totalpage", totalpage);
		map.put("count", count);
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(map);
		
		return json;
	}
	

	@GetMapping(value="mypage/funding_buy_detail_vue.do", produces = "text/plain;charset=UTF-8")
	public String mypagePurchaseDetail(int rbno) throws Exception {

	    RewardBuyVO vo = mService.getPurchaseDetail(rbno);
	    ObjectMapper mapper = new ObjectMapper();
	    String json = mapper.writeValueAsString(vo);

	    return json;
	}

	// 스토어
	@GetMapping(value="mypage/store_order_vue.do" , produces = "text/plain;charset=UTF-8")
	public String mypageStore(int page , HttpSession session) throws Exception{
		
		
		int rowSize = 6; // 한 페이지에 보여줄 항목 수
	    int start = (rowSize * page) - (rowSize - 1);
	    int end = rowSize * page;
	    String id=(String)session.getAttribute("userId");

	    Map map = new HashMap();
	    map.put("id", id);
	    map.put("start", start);
	    map.put("end", end);
	    int totalpage=gService.mypageStoreTotal(id);
		
		final int BLOCK=6;
		int startpage=((page-1)/BLOCK*BLOCK)+1;
		int endpage=((page-1)/BLOCK*BLOCK)+BLOCK;
		if(endpage>totalpage) {
			endpage=totalpage;
		}
		List<OrderGVO> list=gService.mypageStore(map);

	    map = new HashMap();
	    map.put("list", list);
	    map.put("curpage", page);
	    map.put("startpage", startpage);
	    map.put("totalpage", totalpage);

	    ObjectMapper mapper = new ObjectMapper();
	    String json = mapper.writeValueAsString(map);

	    return json;
	}
	
	@GetMapping(value = "mypage/store_buy_detail_vue.do",produces = "text/plain;charset=utf-8")
	public String order_ok(String fgono) throws Exception{
		
			OrderGVO gvo=gService.mypageOrder(fgono);
			gvo.setRecvAddress(gvo.getRecvAddress().replace("^", " "));
			List<OrderVO> oList=gService.orderInfo(fgono);
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

		    ObjectMapper mapper = new ObjectMapper();
		    String json = mapper.writeValueAsString(map);

		    return json;
		
	}

}
