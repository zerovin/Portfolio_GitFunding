package com.sist.service;
import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.vo.*;
import com.sist.dao.*;
@Service
public class FundingServiceImpl implements FundingService{
	@Autowired
	private FundingDAO fDao;

	@Override
	public List<FundingVO> openListData(Map map) {
		// TODO Auto-generated method stub
		return fDao.openListData(map);
	}

	@Override
	public int openTotalPage() {
		// TODO Auto-generated method stub
		return fDao.openTotalPage();
	}
	
	@Override
	public List<FundingVO> fundingListData(Map map) {
		// TODO Auto-generated method stub
		return fDao.fundingListData(map);
	}

	@Override
	public int fundingTotalPage() {
		// TODO Auto-generated method stub
		return fDao.fundingTotalPage();
	}
}
