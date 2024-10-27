package com.sist.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
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
	@Insert("INSERT INTO funding_member(userId, userName, userPwd, enable, gender, email, post, addr1, addr2, phone, profile, nickname) "
			+ "VALUES(#{userId}, #{userName}, #{userPwd}, 1, #{gender}, #{email}, #{post}, #{add1}, #{addr2}, #{phone}, '../images/profile.png', #{userName})")
	public void memberInsert(MemberVO vo);
	*/
	public void memberInsert(MemberVO vo) {
		mapper.memberInsert(vo);
	}
	
	/*
	@Insert("INSERT INTO authority VALUES(#{userId}, 'ROLE_USER')")
	public void memberAuthorityInsert(String userId); 
	 */
	public void memberAuthorityInsert(String userId) {
		mapper.memberAuthorityInsert(userId);
	}
	
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
	
	/*
	//배송정보
	@Select("SELECT userId, userName, phone, post, addr1, addr2 "
			+ "FROM funding_member "
			+ "WHERE userId=#{userId}")
	public MemberVO rewardDeliveryMemberInfo(String id); 
	 */
	public MemberVO rewardDeliveryMemberInfo(String userId) {
		return mapper.rewardDeliveryMemberInfo(userId);
	}
	
	public List<MemberVO> memberListData(Map map) {
		return mapper.memberListData(map);
	}
}
