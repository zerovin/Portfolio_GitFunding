package com.sist.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
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

	public List<QnaVO> qnaListData(int start,int end){
		return mapper.qnaListData(start, end);
	}
	
	public int qnaRowCount() {
		return mapper.qnaRowCount();
	}
	
    public String nicknameNullCheck(String id) {
    	return mapper.nicknameNullCheck(id);
    }

	public void qnaInsert(QnaVO vo) {
		mapper.qnaInsert(vo);
	}
	
    public QnaVO qnaDetailData(int qno) {
    	mapper.qnaHitIncrement(qno);
    	return mapper.qnaDetailData(qno);
    }
    
    public List<QnaVO> qnaAnswerDetail(int groupId){
    	return mapper.qnaAnswerDetail(groupId);
    }
    
    public void qnaDelete(int groupId) {
    	mapper.qnaDelete(groupId);
    }
    public QnaVO qnaUpdateData(int qno) {
    	return mapper.qnaUpdateData(qno);
    }
    
    public void qnaUpdate(QnaVO vo) {
    	mapper.qnaUpdate(vo);
    }
}
