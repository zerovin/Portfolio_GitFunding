package com.sist.service;

import java.util.List;

import com.sist.vo.FaqVO;

public interface CommunityService {
	public List<FaqVO> faqListData(String cate);
}
