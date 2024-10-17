package com.sist.service;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.vo.*;
import com.sist.dao.*;

@Service
public class NoticeServiceImpl implements NoticeService {
	@Autowired
	private NoticeDAO nDao;

	@Override
	public List<NoticeVO> noticeListData(Map map) {
		return nDao.noticeListData(map);
	}

	@Override
	public int noticeRowCount() {
		return nDao.noticeRowCount();
	}

	@Override
	public void noticeInsert(NoticeVO vo) {
		nDao.noticeInsert(vo);
	}

	@Override
	public NoticeVO noticeDetailData(int nno) {
		return nDao.noticeDetailData(nno);
	}

	@Override
	public NoticeVO noticeUpdateData(int nno) {
		return nDao.noticeUpdateData(nno);
	}

	@Override
	public void noticeUpdate(NoticeVO vo) {
		nDao.noticeUpdate(vo);
	}

	@Override
	public void noticeDelete(int nno) {
		nDao.noticeDelete(nno);
	}
}
