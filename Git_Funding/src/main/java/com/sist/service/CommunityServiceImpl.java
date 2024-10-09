package com.sist.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.dao.CommunityDAO;
import com.sist.vo.FaqVO;

@Service
public class CommunityServiceImpl implements CommunityService{
	@Autowired
	private CommunityDAO cDao;

	@Override
	public List<FaqVO> faqListData(String cate) {
		return cDao.faqListData(cate);
	}
	
	
}
