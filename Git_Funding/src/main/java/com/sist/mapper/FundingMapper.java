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
	
	//메인-랭킹
	@Select("SELECT fno, title, thumb, headcount, rownum "
			+ "FROM (SELECT fno, title, thumb, headcount "
			+ "FROM funding "
			+ "WHERE startdate<SYSDATE AND enddate>SYSDATE "
			+ "ORDER BY headcount DESC) "
			+ "WHERE rownum<=5")
	public List<FundingVO> mainFundingRankListData();
	
	@Select("SELECT fgno, title, img, hit, rownum " 
			+ "FROM (SELECT fg.fgno, fg.title, fgi.img, fg.hit " 
			+ "FROM f_goods fg LEFT JOIN (SELECT fgno, MAX(img) as img FROM f_goods_img fgi GROUP BY fgno order by fgno) fgi " 
			+ "ON fg.fgno=fgi.fgno ORDER BY hit DESC) "
            + "WHERE rownum<=5")
	public List<GoodsVO> mainStoreRankListData();
	
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
	
	//메인-쿠키
	@Select("SELECT fno, title, thumb, targetprice, totalprice, startdate "
			+ "FROM funding "
			+ "WHERE fno=#{fno}")
	public FundingVO mainCookieListData(int fno);
	
	//메인-광고
	@Select("SELECT no, link, rownum "
			+ "FROM (SELECT no, link FROM funding_ad ORDER BY DBMS_RANDOM.VALUE) "
			+ "WHERE rownum=1")
	public AdVO mainAdData();
	
	
	
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
	
	//오픈 카테고리 분류별 출력
	@Select("SELECT fno, title, thumb, p_admin, targetprice, totalprice, alert, TO_CHAR(startdate, 'MM\"월 \"DD\"일\"') as startday, num "
			+ "FROM (SELECT fno, title, thumb, p_admin, targetprice, totalprice, alert, startdate, rownum as num "
			+ "FROM (SELECT fno, title, thumb, p_admin, targetprice, totalprice, alert, startdate "
			+ "FROM funding "
			+ "WHERE startdate>SYSDATE AND type=#{cate} "
			+ "ORDER BY fno DESC)) "
			+ "WHERE num BETWEEN #{start} AND #{end}") 
	public List<FundingVO> openCateListData(Map map);
	
	@Select("SELECT CEIL(COUNT(*)/12.0) FROM funding "
			+ "WHERE startdate>SYSDATE AND type=#{cate}")
	public int openCateTotalPage(String cate);
	
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
	
	//오픈 카테고리 분류별 출력
	@Select("SELECT fno, title, thumb, p_admin, targetprice, totalprice, TO_CHAR(headcount, 'FM999,999') as fm_headcount, TO_CHAR(enddate, 'YYYYMMDD') as endday, num "
			+ "FROM (SELECT fno, title, thumb, p_admin, targetprice, totalprice, headcount, enddate, rownum as num "
			+ "FROM (SELECT fno, title, thumb, p_admin, targetprice, totalprice, headcount, enddate "
			+ "FROM funding WHERE startdate<SYSDATE AND enddate>SYSDATE AND type=#{cate}"
			+ "ORDER BY fno DESC)) "
			+ "WHERE num BETWEEN #{start} AND #{end}")
	public List<FundingVO> fundingCateListData(Map map);
	
	@Select("SELECT CEIL(COUNT(*)/12.0) FROM funding "
			+ "WHERE startdate<SYSDATE AND enddate>SYSDATE AND type=#{cate}")
	public int fundingCateTotalPage(String cate);
	
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
	
	//펀딩 지지
	@Insert("INSERT INTO gitsta_feed (no, fno, projectname, filename, userid, type, regdate, modifydate, content, filecount) "
	          + "SELECT gf_no_seq.nextval, f.fno, f.title, f.thumb, #{userId}, 2, sysdate, sysdate, #{content}, 1 "
	          + "FROM funding f "
	          + "WHERE f.fno = #{fno} "
	          + "AND NOT EXISTS ("
	          + "    SELECT 1 "
	          + "    FROM gitsta_feed gf "
	          + "    WHERE gf.fno = f.fno AND gf.userid = #{userId}"
	          + ")")
	public void fundingBackingInsert(Map map);
	
	@Update("UPDATE funding SET "
			+ "backing=backing+1 "
			+ "WHERE fno=#{fno}")
	public void fundingBackingInce(int fno);
}
