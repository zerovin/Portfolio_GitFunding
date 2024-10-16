package com.sist.vo;

import lombok.Data;

/*
FNO          NUMBER         
IMAGE        VARCHAR2(2000) 
ORDER_NUM    NUMBER  
 */
@Data
public class FundingImgVO {
	private int fno, order_num;
	private String image;
}
