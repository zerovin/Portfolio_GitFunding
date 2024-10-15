package com.sist.web;

import java.util.Date;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class FundingController {
	@GetMapping("funding/open_list.do")
	public String funding_open() {
		return "funding/open_list";
	}
	
	@GetMapping("funding/funding_list.do")
	public String funding_funding() {
		return "funding/funding_list";
	}
	
	@GetMapping("funding/funding_detail.do")
	public String funding_funding_detail() {
		return "funding/funding_detail";
	}
}
