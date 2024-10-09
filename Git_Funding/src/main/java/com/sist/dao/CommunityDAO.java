package com.sist.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.mapper.CommunityMapper;
import com.sist.vo.FaqVO;

@Repository
public class CommunityDAO {
	@Autowired CommunityMapper mapper;
	
	public List<FaqVO> faqListData(String cate){
		return mapper.faqListData(cate);
	}

}
