package com.sist.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.dao.MypageDAO;
import com.sist.vo.AlertVO;
import com.sist.vo.MemberVO;
import com.sist.vo.WishVO;

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

	@Override
	public void mypageInfoUpdate(MemberVO vo) {
		mDao.mypageInfoUpdate(vo);
		
	}

	@Override
	public List<WishVO> fundingWishList(String userId) {
		return mDao.fundingWishList(userId);
	}

	@Override
	public int fundingWishCount(String userId) {
		return mDao.fundingWishCount(userId);
	}

	@Override
	public List<AlertVO> fundingAlertList(String userId) {
		return mDao.fundingAlertList(userId);
	}

	@Override
	public int fundingAlertCount(String userId) {
		return mDao.fundingAlertCount(userId);
	}

}
