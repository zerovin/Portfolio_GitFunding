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

	@Override
	public void fundingAlertUpdate(int fno) {
		// TODO Auto-generated method stub
		fDao.fundingAlertUpdate(fno);
	}

	@Override
	public void fundingAlertInsert(Map map) {
		// TODO Auto-generated method stub
		fDao.fundingAlertInsert(map);
	}

	@Override
	public List<AlertVO> openAlertCheck(String id) {
		// TODO Auto-generated method stub
		return fDao.openAlertCheck(id);
	}

	@Override
	public void fundingAlertDecr(int fno) {
		// TODO Auto-generated method stub
		fDao.fundingAlertDecr(fno);
	}

	@Override
	public void fundingAlertDelete(Map map) {
		// TODO Auto-generated method stub
		fDao.fundingAlertDelete(map);
	}

}
