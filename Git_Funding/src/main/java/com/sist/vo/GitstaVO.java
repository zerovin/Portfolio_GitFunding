package com.sist.vo;
import java.util.*;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
/*
�씠由�         �꼸?       �쑀�삎             
---------- -------- -------------- 
NO         NOT NULL NUMBER         
CONTENT    NOT NULL CLOB           
REGDATE             DATE           
TYPE                NUMBER         
FILENAME            VARCHAR2(1000) 
FILESIZE            VARCHAR2(1000) 
FILECOUNT           NUMBER         
MODIFYDATE          DATE           
USERID              VARCHAR2(100)  
        

 */

@Data
public class GitstaVO {
	private int no,fno,type,filecount;
	private String userId,content,filename,filesize,dbday,mday;
	private String userName,profile,nickname,projectname;
	private Date regdate,modifydate;
	private String followerId; 
	private String followingId; 
	private MultipartFile file; 
}
