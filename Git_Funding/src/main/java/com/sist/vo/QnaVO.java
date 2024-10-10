package com.sist.vo;
import java.util.*;

import lombok.Data;
/*
 *  QNO        NOT NULL NUMBER         
	SUBJECT    NOT NULL VARCHAR2(2000) 
	CONTENT    NOT NULL CLOB           
	TYPE                NUMBER         
	REGDATE             DATE           
	HIT                 NUMBER         
	GROUP_ID            NUMBER         
	TAB                 NUMBER         
	ID         NOT NULL VARCHAR2(1000) 
	NICKNAME            VARCHAR2(500)  
	MODIFYDATE NOT NULL DATE           
 */
@Data
public class QnaVO {
	private int qno,type,hit,group_id,reok,admin;
	private String subject,content,id,nickname,name,dbday,mday;
	private Date regdate,modifydate;
}
