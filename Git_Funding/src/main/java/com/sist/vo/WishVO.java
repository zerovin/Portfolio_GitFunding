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
    private int fno;          // 번호
    private String title;     // 제목
    private String type;      // 유형
    private String thumb;     // 썸네일 이미지
    private String dbday;     // 등록 날짜
}
