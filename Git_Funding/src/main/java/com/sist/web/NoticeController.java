package com.sist.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class NoticeController {

	@GetMapping("notice/list.do")
	public String notice_list() {
		return "notice/list";
	}
	
	@GetMapping("notice/insert.do")
	public String notice_insert() {
		return "notice/insert";
	}
	
	@GetMapping("notice/update.do")
	public String notice_update() {
		return "notice/update";
	}
	
	@GetMapping("notice/delete.do")
	public String notice_delete() {
		return "notice/delete";
	}
}
