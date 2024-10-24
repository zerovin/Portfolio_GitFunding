package com.sist.vo;

import java.util.*;

import lombok.Data;

//이름          널?       유형             
//----------- -------- -------------- 
//RNO         NOT NULL NUMBER         
//FNO                  NUMBER         
//NAME        NOT NULL VARCHAR2(1000) 
//PRICE       NOT NULL NUMBER         
//AMOUNT               NUMBER         
//DESCRIPTION          CLOB           
//DELIVERY             NUMBER         
//DEL_START            VARCHAR2(100)  
//LIMIT                NUMBER

@Data
public class RewardVO {
	private int rno, fno, price, amount, delivery, limit;
	private String name, description, del_start, userId;
}
