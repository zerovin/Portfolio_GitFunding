package com.sist.service;

import java.util.*;

import com.sist.vo.*;

public interface FundingDetailBoardService {
	public List<FundingDetailNoticeVO> fundingNoticeListData(Map map);
	public int fundingNoticeTotalPage();
	public FundingDetailNoticeVO fundingNoticeDetailData(int dnno);
	public void fundingCommInsert(FundingDetailCommVO vo);
}
