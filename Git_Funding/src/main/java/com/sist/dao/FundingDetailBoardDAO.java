package com.sist.dao;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

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
	
	/*
	@Update("UPDATE funding_detail_comm SET "
			+ "cate=#{cate}, content=#{content}, modifydate=SYSDATE "
			+ "WHERE dcno=#{dcno}")
	public void fundingCommUpdate(FundingDetailCommVO vo); 
	 */
	public void fundingCommUpdate(FundingDetailCommVO vo) {
		mapper.fundingCommUpdate(vo);
	}
	
	/*
	//삭제
	@Delete("DELETE funding_detail_comm WHERE dcno=#{dcno}")
	public void fundingCommDelete(int dcno); 
	 */
	public void fundingCommDelete(int dcno) {
		mapper.fundingCommDelete(dcno);
	}
	
	/*
	//대댓글
	@Select("SELECT group_id ,group_step, group_tab "
			 + "FROM funding_detail_comm "
			 + "WHERE dcno=#{dcno}")
	public FundingDetailCommVO commParentInfoData(int dcno);

	@Update("UPDATE funding_detail_comm SET "
			 + "group_step=group_step+1 "
			 + "WHERE group_id=#{group_id} AND group_step>#{group_step}")
	public void commGroupStepIncrement(FundingDetailCommVO vo);

	@Insert("INSERT INTO funding_detail_comm(dcno, fno, userId, content, group_id, group_step, group_tab, root) "
			+ "VALUES(fdc_dcno_pk.nextval, #{fno}, #{userId}, #{content}, #{group_id}, #{group_step}, #{group_tab}, #{root})")
	public void commReplyInsert(FundingDetailCommVO vo);

	@Update("UPDATE funding_detail_comm SET "
			+ "depth=depth+1 "
			+ "WHERE dcno=#{dcno}")
	public void commDepthIncrement(int dcno); 
	 */
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public void commReplyInsert(int dcno, FundingDetailCommVO vo) {
		FundingDetailCommVO pvo=mapper.commParentInfoData(dcno);
		vo.setGroup_id(pvo.getGroup_id());
		vo.setGroup_step(pvo.getGroup_step()+1);
		vo.setGroup_tab(pvo.getGroup_tab()+1);
		mapper.commGroupStepIncrement(pvo);
		mapper.commReplyInsert(vo);
		mapper.commDepthIncrement(dcno);
	}

}
