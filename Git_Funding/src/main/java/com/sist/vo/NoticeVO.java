package com.sist.vo;

import java.util.*;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class NoticeVO {
	private int no, type, hit, filecount;
	private String subject, content, dbday, filename, filesize;
	private Date regdate;
	private String nickName, userId;
	private List<MultipartFile> files;
}
