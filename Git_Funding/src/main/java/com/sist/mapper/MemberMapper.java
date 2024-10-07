package com.sist.mapper;
import org.apache.ibatis.annotations.Select;

import com.sist.vo.*;
public interface MemberMapper {
	// 아이디 중복체
	@Select("SELECT COUNT(*) FROM funding_member "
			+ "WHERE userId=#{userId}")
	public int idCheck(String userId);
	
	//회원가
	
	//로그인
	@Select("SELECT userId, userName, userPwd, enabled, authority "
			+ "FROM funding_member fm, authority au "
			+ "WHERE fm.userId=au.userId "
			+ "AND fm.userId=#{userId}")
	public MemberVO memberInfoData(String userId);
	
	@Select("SELECT userId, userName, userPwd, gender, email, phone, post, addr1, addr2 "
			+ "FROM funding_member "
			+ "WHERE userId=#{userId}")
	public MemberVO memberSessionData(String userId);
}
