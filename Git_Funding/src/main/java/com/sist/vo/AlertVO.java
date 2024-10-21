package com.sist.vo;
/*
ANO     NOT NULL NUMBER       
USERID           VARCHAR2(20) 
FNO              NUMBER       
REGDATE          DATE  
 */
import java.util.*;
import lombok.Data;
@Data
public class AlertVO {
	private int ano, fno;
	private String userId;
	private Date regdate;
	
	// 마이페이지 출력용
	private String title;      // 제목
    private String type;       // 유형
    private String thumb;      // 썸네일 이미지
    private String dbday;      // 등록 날짜
    private String startdate;  // 펀딩 시작 날짜
}
