package com.sist.dao;

import org.apache.ibatis.annotations.Select;
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
}
