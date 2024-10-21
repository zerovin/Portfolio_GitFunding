package com.sist.mapper;

import java.util.*;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.sist.vo.*;

public interface NoticeMapper {
    // 공지사항 목록
    @Select("SELECT no, type, hit, subject, TO_CHAR(regdate,'YYYY-MM-DD') as dbday, num "
            + "FROM (SELECT no, type, hit, subject, regdate, rownum as num "
            + "FROM (SELECT no, type, hit, subject, regdate "
            + "FROM site_notice ORDER BY no DESC)) "
            + "WHERE num BETWEEN #{start} AND #{end}")
    public List<NoticeVO> noticeListData(Map map);

    // 공지사항의 총 개수
    @Select("SELECT COUNT(*) FROM site_notice")
    public int noticeRowCount();

    // 공지사항 조회수
    @Update("UPDATE site_notice SET hit=hit+1 WHERE no=#{no}")
    public void noticeHitIncrement(int no);
    
    // 공지사항 상세보기
    @Select("SELECT no, nickname, type, subject, content, TO_CHAR(regdate, 'YYYY-MM-DD HH24:MI:SS') as dbday, hit "
    		+ "FROM site_notice "
    		+ "WHERE no=#{no}")
    public NoticeVO noticeDetailData(int no);
    
    // 공지 작성
    @Insert("INSERT INTO site_notice (no, type, subject, content, userId, nickName) "
            + "VALUES (sn_no_seq.nextval, #{type}, #{subject}, #{content}, #{userId}, #{nickName})")
    public void noticeInsert(NoticeVO vo);

    // 공지사항 수정 데이터 가져오기
    @Select("SELECT no, subject, content, type FROM site_notice WHERE no=#{no}")
    public NoticeVO noticeUpdateData(int no);
    
    // 공지사항 수정
    @Update("UPDATE site_notice SET "
            + "type=#{type}, subject=#{subject}, content=#{content}, filename=#{filename}, filesize=#{filesize}, filecount=#{filecount}, regdate=SYSDATE "
            + "WHERE no=#{no}")
    public void noticeUpdate(NoticeVO vo);
    
    // 공지사항 삭제
    @Delete("DELETE FROM site_notice WHERE no=#{no}")
    public void noticeDelete(int no);
}
