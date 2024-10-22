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

}
