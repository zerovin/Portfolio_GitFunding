package com.sist.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.*;
import com.sist.dao.*;
import com.sist.vo.*;
@Service
public class FundingDetailBoardServiceImpl implements FundingDetailBoardService{
	@Autowired
	private FundingDetailBoardDAO bDao;
	
	@Override
	public List<FundingDetailNoticeVO> fundingNoticeListData(Map map) {
		// TODO Auto-generated method stub
		return bDao.fundingNoticeListData(map);
	}

	@Override
	public int fundingNoticeTotalPage() {
		// TODO Auto-generated method stub
		return bDao.fundingNoticeTotalPage();
	}

	@Override
	public FundingDetailNoticeVO fundingNoticeDetailData(int dnno) {
		// TODO Auto-generated method stub
		return bDao.fundingNoticeDetailData(dnno);
	}

	@Override
	public void fundingCommInsert(FundingDetailCommVO vo) {
		// TODO Auto-generated method stub
		bDao.fundingCommInsert(vo);
	}

	@Override
	public List<FundingDetailCommVO> fundingCommListData(int fno) {
		// TODO Auto-generated method stub
		return bDao.fundingCommListData(fno);
	}

	@Override
	public FundingDetailCommVO fundingCommUpdateData(int dcno) {
		// TODO Auto-generated method stub
		return bDao.fundingCommUpdateData(dcno);
	}

	@Override
	public void fundingCommUpdate(FundingDetailCommVO vo) {
		// TODO Auto-generated method stub
		bDao.fundingCommUpdate(vo);
	}

	@Override
	public void fundingCommDelete(int dcno) {
		// TODO Auto-generated method stub
		bDao.fundingCommDelete(dcno);
	}

	@Override
	public void commReplyInsert(int dcno, FundingDetailCommVO vo) {
		// TODO Auto-generated method stub
		bDao.commReplyInsert(dcno, vo);
	}



}
