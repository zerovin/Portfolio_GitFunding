package com.sist.service;

import com.sist.vo.MemberVO;

public interface MemberService {
	public int idCheck(String userId);
	public MemberVO memberInfoData(String userId);
	public MemberVO memberSessionData(String userId);
}
