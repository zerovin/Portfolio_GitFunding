package com.sist.mapper;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.*;
import com.sist.vo.*;
public interface CommunityMapper {
	@Select("SELECT * FROM faq WHERE cate=#{cate}")
	public List<FaqVO> faqListData(String cate);
	
    @Select("SELECT qno, subject, name, nickname, content, secret, type, TO_CHAR(regdate, 'YYYY-MM-DD') AS dbday, hit, group_id, reok, admin, id, TO_CHAR(modifydate, 'YYYY-MM-DD') AS mday, num "
            + "FROM (SELECT qno, subject, name,nickname,content, secret, type, regdate, hit, group_id, reok, admin, id, modifydate, rownum AS num "
            + "FROM (SELECT qno, subject, name,nickname,content, secret, type, regdate, hit, group_id, reok, admin, id, modifydate "
            + "FROM site_qna WHERE admin = 0 ORDER BY qno DESC)) "
            + "WHERE num BETWEEN #{start} AND #{end}")
    public List<QnaVO> qnaListData(@Param("start") int start, @Param("end") int end);

    @Select("SELECT COUNT(*) FROM site_qna WHERE admin = 0")
    public int qnaRowCount();   
    /* 
     * INSERT INTO site_qna VALUES(
		sq_qno_seq.nextval,'제목','내용','2',SYSDATE,0,((SELECT NVL(MAX(group_id)+1,1)FROM site_qna)),0,'dayeong','닉네임',SYSDATE,0,'김다영');
     */
    // 닉네임 null 여부 체크
    @Select("SELECT nickname FROM funding_member WHERE userId = #{userId}")
    public String nicknameNullCheck(String id);
    // 인서트 동적 쿼리
    @Insert("<script>"
            + "INSERT INTO site_qna VALUES("
            + "sq_qno_seq.nextval, #{subject}, #{content}, #{type}, SYSDATE, 0, "
            + "((SELECT NVL(MAX(group_id)+1, 1) FROM site_qna)), 0, #{id}, "
            + "<if test=\"nickname != null\">"
            + "#{nickname},"
            + "</if>" 
            + "<if test=\"nickname == null\">"
            + "NULL,"
            + "</if>"
            + "SYSDATE, 0, #{name}, #{secret})"  
            + "</script>")   
	public void qnaInsert(QnaVO vo); 
       
    @Update("UPDATE site_qna SET hit=hit+1 WHERE qno=#{qno}")
    public void qnaHitIncrement(int qno);
      
    @Select("SELECT qno, subject, name, nickname, content, secret, type, TO_CHAR(regdate, 'YYYY-MM-DD HH24:MI:SS') AS dbday,"
    		+ " hit, group_id, reok, admin, id, TO_CHAR(modifydate, 'YYYY-MM-DD HH24:MI:SS') AS mday "
            + " FROM site_qna " 
            + " WHERE qno = #{qno}")  
    public QnaVO qnaDetailData(int qno);
      
    @Select("SELECT qno, subject, name, nickname, content, secret, type, TO_CHAR(regdate, 'YYYY-MM-DD HH24:MI:SS') AS dbday,"
            + " hit, group_id, reok, admin, id, TO_CHAR(modifydate, 'YYYY-MM-DD HH24:MI:SS') AS mday " 
            + " FROM site_qna " 
            + " WHERE group_id = #{groupId} AND admin = 1 "  
            + " ORDER BY regdate ASC")  
    public List<QnaVO> qnaAnswerDetail(int groupId); 
} 