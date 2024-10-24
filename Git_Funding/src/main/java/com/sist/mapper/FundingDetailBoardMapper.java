package com.sist.mapper;
import java.util.*;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;

import com.sist.vo.*;
public interface FundingDetailBoardMapper {
	//새소식 
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
	
	@Select("SELECT dnno, cate, title, TO_CHAR(regdate, 'YYYY.MM.DD HH24:MI:SS') as dbday, content "
			+ "FROM funding_detail_notice "
			+ "WHERE dnno=#{dnno}")
	public FundingDetailNoticeVO fundingNoticeDetailData(int dnno);
	
	//커뮤니티
	@Insert("INSERT INTO funding_detail_comm(dcno, fno, userId, cate, content) "
			+ "VALUES(fdc_dcno_pk.nextval, #{fno}, #{userId}, #{cate}, #{content})")
	public void fundingCommInsert(FundingDetailCommVO vo);
	
	@Results({
		@Result(property="mvo.nickname", column="nickname"),
		@Result(property="mvo.userName", column="userName"),
		@Result(property="mvo.profile", column="profile")
	})
	@Select("SELECT fdc.*, nickname, userName, profile "
			+ "FROM funding_detail_comm fdc, funding_member fm "
			+ "WHERE fdc.userId=fm.userId "
			+ "AND fno=#{fno} "
			+ "ORDER BY dcno DESC")
	public List<FundingDetailCommVO> fundingCommListData(int fno);
	
	//수정
	@Select("SELECT fno, dcno, cate, content "
			+ "FROM funding_detail_comm "
			+ "WHERE dcno=#{dcno}")
	public FundingDetailCommVO fundingCommUpdateData(int dcno);
}
