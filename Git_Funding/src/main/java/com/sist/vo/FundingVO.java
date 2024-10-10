package com.sist.vo;
import java.util.*;
import lombok.Data;

/*
FNO         NOT NULL NUMBER         
TITLE       NOT NULL VARCHAR2(500)  
DESCRIPTION          CLOB           
TYPE                 VARCHAR2(100)  
THUMB                VARCHAR2(2000) 
TARGETPRICE NOT NULL NUMBER         
TOTALPRICE           NUMBER         
HEADCOUNT            NUMBER         
PERIOD               VARCHAR2(30)   
WISH                 NUMBER         
BACKING              NUMBER         
P_ADMIN              VARCHAR2(100)  
LINK                 VARCHAR2(1000) 
STARTDATE            DATE           
ENDDATE              DATE   
 */
@Data
public class FundingVO {
	private int fno, targetprice, totalprice, headcount, wish, backing;
	private String title, description, type, thumb, period, p_admin, link, start, end;
	private Date startdate, enddate;
}
