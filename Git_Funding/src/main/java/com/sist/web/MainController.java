package com.sist.web;

import java.net.URLEncoder;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import com.sist.dao.*;
import com.sist.service.*;
import com.sist.vo.*;
@Controller
public class MainController {
	@Autowired
	private NaverDAO nDao;
	
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
		/* 유튜브
		String data=nDao.naverSelectData();
		String key=youtubeGetKey(data);
		//System.out.println(key);
		model.addAttribute("key", key);
		*/

		return "main";
	}
}
	
