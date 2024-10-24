package com.sist.vo;
/*
DCNO       NOT NULL NUMBER       
FNO                 NUMBER       
USERID              VARCHAR2(20) 
CATE                VARCHAR2(50) 
CONTENT    NOT NULL CLOB         
REGDATE             DATE         
GROUP_ID            NUMBER       
GROUP_STEP          NUMBER       
GROUP_TAB           NUMBER       
DEPTH               NUMBER       
ROOT                NUMBER       
MODIFYDATE          DATE   
 */
import java.util.*;

import lombok.Data;
@Data
public class FundingDetailCommVO {
	private int dcno, fno, group_id, group_step, group_tab, depth, root;
	private String userId, cate, content, dbday, title, thumb;
	private Date regdate, modifydate;
	private MemberVO mvo=new MemberVO();
}
