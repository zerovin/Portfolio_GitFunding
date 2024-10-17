package com.sist.mapper;
import java.util.*;

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
	public List<GitstaVO> gitstaTotalListData(@Param("userId") String userId, @Param("start") int start, @Param("end") int end);
	
	@Select("SELECT CEIL(COUNT(*)/10.0) FROM gitsta_feed WHERE userId=#{userId}")
	public int gitstaTotalCount(String userId);   
	
	@Select("SELECT no, userId,content, filename, filesize, filecount,"
			+ "TO_CHAR(regdate, 'YYYY-MM-DD') as dbday, TO_CHAR(modifydate, 'YYYY-MM-DD') as mday "
			+ "FROM gitsta_feed WHERE no=#{no}")
	public GitstaVO gitstaDetailData(int no);
	
	@Insert("INSERT INTO gitsta_feed(no,userId,content,filename,filesize,filecount,modifydate) "
	  		+ "VALUES(gf_no_seq.nextval,#{userId},#{content},#{filename},#{filesize},#{filecount},SYSDATE)")
	public void feedInsert(GitstaVO vo);
	  
}
