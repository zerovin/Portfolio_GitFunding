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
	public List<GitstaVO> gitstaTotalListData(String userId,int start, int end) {
		return gDao.gitstaTotalListData(userId,start, end);
	}

	@Override
	public int gitstaTotalCount(String userId) {
		return gDao.gitstaTotalCount(userId);
	}

	@Override
	public MemberVO gitstaInfoData(String userId) {
		return gDao.gitstaInfoData(userId);
	}

	@Override
	public void feedInsert(GitstaVO vo) {
		gDao.feedInsert(vo);
	}
}
