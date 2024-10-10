package com.sist.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Select;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.mapper.CommunityMapper;
import com.sist.vo.FaqVO;
import com.sist.vo.QnaVO;

@Repository
public class CommunityDAO {
	@Autowired CommunityMapper mapper;
	
	public List<FaqVO> faqListData(String cate){
		return mapper.faqListData(cate);
	}
	// Qna 리스트
	public List<QnaVO> qnaListData(int start,int end){
		return mapper.qnaListData(start, end);
	}
	public int qnaRowCount() {
		return mapper.qnaRowCount();
	}
}
