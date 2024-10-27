package com.sist.service;

import java.util.*;

import com.sist.vo.*;

public interface FundingDetailBoardService {
	public List<FundingDetailNoticeVO> fundingNoticeListData(Map map);
	public int fundingNoticeTotalPage();
	public FundingDetailNoticeVO fundingNoticeDetailData(int dnno);
	public void fundingCommInsert(FundingDetailCommVO vo);
	public List<FundingDetailCommVO> fundingCommListData(int fno);
	public FundingDetailCommVO fundingCommUpdateData(int dcno);
	public FundingDetailCommVO commDeleteInfoData(int dcno);
	public void commDelete(Map map);
	public void fundingCommUpdate(FundingDetailCommVO vo);
	public void commReplyInsert(int dcno, FundingDetailCommVO vo);
	public void commReplyUpdate(FundingDetailCommVO vo);
}
