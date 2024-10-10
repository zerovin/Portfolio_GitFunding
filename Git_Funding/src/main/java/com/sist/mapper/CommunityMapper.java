package com.sist.mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import java.util.*;
import com.sist.vo.*;
public interface CommunityMapper {
	@Select("SELECT * FROM faq WHERE cate=#{cate}")
	public List<FaqVO> faqListData(String cate);
	
    @Select("SELECT qno, subject, name, nickname, content, type, TO_CHAR(regdate, 'YYYY-MM-DD') AS dbday, hit, group_id, reok, admin, id, TO_CHAR(modifydate, 'YYYY-MM-DD') AS mday, num "
            + "FROM (SELECT qno, subject, name,nickname,content, type, regdate, hit, group_id, reok, admin, id, modifydate, rownum AS num "
            + "FROM (SELECT qno, subject, name,nickname,content, type, regdate, hit, group_id, reok, admin, id, modifydate "
            + "FROM site_qna WHERE admin = 0 ORDER BY qno DESC)) "
            + "WHERE num BETWEEN #{start} AND #{end}")
    public List<QnaVO> qnaListData(@Param("start") int start, @Param("end") int end);

    @Select("SELECT COUNT(*) FROM site_qna WHERE admin = 0")
    public int qnaRowCount();
}
