package com.sist.mapper;
import java.util.*;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.sist.vo.*;
public interface FundingMapper {
	//메인-위시순
	@Select("SELECT fno, title, thumb, targetprice, totalprice, rownum "
			+ "FROM (SELECT fno, title, thumb, targetprice, totalprice "
			+ "FROM funding "
			+ "WHERE startdate<SYSDATE AND enddate>SYSDATE "
			+ "ORDER BY wish DESC) "
			+ "WHERE rownum<=4")
	public List<FundingVO> mainWishListData();
	
	//메인-지지순
	@Select("SELECT fno, title, thumb, targetprice, totalprice, rownum "
			+ "FROM (SELECT fno, title, thumb, targetprice, totalprice "
			+ "FROM funding "
			+ "WHERE startdate<SYSDATE AND enddate>SYSDATE "
			+ "ORDER BY backing DESC) "
			+ "WHERE rownum<=4")
	public List<FundingVO> mainBackingListData();
	
	//메인-오늘오픈
	@Select("SELECT fno, title, thumb, targetprice, totalprice "
			+ "FROM funding "
			+ "WHERE trunc(startdate)=trunc(SYSDATE) "
			+ "ORDER BY fno DESC")
	public List<FundingVO> mainTodayListData();
	
	//메인-마감임박
	@Select("SELECT fno, title, thumb, targetprice, totalprice "
			+ "FROM funding "
			+ "WHERE trunc(enddate)=trunc(SYSDATE) "
			+ "ORDER BY fno DESC")
	public List<FundingVO> mainDeadlineListData();
	//오픈예정 목록 
	@Select("SELECT fno, title, thumb, p_admin, targetprice, totalprice, alert, TO_CHAR(startdate, 'MM\"월 \"DD\"일\"') as startday, num "
			+ "FROM (SELECT fno, title, thumb, p_admin, targetprice, totalprice, alert, startdate, rownum as num "
			+ "FROM (SELECT fno, title, thumb, p_admin, targetprice, totalprice, alert, startdate "
			+ "FROM funding "
			+ "WHERE startdate>SYSDATE "
			+ "ORDER BY fno DESC)) "
			+ "WHERE num BETWEEN #{start} AND #{end}") 
	public List<FundingVO> openListData(Map map);
	
	@Select("SELECT CEIL(COUNT(*)/12.0) FROM funding "
			+ "WHERE startdate>SYSDATE")
	public int openTotalPage();
	
	//오픈예정 알림 여부   
	@Select("SELECT fno "
			+ "FROM funding_alert "
			+ "WHERE userId=#{userId}")
	public List<AlertVO> openAlertCheck(String id);
		
	//오픈예정 알림 신청
	@Update("UPDATE funding SET "
			+ "alert=alert+1 "
			+ "WHERE fno=#{fno}")
	public void fundingAlertUpdate(int fno);
	@Insert("INSERT INTO funding_alert VALUES(alert_ano_seq.nextval, #{userId}, #{fno}, SYSDATE)")
	public void fundingAlertInsert(Map map);
	
	//오픈예정 알림 취소 
	@Update("UPDATE funding SET "
			+ "alert=alert-1 "
			+ "WHERE fno=#{fno}")
	public void fundingAlertDecr(int fno);
	
	@Delete("DELETE FROM funding_alert WHERE fno=#{fno} AND userId=#{userId}")
	public void fundingAlertDelete(Map map);
	
	//펀딩 목록 
	@Select("SELECT fno, title, thumb, p_admin, targetprice, totalprice, TO_CHAR(headcount, 'FM999,999') as fm_headcount, TO_CHAR(enddate, 'YYYYMMDD') as endday, num "
			+ "FROM (SELECT fno, title, thumb, p_admin, targetprice, totalprice, headcount, enddate, rownum as num "
			+ "FROM (SELECT fno, title, thumb, p_admin, targetprice, totalprice, headcount, enddate "
			+ "FROM funding WHERE startdate<SYSDATE AND enddate>SYSDATE "
			+ "ORDER BY fno DESC)) "
			+ "WHERE num BETWEEN #{start} AND #{end}")
	public List<FundingVO> fundingListData(Map map);
	@Select("SELECT CEIL(COUNT(*)/12.0) FROM funding "
			+ "WHERE startdate<SYSDATE AND enddate>SYSDATE")
	public int fundingTotalPage();
	
	//펀딩 상세
	@Select("SELECT fno, thumb, type, title, description, p_admin, targetprice, totalprice, wish, backing, "
			+ "TO_CHAR(headcount, 'FM999,999') as fm_headcount, period, TO_CHAR(enddate, 'YYYYMMDD') as endday "
			+ "FROM funding "
			+ "WHERE fno=#{fno}")
	public FundingVO fundingDetailData(int fno);
	
	@Select("SELECT image FROM funding_img WHERE fno=#{fno} ORDER BY order_num ASC")
	public List<FundingImgVO> fundingImgDetailData(int fno);
	
	@Select("SELECT * FROM funding_reward WHERE fno=#{fno}")
	public List<FundingRewardVO> fundingRewardDetailData(int fno);
	
}
