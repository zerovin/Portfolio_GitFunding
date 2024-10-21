package com.sist.service;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;

import com.sist.vo.*;
import com.sist.dao.*;

public interface NoticeService {
	public List<NoticeVO> noticeListData(Map map);
	public int noticeRowCount();
	public void noticeInsert(NoticeVO vo);
	public NoticeVO noticeDetailData(int no);
	public NoticeVO noticeUpdateData(int no);
	public void noticeUpdate(NoticeVO vo);
	public void noticeDelete(int no);
}
