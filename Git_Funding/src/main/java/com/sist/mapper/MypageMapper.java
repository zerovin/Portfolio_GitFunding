package com.sist.mapper;
import com.sist.vo.*;
import java.util.*;

import org.apache.ibatis.annotations.Insert;
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
  
}
        