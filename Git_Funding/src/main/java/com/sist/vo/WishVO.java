package com.sist.vo;
/*
WNO     NOT NULL NUMBER       
USERID           VARCHAR2(20) 
PNO     NOT NULL NUMBER       
CATE             NUMBER       
REGDATE          DATE
 */
import java.util.*;

import lombok.Data;
@Data
public class WishVO {
	private int wno, pno, cate;
	private String userId;
	private Date regdate;
}
