package com.sist.vo;
/*
 * FGCNO	NUMBER(38,0)	No		1	
FGNO	NUMBER(38,0)	No		2	
ID	VARCHAR2(100 BYTE)	No		3	
ACCOUNT	NUMBER(38,0)	No		4	
PRICE	VARCHAR2(400 BYTE)	No		5	
DELIVERY	VARCHAR2(4000 BYTE)	Yes		6	
 */
import java.util.*;

import lombok.Data;

@Data
public class CartVO {
	private int fgcno,fgno,account;
	private String id,price,ops;
	private GoodsVO gvo;
	private boolean checked=false;
}
