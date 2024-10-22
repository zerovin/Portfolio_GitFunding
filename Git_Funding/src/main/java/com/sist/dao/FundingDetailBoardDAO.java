package com.sist.dao;

import org.apache.ibatis.annotations.Select;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.util.*;
import com.sist.mapper.*;
import com.sist.vo.*;
@Repository
public class FundingDetailBoardDAO {
	@Autowired
	private FundingDetailBoardMapper mapper;
	
	/*
	@Select("SELECT dnno, type, title, TO_CHAR(regdate, 'YYYY.MM.DD'), num "
			+ "FROM (SELECT dnno, type, title, regdate, rownum as num "
			+ "FROM (SELECT dnno, type, title, regdate "
			+ "FROM funding_detail_notice ORDER BY dnno DESC)) "
			+ "WHERE num BETWEEN #{start} AND #{end}")
	public List<FundingDetailNoticeVO> fundingNoticeListData(Map map);
	*/
	public List<FundingDetailNoticeVO> fundingNoticeListData(Map map){
		return mapper.fundingNoticeListData(map);
	}
	
	/*
	@Select("SELECT CEIL(COUNT(*)/10.0) FROM funding_detail_notice")
	public int fundingNoticeTotalPage(); 
	 */
	public int fundingNoticeTotalPage() {
		return mapper.fundingNoticeTotalPage();
	}
}
