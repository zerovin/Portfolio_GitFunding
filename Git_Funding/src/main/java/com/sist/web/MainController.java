package com.sist.web;

import java.net.URLEncoder;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.sist.dao.*;
import com.sist.service.*;
import com.sist.vo.*;
@Controller
public class MainController {
	@Autowired
	private NaverDAO nDao;
	
	@Autowired
	private FundingService fService;
	
	public String youtubeGetKey(String word){
		String key="";
		try{
			Document doc=Jsoup.connect("https://www.youtube.com/results?search_query="+URLEncoder.encode(word,"UTF-8")).get();
			Pattern p=Pattern.compile("/watch\\?v=[^가-힣]+");
			Matcher m=p.matcher(doc.toString());
			while(m.find()){
				String s=m.group();
				//System.out.println(s);
				key=s.substring(s.indexOf("=")+1,s.indexOf("\""));
				break;
			}   
		}catch(Exception ex){}
		return key;
	}
	
	@GetMapping("main/main.do")
	public String main_main(Model model) {
		/* 유튜브 */
		String data=nDao.naverSelectData();
		String key=youtubeGetKey(data);
		//System.out.println(key);
		model.addAttribute("key", key);
	
		HttpServletRequest request=((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		
		Cookie[] cookies=request.getCookies();
		List<FundingVO> list=new ArrayList<FundingVO>();
		if(cookies!=null) {
			for(int i=cookies.length-1;i>=0;i--) {
				if(cookies[i].getName().startsWith("funding_")) {
					String fno=cookies[i].getValue();
					FundingVO vo=fService.mainCookieListData(Integer.parseInt(fno));
					list.add(vo);
				}
			}
		}
		request.setAttribute("cookie_list", list);
			
		return "main";
	}
}
	
