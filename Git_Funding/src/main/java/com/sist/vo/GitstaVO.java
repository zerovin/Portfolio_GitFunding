package com.sist.vo;
import java.util.*;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
/*
이름         널?       유형             
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
	private int no,type,filecount;
	private String userId,content,filename,filesize,dbday,mday;
	private Date regdate,modifydate;
	
	 private MultipartFile file; 
}
