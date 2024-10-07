package com.sist.dao;

import org.apache.ibatis.annotations.Select;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.sist.mapper.*;
import com.sist.vo.*;
@Repository
public class MemberDAO {
	@Autowired
	private MemberMapper mapper;
	
	/*
	@Select("SELECT COUNT(*) FROM funding_member "
			+ "WHERE userId=#{userId}")
	public int idCheck(String userId); 
	 */
	public int idCheck(String userId) {
		return mapper.idCheck(userId);
	}
	
	/*
	 @Select("SELECT userId, userName, userPwd, enabled, authority "
			+ "FROM funding_member fm, authority au "
			+ "WHERE fm.userId=au.userId "
			+ "AND fm.userId=#{userId}")
	public MemberVO memberInfoData(String userId);
	*/
	public MemberVO memberInfoData(String userId) {
		return mapper.memberInfoData(userId);
	}
	
	/*
	@Select("SELECT userId, userName, userPwd, gender, email, phone, post, addr1, addr2 "
			+ "FROM funding_member "
			+ "WHERE userId=#{userId}")
	public MemberVO memberSessionData(String userId); 
	 */
	public MemberVO memberSessionData(String userId) {
		return mapper.memberSessionData(userId);
	}
}
