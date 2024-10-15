package com.sist.service;

import java.util.Map;

import com.sist.vo.*;

public interface MypageService {
	public MemberVO mypageInfoData(String userId);
	public void SetNickname(Map map);
}
