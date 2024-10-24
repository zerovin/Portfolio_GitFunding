package com.sist.dao;

import org.apache.ibatis.annotations.Insert;
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
	
	/*
	 @Select("SELECT dnno, cate, title, TO_CHAR(regdate, 'YYYY.MM.DD HH24:MI:SS') as dbday, content "
			+ "FROM funding_detail_notice "
			+ "WHERE dnno=#{dnno}")
	public FundingDetailNoticeVO fundingNoticeDetailData(int dnno); 
	 */
	public FundingDetailNoticeVO fundingNoticeDetailData(int dnno) {
		return mapper.fundingNoticeDetailData(dnno);
	}
	
	/*
	@Insert("INSERT INTO funding_detail_comm "
			+ "VALUES(fdc_dcno_pk.nextval, #{fno), #{userId}, #{cate}, #{content}, SYSDATE)")
	public void fundingCommInsert(FundingDetailCommVO vo); 
	 */
	public void fundingCommInsert(FundingDetailCommVO vo) {
		mapper.fundingCommInsert(vo);
	}
	
	/*
	@Select("SELECT * FROM funding_detail_comm "
			+ "WHERE fno=#{fno} "
			+ "ORDER BY dcno DESC")
	public List<FundingDetailCommVO> fundingCommListData(int fno); 
	 */
	public List<FundingDetailCommVO> fundingCommListData(int fno){
		return mapper.fundingCommListData(fno);
	}
	
	/*
	//수정
	@Select("SELECT fno, dcno, cate, content "
			+ "FROM funding_detail_comm "
			+ "WHERE dcno=#{dcno}")
	public FundingDetailCommVO fundingCommUpdateData(int dcno); 
	 */
	public FundingDetailCommVO fundingCommUpdateData(int dcno) {
		return mapper.fundingCommUpdateData(dcno);
	}
}
