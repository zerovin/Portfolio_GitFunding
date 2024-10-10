package com.sist.mapper;
import java.util.*;

import org.apache.ibatis.annotations.Select;

import com.sist.vo.*;
public interface FundingMapper {
	@Select("SELECT fno, title, thumb, p_admin, targetprice, totalprice, TO_CHAR(startdate, 'MM\"월 \"DD\"일\"') as end, num "
			+ "FROM (SELECT fno, title, thumb, p_admin, targetprice, totalprice, startdate, rownum as num "
			+ "FROM (SELECT fno, title, thumb, p_admin, targetprice, totalprice, startdate "
			+ "FROM funding WHERE startdate>SYSDATE "
			+ "ORDER BY fno DESC)) "
			+ "WHERE num BETWEEN #{start} AND #{end}")
	public List<FundingVO> openListData(Map map);
	@Select("SELECT CEIL(COUNT(*)/12.0) FROM funding "
			+ "WHERE startdate>SYSDATE")
	public int openTotalPage();
	
	@Select("SELECT fno, title, thumb, p_admin, targetprice, totalprice, headcount, TO_CHAR(enddate, 'YYYY-MM-DD') as end, num "
			+ "FROM (SELECT fno, title, thumb, p_admin, targetprice, totalprice, headcount, enddate, rownum as num "
			+ "FROM (SELECT fno, title, thumb, p_admin, targetprice, totalprice, headcount, enddate "
			+ "FROM funding WHERE startdate<SYSDATE "
			+ "ORDER BY fno DESC)) "
			+ "WHERE num BETWEEN #{start} AND #{end}")
	public List<FundingVO> fundingListData(Map map);
	@Select("SELECT CEIL(COUNT(*)/12.0) FROM funding "
			+ "WHERE startdate<SYSDATE")
	public int fundingTotalPage();
}
