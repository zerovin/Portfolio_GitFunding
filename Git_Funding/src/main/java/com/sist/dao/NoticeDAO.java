package com.sist.dao;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.vo.*;
import com.sist.mapper.*;

@Repository
public class NoticeDAO {
	@Autowired
	private NoticeMapper mapper;
	
	// 공지사항 목록, 총 개수
	public List<NoticeVO> noticeListData(Map map) {
		
		return mapper.noticeListData(map);
	}	
	public int noticeRowCount() {
		
		return mapper.noticeRowCount();
	}

	// 공지 작성
	public void noticeInsert(NoticeVO vo) {
		mapper.noticeInsert(vo);
	}
	
	// 공지사항 상세보기, 조회수 증가
	public NoticeVO noticeDetailData(int nno) {
		mapper.noticeHitIncrement(nno);
		
		return mapper.noticeDetailData(nno);
	}
	
	// 공지사항 수정 데이터, 수정
    public NoticeVO noticeUpdateData(int nno) {
    	
    	return mapper.noticeDetailData(nno);
    }
    public void noticeUpdate(NoticeVO vo) {
    	mapper.noticeUpdate(vo);
    }
    
    // 공지사항 삭제
    public void noticeDelete(int nno) {
    	mapper.noticeDelete(nno);
    }
}
