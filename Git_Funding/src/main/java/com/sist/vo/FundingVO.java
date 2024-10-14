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
ALERT                NUMBER
 */
@Data
public class FundingVO {
	private int fno, targetprice, totalprice, headcount, wish, backing, alert, percent, dday;
	private String title, description, type, thumb, period, p_admin, link, startday, endday, fm_headcount, fm_totalprice, fm_wish, fm_bakcing, fm_percent;
	private Date startdate, enddate;
}
