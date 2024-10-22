package com.sist.vo;
/*
DNNO    NOT NULL NUMBER         
FNO              NUMBER         
CATE             VARCHAR2(50)   
TITLE   NOT NULL VARCHAR2(2000) 
CONTENT NOT NULL CLOB           
REGDATE          DATE 
 */
import java.util.*;

import lombok.Data;
@Data
public class FundingDetailNoticeVO {
	private int dnno, fno;
	private String cate, title, content, dbday;
	private Date regdate;
}
