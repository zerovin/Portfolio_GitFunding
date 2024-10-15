package com.sist.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.util.*;
import com.sist.mapper.*;
import com.sist.vo.MemberVO;
@Repository
public class MypageDAO {
	@Autowired
	private MypageMapper mapper;
	
	public MemberVO mypageInfoData(String userId) {
		return mapper.mypageInfoData(userId);
	}
	
	public void SetNickname(Map map) {
		mapper.SetNickname(map);
	}
}
