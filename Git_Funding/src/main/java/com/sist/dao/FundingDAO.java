package com.sist.dao;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.util.*;
import com.sist.vo.*;
import com.sist.mapper.*;
@Repository
public class FundingDAO {
	@Autowired
	private FundingMapper mapper;
	
	/*
	 //메인-위시순
	@Select("SELECT fno, title, thumb, targetprice, totalprice, rownum "
			+ "FROM (SELECT fno, title, thumb, targetprice, totalprice "
			+ "FROM funding "
			+ "WHERE WHERE startdate<SYSDATE AND enddate>SYSDATE "
			+ "ORDER BY wish DESC) "
			+ "WHERE rownum<=4")
	public List<FundingVO> mainWishListData();
	*/
	public List<FundingVO> mainWishListData(){
		return mapper.mainWishListData();
	}
	
	/*
	//메인-지지순
	@Select("SELECT fno, title, thumb, targetprice, totalprice, rownum "
			+ "FROM (SELECT fno, title, thumb, targetprice, totalprice "
			+ "FROM funding "
			+ "WHERE WHERE startdate<SYSDATE AND enddate>SYSDATE "
			+ "ORDER BY backing DESC) "
			+ "WHERE rownum<=4")
	public List<FundingVO> mainBackingListData();
	*/
	public List<FundingVO> mainBackingListData(){
		return mapper.mainBackingListData();
	}
	
	/*
	//메인-오늘오픈
	@Select("SELECT fno, title, thumb, targetprice, totalprice "
			+ "FROM funding "
			+ "WHERE WHERE startdate=SYSDATE "
			+ "ORDER BY fno DESC")
	public List<FundingVO> mainTodayListData();
	*/
	public List<FundingVO> mainTodayListData(){
		return mapper.mainTodayListData();
	}
	
	/*
	//메인-마감임박
	@Select("SELECT fno, title, thumb, targetprice, totalprice "
			+ "FROM funding "
			+ "WHERE WHERE enddate=SYSDATE "
			+ "ORDER BY fno DESC")
	public List<FundingVO> mainDeadlineListData(); 
	 */
	public List<FundingVO> mainDeadlineListData(){
		return mapper.mainDeadlineListData();
	}
	
	/*
	@Select("SELECT fno, title, thumb, p_admin, targetprice, totalprice, TO_CHAR(startdate, 'MM\"월 \"DD\"일\"') as end, num "
			+ "FROM (SELECT fno, title, thumb, p_admin, targetprice, totalprice, startdate, rownum as num "
			+ "FROM (SELECT fno, title, thumb, p_admin, targetprice, totalprice, startdate "
			+ "FROM funding WHERE startdate>SYSDATE"
			+ "ORDER BY fno DESC))"
			+ "WHERE num BETWEEN #{start} AND #{end}")
	public List<FundingVO> open_list(Map map);
	*/
	public List<FundingVO> openListData(Map map){
		return mapper.openListData(map);
	}
	/*
	@Select("SELECT CEIL(COUNT(*)/12.0) FROM funding "
			+ "WHERE startdate>SYSDATE")
	public int openTotalPage();
	*/
	public int openTotalPage() {
		return mapper.openTotalPage();
	}
	/*
	@Select("SELECT fa.fno "
			+ "FROM funding, funding_alert fa"
			+ "WHERE userId=#{userId} AND funding.fno=fa=fno")
	public AlertVO openAlertCheck(String id);
	 */
	public List<AlertVO> openAlertCheck(String id) {
		return mapper.openAlertCheck(id);
	}
	
	/*
	@Select("SELECT fno, title, thumb, p_admin, targetprice, totalprice, TO_CHAR(enddate, 'YYYY-MM-DD') as end, num "
			+ "FROM (SELECT fno, title, thumb, p_admin, targetprice, totalprice, enddate, rownum as num "
			+ "FROM (SELECT fno, title, thumb, p_admin, targetprice, totalprice, enddate "
			+ "FROM funding WHERE startdate<SYSDATE"
			+ "ORDER BY fno DESC))"
			+ "WHERE num BETWEEN #{start} AND #{end}")
	public List<FundingVO> funding_list(Map map); 
	@Select("SELECT CEIL(COUNT(*)/12.0) FROM funding "
			+ "WHERE startdate<SYSDATE")
	public int fundingTotalPage();
	 */
	public List<FundingVO> fundingListData(Map map){
		return mapper.fundingListData(map);
	}
	/*
	@Select("SELECT CEIL(COUNT(*)/12.0) FROM funding "
			+ "WHERE startdate<SYSDATE")
	public int openTotalPage();
	*/
	public int fundingTotalPage() {
		return mapper.fundingTotalPage();
	}
	
	/*
	@Update("UPDATE funding SET "
			+ "alert=alert+1 "
			+ "WHERE fno=#{fno}")
	public void fundingAlertUpdate(int fno);
	*/
	public void fundingAlertUpdate(int fno) {
		mapper.fundingAlertUpdate(fno);
	}
	
	/*
	@Insert("INSERT INTO funding_alert(alert_ano_seq.nextval, #{userId}, #{fno}, SYSDATE)")
	public void fundingAlertInsert(AlertVO vo); 
	 */
	public void fundingAlertInsert(Map map) {
		mapper.fundingAlertInsert(map);
	}
	
	/*
	 @Update("UPDATE funding SET "
			+ "alert=alert-1 "
			+ "WHERE fno=#{fno}")
	public void fundingAlertDecr(int fno);
	*/
	public void fundingAlertDecr(int fno) {
		mapper.fundingAlertDecr(fno);
	}
	
	/*
	@Delete("DELETE FROM funding_alert WHERE fno=#{fno} AND userId=#{userId}")
	public void fundingAlertDelete(Map map); 
	 */
	public void fundingAlertDelete(Map map) {
		mapper.fundingAlertDelete(map);
	}
	
	/*
 	@Select("SELECT fno, thumb, type, title, description, p_admin, targetprice, totalprice, wish, backing, "
			+ "TO_CHAR(headcount, 'FM999,999') as fm_headcount, period, TO_CHAR(enddate, 'YYYYMMDD') as endday "
			+ "FROM funding "
			+ "WHERE fno=#{fno}")
	public FundingVO fundingDetailData(int fno);
	*/
	public FundingVO fundingDetailData(int fno) {
		return mapper.fundingDetailData(fno);
	}
	
	/*
	@Select("SELECT image FROM funding_img WHERE fno=#{fno} ORDER BY order_num ASC")
	public  List<FundingImgVO> fundingImgDetailData(int fno);
	*/
	public List<FundingImgVO> fundingImgDetailData(int fno) {
		return mapper.fundingImgDetailData(fno);
	}
	
	/*
	@Select("SELECT * FROM funding_reward WHERE fno=#{fno}")
	public List<FundingRewardVO> fundingRewardDetailData(int fno); 
	 */
	public List<FundingRewardVO> fundingRewardDetailData(int fno) {
		return mapper.fundingRewardDetailData(fno);
	}
}
