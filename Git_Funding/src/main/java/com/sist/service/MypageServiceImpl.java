package com.sist.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.dao.MypageDAO;
import com.sist.vo.MemberVO;

@Service
public class MypageServiceImpl implements MypageService{
	@Autowired
	private MypageDAO mDao;

	@Override
	public MemberVO mypageInfoData(String userId) {
		return mDao.mypageInfoData(userId);
	}

	@Override
	public void SetNickname(Map map) {
		mDao.SetNickname(map);
	}
}
