package com.sist.mapper;

import java.util.*;
import org.apache.ibatis.annotations.*;

import com.sist.vo.*;

public interface NoticeMapper {
    // 공지사항 목록
    @Select("SELECT nno, type, subject, nickName, TO_CHAR(regdate,'YYYY-MM-DD HH24:MI:SS') as dbday, hit, num "
            + "FROM (SELECT nno, type, subject, nickName, regdate, hit, rownum as num "
            + "FROM (SELECT nno, type, subject, name, regdate, hit "
            + "FROM funding_notice ORDER BY nno DESC)) "
            + "WHERE num BETWEEN #{start} AND #{end}")
    public List<NoticeVO> noticeListData(Map map);

    // 공지사항의 총 개수
    @Select("SELECT COUNT(*) FROM funding_notice")
    public int noticeRowCount();

    // 공지 조회수
    @Update("UPDATE funding_notice SET hit=hit+1 WHERE nno=#{nno}")
    public void noticeHitIncrement(int nno);
    
    // 공지사항 상세보기
    @Select("SELECT * FROM funding_notice WHERE nno=#{nno}")
    public NoticeVO noticeDetailData(int nno);
    
    // 공지 작성
    @Insert("INSERT INTO funding_notice (nno, type, subject, content, regdate, hit, nickName) "
            + "VALUES (fn_nno_seq.nextval, #{type}, #{subject}, #{content}, SYSDATE, 0, #{nickname})")
    public void noticeInsert(NoticeVO vo);

    // 공지사항 수정 데이터 가져오기
    @Select("SELECT nno, subject, content, type FROM funding_notice WHERE nno=#{nno}")
    public NoticeVO noticeUpdateData(int nno);
    
    // 공지사항 수정
    @Update("UPDATE funding_notice SET "
            + "type=#{type}, subject=#{subject}, content=#{content}, regdate=SYSDATE "
            + "WHERE nno=#{nno}")
    public void noticeUpdate(NoticeVO vo);
    
    // 공지사항 삭제
    @Delete("DELETE FROM funding_notice WHERE nno=#{nno}")
    public void noticeDelete(int nno);
}
