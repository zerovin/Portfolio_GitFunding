package com.sist.vo;

import lombok.Data;

/*
RNO         NOT NULL NUMBER         
FNO                  NUMBER         
NAME        NOT NULL VARCHAR2(1000) 
PRICE       NOT NULL NUMBER         
AMOUNT               NUMBER         
DESCRIPTION          CLOB           
DELIVERY             NUMBER         
DEL_START            VARCHAR2(100)  
LIMIT                NUMBER  
 */
@Data
public class FundingRewardVO {
	private int rno, fno, price, amount, delivery, limit;
	private String name, description, del_start, fm_price, fm_del, fm_limit;
}
