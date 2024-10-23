package com.sist.mapper;
import java.util.*;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.sist.vo.*;     
public interface GitstaMapper {    
	 
	@Select("SELECT userId,userName,userPwd,gender,email,post,addr1,addr2,phone,profile,nickname,msg "
			+"FROM funding_member "    
			+"WHERE userId=#{userId}")  
	public MemberVO gitstaInfoData(String userId);
	 
	@Select("SELECT f.no, f.fno, f.content, m.userId, m.nickname, f.filename, f.filesize, f.filecount,f.type,f.replycount, "
			+ "TO_CHAR(f.regdate, 'YYYY-MM-DD') as dbday, TO_CHAR(f.modifydate, 'YYYY-MM-DD') as mday, f.num "
			+ "FROM (SELECT no,fno, content, userId, filename, filesize, filecount, type, replycount, regdate, modifydate, rownum as num "
			+ "FROM (SELECT no,fno, content, userId, filename, filesize, filecount, type, replycount, regdate, modifydate "
			+ "FROM gitsta_feed WHERE userId = #{userId} ORDER BY no DESC)) f "
			+ "JOIN funding_member m ON f.userId = m.userId "
			+ "WHERE f.num BETWEEN #{start} AND #{end}")  
	public List<GitstaVO> gitstaMyTotalListData(@Param("userId") String userId, @Param("start") int start, @Param("end") int end);
	    
	 
	
	@Select("SELECT COUNT(*) FROM gitsta_feed WHERE userId=#{userId}")
	public int gitstaMyTotalCount(String userId);  
	    
	@Select("SELECT f.no, f.content, f.filename, f.filesize, f.filecount,f.fno,f.type,f.projectname,f.replycount, "
	        + "f.regdate, f.modifydate, f.userId, m.userName, m.nickname, m.profile "
	        + "FROM gitsta_feed f "
	        + "LEFT JOIN funding_member m ON f.userId = m.userId "
	        + "ORDER BY f.no DESC")
	public List<GitstaVO> gitstaTotalListData();  
  
  
	@Select("SELECT COUNT(*) FROM gitsta_feed")
	public int gitstaTotalCount();
	
	@Select("SELECT gf.no, gf.fno, gf.userId, gf.content, gf.filename, gf.filesize, gf.filecount, gf.projectname, gf.type, " +
	        "TO_CHAR(gf.regdate, 'YYYY-MM-DD') as dbday, TO_CHAR(gf.modifydate, 'YYYY-MM-DD') as mday, " +
	        "fm.userName, fm.nickname " +
	        "FROM gitsta_feed gf " +
	        "JOIN funding_member fm ON gf.userId = fm.userId " +
	        "WHERE gf.no = #{no}")
	public GitstaVO gitstaDetailData(int no);
	
	@Insert("INSERT INTO gitsta_feed(no,userId,content,filename,filesize,filecount,modifydate,type) "
	  		+ "VALUES(gf_no_seq.nextval,#{userId},#{content},#{filename},#{filesize},#{filecount},SYSDATE,1)")
	public void feedInsert(GitstaVO vo);
	//팔로잉 
	@Select("SELECT m.userId, m.nickname, m.userName, m.profile "
	        + "FROM follow f "
	        + "JOIN funding_member m ON f.followingId = m.userId "
	        + "WHERE f.followerId = #{userId} "
	        + "ORDER BY m.nickname ASC")
	public List<MemberVO> gitstaFollowingListData(@Param("userId") String userId);
	
	@Select("SELECT COUNT(*) FROM follow WHERE followerId = #{userId}")
	public int getFollowingCount(@Param("userId") String userId); 
	

	
	//팔로워
	@Select("SELECT m.userId, m.nickname, m.userName, m.profile "
	        + "FROM follow f "
	        + "JOIN funding_member m ON f.followerId = m.userId "
	        + "WHERE f.followingId = #{userId} "
	        + "ORDER BY m.nickname ASC")
	public List<MemberVO> gitstaFollowerListData(@Param("userId") String userId);
	
	@Select("SELECT COUNT(*) FROM follow WHERE followingId = #{userId}")
	public int getFollowerCount(@Param("userId") String userId);
	
	@Insert("INSERT INTO follow (followerId, followingId) VALUES (#{followerId}, #{followingId})")
	public void insertFollow(@Param("followerId") String followerId, @Param("followingId") String followingId);
	
	@Delete("DELETE FROM follow WHERE followerId = #{followerId} AND followingId = #{followingId}")
	public void deleteFollow(@Param("followerId") String followerId, @Param("followingId") String followingId);
	 
	// 피드 수정
	@Update("UPDATE gitsta_feed SET content=#{content}, filename=#{filename}, filesize=#{filesize}, filecount=#{filecount}, modifydate=SYSDATE WHERE no=#{no}")
	public void updatePost(GitstaVO vo);
	
	// 피드 삭제
	@Select("SELECT filename,type FROM gitsta_feed WHERE no=#{no}")
	public GitstaVO deleteInfoData(int no);
	@Delete("DELETE FROM gitsta_feed WHERE no=#{no}")
	public void deletePost(int no);
	
	// 댓글
	// 댓글 목록 가져오기 (funding_member와 조인하여 userName, nickname, profile 추가)
	@Select("SELECT * FROM ("
	        + "  SELECT gc.gno, gc.rno, gc.userId, gc.msg, gc.regdate, gc.likecount, gc.group_id, gc.group_step, "
	        + "         gc.group_tab, gc.depth, gc.root, gc.modifydate, "
	        + "         fm.profile, fm.userName, fm.nickname, "
	        + "         TO_CHAR(gc.modifydate,'YYYY-MM-DD HH24:MI:SS') as mday, "
	        + "         TO_CHAR(gc.regdate,'YYYY-MM-DD HH24:MI:SS') as dbday, "
	        + "         ROWNUM AS rnum "
	        + "  FROM gitsta_comment gc "
	        + "  JOIN funding_member fm ON gc.userId = fm.userId "
	        + "  WHERE gc.rno = #{no} "
	        + "  ORDER BY gc.group_id DESC, gc.group_step ASC "
	        + ") WHERE rnum BETWEEN #{start} AND #{end}")
	public List<GitstaReVO> commentListData(Map<String, Object> map);

  
    // 댓글 페이지 수 계산
	@Select("SELECT CEIL(COUNT(*)/10.0) FROM gitsta_comment WHERE rno=#{rno}")
	public int commentTotalPage(@Param("rno") int rno);
 
    // 댓글 추가
    @Insert("INSERT INTO gitsta_comment (gno, rno, userId, msg, group_id) "
            + "VALUES (gc_gno_seq.NEXTVAL, #{rno}, #{userId}, #{msg}, "
            + "(SELECT NVL(MAX(group_id)+1,1) FROM gitsta_comment))")
    public void commentInsert(GitstaReVO vo);

    // 대댓글 정보 가져오기
    @Select("SELECT group_id, group_step, group_tab "
            + "FROM gitsta_comment "
            + "WHERE gno=#{gno}")
    public GitstaReVO commentParentInfoData(int gno);

    // 그룹 스텝 증가
    @Update("UPDATE gitsta_comment SET group_step=group_step+1 "
            + "WHERE group_id=#{group_id} AND group_step>#{group_step}")
    public void commentGroupStepIncrement(GitstaReVO vo);
 
    // 대댓글 추가
    @Insert("INSERT INTO gitsta_comment (gno, rno, userid, msg, group_id, group_step, group_tab, root) "
            + "VALUES (gc_gno_seq.NEXTVAL, #{rno}, #{userId}, #{msg}, #{group_id}, #{group_step}, #{group_tab}, #{root})")
    public void commentReplyReplyInsert(GitstaReVO vo);
  
    // depth 증가
    @Update("UPDATE gitsta_comment SET depth=depth+1 WHERE gno=#{gno}")
    public void commentDepthIncrement(int gno);

    // 댓글 삭제 관련 정보 가져오기
    @Select("SELECT group_id, group_step FROM gitsta_comment WHERE gno=#{gno}")
    public GitstaReVO commentDeleteInfoData(int gno);

    // 댓글 삭제
    @Delete("<script>"
            + "DELETE FROM gitsta_comment "
            + "WHERE <if test=\"group_step==0\">group_id=#{group_id}</if> "
            + "<if test=\"group_step!=0\">gno=#{gno}</if>"
            + "</script>")
    public void commentDelete(Map<String, Object> map);
    
    @Update("UPDATE gitsta_feed SET replycount = replycount + 1 WHERE no = #{rno}")
    public void commentReplyIncrement(int rno);

    // 댓글 수 감소 (해당 게시글의 댓글 수)
    @Update("UPDATE gitsta_feed SET replycount=replycount-1 WHERE no = #{rno}")
    public void commentReplyDecrement(int rno);

    // 댓글 수정
    @Update("UPDATE gitsta_comment SET msg=#{msg}, modifydate=SYSDATE WHERE gno=#{gno}")
    public void commentUpdate(GitstaReVO vo);
	
	
}
