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
		System.out.println(vo + "VO가 제대로 처리되고있는지 확인");
	}
	
	// 공지사항 상세보기, 조회수 증가
	public NoticeVO noticeDetailData(int no) {
		mapper.noticeHitIncrement(no);
		
		return mapper.noticeDetailData(no);
	}
	
	// 공지사항 수정 데이터, 수정
    public NoticeVO noticeUpdateData(int no) {
    	
    	return mapper.noticeDetailData(no);
    }
    public void noticeUpdate(NoticeVO vo) {
    	mapper.noticeUpdate(vo);
    }
    
    // 공지사항 삭제
    public void noticeDelete(int no) {
    	mapper.noticeDelete(no);
    }
}
