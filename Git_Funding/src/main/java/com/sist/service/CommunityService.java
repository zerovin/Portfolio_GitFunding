package com.sist.service;

import java.util.List;
import java.util.Map;

import com.sist.vo.FaqVO;
import com.sist.vo.QnaVO;

public interface CommunityService {
	public List<FaqVO> faqListData(String cate);
	public List<QnaVO> qnaListData(int start,int end);
	public int qnaRowCount();
}
