package com.sist.service;
import java.util.*;
import com.sist.vo.*;
import com.sist.dao.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class GitstaServiceImpl implements GitstaService{
	@Autowired
	private GitstaDAO gDao;

	@Override
	public List<GitstaVO> gitstaMyTotalListData(String userId,int start, int end) {
		return gDao.gitstaMyTotalListData(userId,start, end);
	}

	@Override
	public int gitstaMyTotalCount(String userId) {
		return gDao.gitstaMyTotalCount(userId);
	}

	@Override
	public MemberVO gitstaInfoData(String userId) {
		return gDao.gitstaInfoData(userId);
	}

	@Override
	public void feedInsert(GitstaVO vo) {
		gDao.feedInsert(vo);
	}

	@Override
	public List<GitstaVO> gitstaTotalListData() {
		return gDao.gitstaTotalListData();
	}

	@Override
	public int gitstaTotalCount() {
		return gDao.gitstaTotalCount();
	}

	@Override
	public List<MemberVO> gitstaFollowingListData(String userId) {
		return gDao.gitstaFollowingListData(userId);
	}

	@Override
	public void insertFollow(String followerId, String followingId) {
		gDao.insertFollow(followerId, followingId);
	}

	@Override
	public void deleteFollow(String followerId, String followingId) {
		gDao.deleteFollow(followerId, followingId);
	}

	@Override
	public int getFollowingCount(String userId) {
		return gDao.getFollowingCount(userId);
	}

	@Override
	public List<MemberVO> gitstaFollowerListData(String userId) {
		return gDao.gitstaFollowerListData(userId);
	}

	@Override
	public int getFollowerCount(String userId) {
		return gDao.getFollowerCount(userId);
	}
}
