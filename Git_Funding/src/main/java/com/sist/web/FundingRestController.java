package com.sist.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.*;
import java.time.*;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.File;
import java.io.IOException;
import java.text.*;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.service.*;
import com.sist.vo.*;
@RestController
public class FundingRestController {
	@Autowired
	private FundingService fService;
	
	@Autowired
	private WishService wService;
	
	@GetMapping(value="funding/main_vue.do",produces="text/plain;charset=UTF-8")
	public String main_list() throws Exception{
		List<FundingVO> wish_list=fService.mainWishListData();
		for(FundingVO wvo:wish_list) {
			int percent=(int)(Math.round(wvo.getTotalprice()/(double)wvo.getTargetprice()*100));
			wvo.setFm_percent(new DecimalFormat("###,###").format(percent));
		}
		List<FundingVO> backing_list=fService.mainBackingListData();
		for(FundingVO bvo:backing_list) {
			int percent=(int)(Math.round(bvo.getTotalprice()/(double)bvo.getTargetprice()*100));
			bvo.setFm_percent(new DecimalFormat("###,###").format(percent));
		}
		List<FundingVO> today_list=fService.mainTodayListData();
		for(FundingVO tvo:today_list) {
			int percent=(int)(Math.round(tvo.getTotalprice()/(double)tvo.getTargetprice()*100));
			tvo.setFm_percent(new DecimalFormat("###,###").format(percent));
		}
		List<FundingVO> deadline_list=fService.mainDeadlineListData();
		for(FundingVO dvo:deadline_list) {
			int percent=(int)(Math.round(dvo.getTotalprice()/(double)dvo.getTargetprice()*100));
			dvo.setFm_percent(new DecimalFormat("###,###").format(percent));
		}
		
		HttpServletRequest request=((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		
		Cookie[] cookies=request.getCookies();
		List<FundingVO> cookie_list=new ArrayList<FundingVO>();
		if(cookies!=null) {
			for(int i=cookies.length-1;i>=0;i--) {
				if(cookies[i].getName().startsWith("funding_")) {
					String fno=cookies[i].getValue();
					FundingVO vo=fService.mainCookieListData(Integer.parseInt(fno));
					int percent=(int)(Math.round(vo.getTotalprice()/(double)vo.getTargetprice()*100));
					vo.setFm_percent(new DecimalFormat("###,###").format(percent));
					SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
					Date now = new Date();
					String today = format.format(now);
					if(now.before(vo.getStartdate())) {
						vo.setOf(1);
					}
					cookie_list.add(vo);
				}
			}
		}
		AdVO bottom_ad=fService.mainAdData();
		
		Map map=new HashMap();
		map.put("wish_list", wish_list);
		map.put("backing_list", backing_list);
		map.put("today_list", today_list);
		map.put("deadline_list", deadline_list);
		map.put("latest_list", cookie_list);
		map.put("bottom_ad", bottom_ad);
		
		ObjectMapper mapper=new ObjectMapper();
		String json=mapper.writeValueAsString(map);
		return json;
	}
	
	@GetMapping(value="funding/main_rank.do", produces="text/plain;charset=UTF-8")
	public String main_rank_list(String type) throws Exception{
		ObjectMapper mapper=new ObjectMapper();
		String json="";
		if(type.equals("funding")) {
			List<FundingVO> funding_list=fService.mainFundingRankListData();
			for(FundingVO vo:funding_list) {
				vo.setFm_headcount(new DecimalFormat("###,###").format(vo.getHeadcount()));
			}
			json=mapper.writeValueAsString(funding_list);
		}else {
			List<GoodsVO> store_list=fService.mainStoreRankListData();
			json=mapper.writeValueAsString(store_list);
		}
		return json;
	}
	
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
	public String funding_open_list(int page, HttpSession session) throws Exception{
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
		
		
		String id=(String)session.getAttribute("userId");
		if(id!=null) {
			List<AlertVO> alert_list=fService.openAlertCheck(id);
			for(FundingVO vo:list) {
				for(int i=0;i<alert_list.size();i++) {
					if(vo.getFno()==alert_list.get(i).getFno()) {
						vo.setIsAlert(1);
						break;
					}else {
						vo.setIsAlert(0);
					}
				}
			}
		}
		
		map=new HashMap();
		map.put("list", list);
		map.put("curpage", page);
		map.put("totalpage", totalpage);
		map.put("startpage", startpage);
		map.put("endpage", endpage);
		map.put("sessionId", id);
		
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
	
	
	@GetMapping(value="funding/alert_delete.do", produces="text/plain;charset=UTF-8")
	public String funding_alert_delete(int fno, HttpSession session) {
		String result="";
		try {
			String id=(String)session.getAttribute("userId");
			Map map=new HashMap();
			map.put("userId", id);
			map.put("fno", fno);
			fService.fundingAlertDecr(fno);
			fService.fundingAlertDelete(map);
			result="ok";
		}catch(Exception ex) {
			result=ex.getMessage();
		}
		return result;		
	}
	
	@GetMapping(value="funding/funding_detail_vue.do", produces="text/plain;charset=UTF-8")
	public String funding_detail(int fno, int cate, HttpSession session) throws Exception{
		FundingVO funding_vo=fService.fundingDetailData(fno);
		funding_vo.setFm_totalprice(new DecimalFormat("###,###").format(funding_vo.getTotalprice()));
		int percent=(int)(Math.round(funding_vo.getTotalprice()/(double)funding_vo.getTargetprice()*100));
		funding_vo.setFm_percent(new DecimalFormat("###,###").format(percent));
		funding_vo.setFm_wish(new DecimalFormat("###,###").format(funding_vo.getWish()));
		funding_vo.setFm_backing(new DecimalFormat("###,###").format(funding_vo.getBacking()));
		
		Date today=new Date();
		Date endday=new SimpleDateFormat("yyyyMMdd").parse(funding_vo.getEndday());
		long gap=endday.getTime()-today.getTime();
		funding_vo.setDday((int)(gap/(24*60*60*1000)+1));
		
		List<FundingImgVO> img_list=fService.fundingImgDetailData(fno);
		List<FundingRewardVO> reward_list=fService.fundingRewardDetailData(fno);
		for(FundingRewardVO vo:reward_list) {
			vo.setFm_price(new DecimalFormat("###,###").format(vo.getPrice()));
			if(vo.getDelivery()==0) {
				vo.setFm_del("무료배송");
			}else {
				vo.setFm_del((new DecimalFormat("###,###").format(vo.getDelivery()))+"원");				
			}
			vo.setFm_limit(new DecimalFormat("###,###").format(vo.getLimit()));
		}
		

		Map map=new HashMap();
		map.put("funding_vo", funding_vo);
		map.put("img_list", img_list);
		map.put("reward_list", reward_list);

		String id=(String)session.getAttribute("userId");
		WishVO vo=new WishVO();
		vo.setUserId(id);
		vo.setPno(fno);
		vo.setCate(cate);
		if(id!=null) {
			int wish_count=wService.fundingWishCheck(vo);			
			map.put("wish_count", wish_count);
		}else {
			map.put("wish_count", 0);
		}
		
		
		ObjectMapper mapper=new ObjectMapper();
		String json=mapper.writeValueAsString(map);
		return json;
	}
	
	@GetMapping(value="funding/cate_change.do", produces="text/plain;charset=UTF-8")
	public String funding_cate(int page, String cate, int type) throws Exception{
		int rowSize=12;
		int start=(rowSize*page)-(rowSize-1);
		int end=rowSize*page;
		Map map=new HashMap();
		map.put("start", start);
		map.put("end", end);
		map.put("cate", cate);
		
		List<FundingVO> list=new ArrayList();
		int totalpage=0;
		
		if(type==1) {
			list=fService.openCateListData(map);
			totalpage=fService.openCateTotalPage(cate);
		}else {
			list=fService.fundingCateListData(map);
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
			totalpage=fService.fundingCateTotalPage(cate);
		}
		 
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
	
	@PostMapping(value="funding/backing_insert.do", produces="text/plain;charset=UTF-8")
	public String funding_backing_insert(int fno, String content, HttpSession session) {
		String result="";
		try {
			String userId=(String)session.getAttribute("userId");
			Map map=new HashMap();
			map.put("fno", fno);
			map.put("content", content);
			map.put("userId", userId);
			fService.fundingBackingInsert(map);
			fService.fundingBackingInce(fno);
			result="ok";
		}catch(Exception ex) {
			result=ex.getMessage();
		}
		return result;
	}
	
	@GetMapping(value = "funding/create_project_vue.do", produces = "text/plain; charset=UTF-8")
	public String create_project(HttpSession session) throws Exception {
			String userId = (String)session.getAttribute("userId");
			Map map = new HashMap();
			
			map.put("userId", userId);			
			
			ObjectMapper mapper = new ObjectMapper();
			String json = mapper.writeValueAsString(map);

		return json;
	}
	
	@PostMapping(value = "project/create_funding_vue.do", produces = "text/plain; charset=UTF-8")
	public String create_funding(HttpSession session, Map map, @RequestParam List<MultipartFile> files) {
	    String result = "";
	    String path = "c:\\spring_upload"; // 파일을 저장할 경로
	    long maxFileSize = 5 * 1024 * 1024; // 최대 파일 크기 (5MB)

	    // 경로가 없으면 생성
	    File directory = new File(path);
	    if (!directory.exists()) {
	        directory.mkdirs(); // 경로 생성
	    }
	    
	    List<String> list = Arrays.asList("테크·가전", "패션", "뷰티", "홈·리빙", "스포츠·아웃도어", 
                "푸드", "도서·전자책", "클래스", "디자인", "반려동물", 
                "아트", "캐릭터·굿즈", "영화·음악", "키즈", "게임", 
                "만화·웹툰", "사진", "여행", "자동차", "멤버십", "소셜");
	    
	    try {
	        String userId = (String) session.getAttribute("userId");
	        map.put("userId", userId);

	        // 파일 업로드 처리
	        if (files != null && !files.isEmpty()) {
	            StringBuilder filenames = new StringBuilder();
	            for (MultipartFile file : files) {
	                String originalFilename = file.getOriginalFilename();
	                
	                // 파일 이름 유효성 검사
	                if (originalFilename == null || originalFilename.isEmpty()) {
	                    throw new IllegalArgumentException("파일 이름이 비어 있습니다.");
	                }

	                // 파일 확장자 검사
	                String fileExtension = originalFilename.substring(originalFilename.lastIndexOf('.') + 1).toLowerCase();
	                if (!fileExtension.matches("jpg|jpeg|png|gif")) {
	                    throw new IllegalArgumentException("지원하지 않는 파일 형식입니다. jpg, jpeg, png, gif 파일만 업로드 가능합니다.");
	                }

	                // 파일 크기 검사
	                if (file.getSize() > maxFileSize) {
	                    throw new IllegalArgumentException("파일 크기가 너무 큽니다. 최대 5MB로 제한됩니다.");
	                }

	                // 파일 이름 중복 방지 로직
	                String newFileName = originalFilename; // 초기 파일 이름 설정
	                File destinationFile = new File(path + "\\" + newFileName);
	                int count = 1;

	                // 파일이 존재하면 이름을 변경
	                while (destinationFile.exists()) {
	                    // 파일 이름에서 확장자 분리
	                    String name = originalFilename.substring(0, originalFilename.lastIndexOf('.'));
	                    String extension = originalFilename.substring(originalFilename.lastIndexOf('.'));
	                    newFileName = name + "_" + count + extension; // 이름에 숫자 추가
	                    destinationFile = new File(path + "\\" + newFileName); // 새로운 파일 경로
	                    count++; // 숫자 증가
	                }

	                // 파일 업로드
	                file.transferTo(destinationFile); // 파일 업로드

	                // 업로드된 파일 경로를 리스트에 추가
	                filenames.append(destinationFile.getAbsolutePath()).append(",");
	            }

	            // 마지막 쉼표 제거
	            if (filenames.length() > 0) {
	                filenames.setLength(filenames.length() - 1);
	            }

	            map.put("type", list);
	            // 데이터베이스에 이미지 경로 등록
	            map.put("image", filenames.toString()); // 이미지 경로
	            map.put("orderNum", files.size()); // 파일 개수
	            fService.fundingImgInsert(map); // DB에 정보 등록
//	            fService.funding_insert(list);  
	        }

	        result = "ok";
	    } catch (IllegalArgumentException ex) {
	        result = "Validation error: " + ex.getMessage();
	    } catch (IOException ex) {
	        result = "File upload error: " + ex.getMessage();
	    } catch (Exception ex) {
	        result = "Error: " + ex.getMessage();
	    }
	    return result;
	}
	
	@PostMapping(value = "project/reward_insert_vue.do", produces = "text/plain; charset=UTF-8")
	public String reward_insert(Map map, HttpSession session, RewardVO vo) {
	    String result = "";

	    try {
	        String userId = (String) session.getAttribute("userId");
	        
	        map.put("userId", userId);
	        map.put("price", vo.getPrice());
	        map.put("amount", vo.getAmount());
	        map.put("delivery", vo.getDelivery());
	        map.put("limit", vo.getLimit());
	        map.put("name", vo.getName());
	        map.put("description", vo.getDescription());
	        map.put("del_start", vo.getDel_start());
	        
	        fService.funding_rewardInsert(map);

	        result = "ok"; // 성공적으로 처리한 경우
	    } catch (IllegalArgumentException ex) {
	        result = "Validation error: " + ex.getMessage(); // 유효성 검사 오류 처리
	    } catch (Exception ex) {
	        result = "Error: " + ex.getMessage(); // 일반 오류 처리
	    }

	    return result;
	}

}
