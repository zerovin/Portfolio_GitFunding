package com.sist.vo;
import java.util.*;
/*
RBNO       NOT NULL NUMBER        
RNO                 NUMBER        
ACCOUNT    NOT NULL NUMBER        
PRICE      NOT NULL NUMBER        
DELIVERY            NUMBER        
TOTALPRICE          NUMBER        
USERID              VARCHAR2(20)  
NAME                VARCHAR2(51)  
PHONE               VARCHAR2(20)  
POST                VARCHAR2(10)  
ADDR1               VARCHAR2(500) 
ADDR2               VARCHAR2(500) 
REQUESTMSG          CLOB          
REGDATE             DATE    
 */
import lombok.Data;
@Data
public class RewardBuyVO {
	private int rbno, rno, account, price, delivery, totalprice;
	private String userId, name, phone, post, addr1, addr2, requestMsg;
	private Date regdate;
}
