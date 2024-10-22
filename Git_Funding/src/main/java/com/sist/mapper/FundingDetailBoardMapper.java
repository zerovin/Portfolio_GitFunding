package com.sist.mapper;
import java.util.*;

import org.apache.ibatis.annotations.Select;

import com.sist.vo.*;
public interface FundingDetailBoardMapper {
	@Select("SELECT dnno, cate, title, TO_CHAR(regdate, 'YYYY.MM.DD') as dbday, num "
			+ "FROM (SELECT dnno, cate, title, regdate, rownum as num "
			+ "FROM (SELECT dnno, cate, title, regdate "
			+ "FROM funding_detail_notice "
			+ "WHERE fno=#{fno} "
			+ "ORDER BY dnno DESC)) "
			+ "WHERE num BETWEEN #{start} AND #{end}")
	public List<FundingDetailNoticeVO> fundingNoticeListData(Map map);
	
	@Select("SELECT CEIL(COUNT(*)/10.0) FROM funding_detail_notice")
	public int fundingNoticeTotalPage();
}
