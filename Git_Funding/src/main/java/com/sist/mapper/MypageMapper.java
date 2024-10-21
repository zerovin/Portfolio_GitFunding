package com.sist.mapper;
import com.sist.vo.*; 
import java.util.*;

import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
public interface MypageMapper {
	@Select("SELECT userId,userName,userPwd,gender,email,post,addr1,addr2,phone,profile,nickname "
			+"FROM funding_member "
			+"WHERE userId=#{userId}")
	public MemberVO mypageInfoData(String userId);
	
	@Update("UPDATE funding_member SET nickname=#{nickname} WHERE userId=#{userId}")
	public void SetNickname(Map map);  
	
	@Update("UPDATE funding_member SET email=#{email}, gender=#{gender}, addr1=#{addr1}, addr2=#{addr2}, post=#{post}, phone=#{phone} "
			+"WHERE userId=#{userId}")   
	public void mypageInfoUpdate(MemberVO vo);    
	   
	// 찜 목록  
	@Select("SELECT f.fno, f.title, f.type, f.thumb, w.wno, w.userId, w.cate, to_char(w.regdate, 'YYYY-MM-DD') as dbday " +
	        "FROM funding f " + 
	        "JOIN funding_wish w ON f.fno = w.pno " +
	        "WHERE w.userId = #{userId}")
	public List<WishVO> fundingWishList(String userId);
 
	@Select("SELECT COUNT(*) FROM funding_wish WHERE userId = #{userId}")
	public int fundingWishCount(String userId);
	
	// 알림 목록
	@Select("SELECT f.fno, f.title, f.type, f.thumb, a.ano, a.userId, to_char(a.regdate, 'YYYY-MM-DD') as dbday, " +
	        "to_char(f.startdate, 'YYYY-MM-DD') as startdate " +
	        "FROM funding f " +
	        "JOIN funding_alert a ON f.fno = a.fno " +
	        "WHERE a.userId = #{userId}")
	public List<AlertVO> fundingAlertList(String userId);
	
	@Select("SELECT COUNT(*) FROM funding_alert WHERE userId = #{userId}")
	public int fundingAlertCount(String userId);
  
}
        