package com.sist.mapper;
import java.util.*;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.sist.vo.*;    
public interface GitstaMapper {    
	
	@Select("SELECT userId,userName,userPwd,gender,email,post,addr1,addr2,phone,profile,nickname,msg "
			+"FROM funding_member "    
			+"WHERE userId=#{userId}")  
	public MemberVO gitstaInfoData(String userId);
	 
	@Select("SELECT f.no, f.content, m.userId, m.nickname, f.filename, f.filesize, f.filecount, "
			+ "TO_CHAR(f.regdate, 'YYYY-MM-DD') as dbday, TO_CHAR(f.modifydate, 'YYYY-MM-DD') as mday, f.num "
			+ "FROM (SELECT no, content, userId, filename, filesize, filecount, regdate, modifydate, rownum as num "
			+ "FROM (SELECT no, content, userId, filename, filesize, filecount, regdate, modifydate "
			+ "FROM gitsta_feed WHERE userId = #{userId} ORDER BY no DESC)) f "
			+ "JOIN funding_member m ON f.userId = m.userId "
			+ "WHERE f.num BETWEEN #{start} AND #{end}")
	public List<GitstaVO> gitstaMyTotalListData(@Param("userId") String userId, @Param("start") int start, @Param("end") int end);
	   
	@Select("SELECT COUNT(*) FROM gitsta_feed WHERE userId=#{userId}")
	public int gitstaMyTotalCount(String userId);  
	   
	@Select("SELECT f.no, f.content, f.filename, f.filesize, f.filecount, "
	        + "TO_CHAR(f.regdate, 'YYYY-MM-DD') as dbday, TO_CHAR(f.modifydate, 'YYYY-MM-DD') as mday,"
	        + "f.userId, m.userName, m.nickname, m.profile "
	        + "FROM gitsta_feed f "
	        + "LEFT JOIN funding_member m ON f.userId = m.userId "
	        + "ORDER BY f.no DESC")
	public List<GitstaVO> gitstaTotalListData();
 

	@Select("SELECT COUNT(*) FROM gitsta_feed")
	public int gitstaTotalCount();
	
	@Select("SELECT no, userId,content, filename, filesize, filecount,"
			+ "TO_CHAR(regdate, 'YYYY-MM-DD') as dbday, TO_CHAR(modifydate, 'YYYY-MM-DD') as mday "
			+ "FROM gitsta_feed WHERE no=#{no}")
	public GitstaVO gitstaDetailData(int no);
	
	@Insert("INSERT INTO gitsta_feed(no,userId,content,filename,filesize,filecount,modifydate) "
	  		+ "VALUES(gf_no_seq.nextval,#{userId},#{content},#{filename},#{filesize},#{filecount},SYSDATE)")
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
	
}
