package com.sist.vo;
/*
DCNO    NOT NULL NUMBER       
FNO              NUMBER       
USERID           VARCHAR2(20) 
CATE             VARCHAR2(50) 
CONTENT NOT NULL CLOB         
REGDATE          DATE 
 */
import java.util.*;

import lombok.Data;
@Data
public class FundingDetailCommVO {
	private int dcno, fno;
	private String userId, cate, content, dbday, title, thumb;
	private Date regdate;
}
