package com.sist.service;

import java.util.List;
import java.util.Map;

import com.sist.vo.MemberVO;

public interface MemberService {
	public void memberInsert(MemberVO vo);
	public void memberAuthorityInsert(String userId);
	public int idCheck(String userId);
	public MemberVO memberInfoData(String userId);
	public MemberVO memberSessionData(String userId);
	public MemberVO rewardDeliveryMemberInfo(String userId);
	public List<MemberVO> memberListData(Map map);
}
