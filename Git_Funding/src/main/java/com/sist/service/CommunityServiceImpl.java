package com.sist.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.dao.CommunityDAO;
import com.sist.vo.FaqVO;
import com.sist.vo.QnaVO;

@Service
public class CommunityServiceImpl implements CommunityService{
	@Autowired
	private CommunityDAO cDao;

	@Override
	public List<FaqVO> faqListData(String cate) {
		return cDao.faqListData(cate);
	}

	@Override
	public List<QnaVO> qnaListData(int start,int end) {
		return cDao.qnaListData(start, end);
	}

	@Override
	public int qnaRowCount() {
		return cDao.qnaRowCount();
	}
	
	
}
