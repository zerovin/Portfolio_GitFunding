package com.sist.service;

import java.util.*;

import com.sist.vo.FundingDetailNoticeVO;

public interface FundingDetailBoardService {
	public List<FundingDetailNoticeVO> fundingNoticeListData(Map map);
	public int fundingNoticeTotalPage();
}
