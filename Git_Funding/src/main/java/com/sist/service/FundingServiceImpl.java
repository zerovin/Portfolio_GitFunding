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

	@Override
	public FundingVO fundingDetailData(int fno) {
		// TODO Auto-generated method stub
		return fDao.fundingDetailData(fno);
	}

	@Override
	public List<FundingImgVO> fundingImgDetailData(int fno) {
		// TODO Auto-generated method stub
		return fDao.fundingImgDetailData(fno);
	}

	@Override
	public List<FundingRewardVO> fundingRewardDetailData(int fno) {
		// TODO Auto-generated method stub
		return fDao.fundingRewardDetailData(fno);
	}

	@Override
	public List<FundingVO> mainWishListData() {
		// TODO Auto-generated method stub
		return fDao.mainWishListData();
	}

	@Override
	public List<FundingVO> mainBackingListData() {
		// TODO Auto-generated method stub
		return fDao.mainBackingListData();
	}

	@Override
	public List<FundingVO> mainTodayListData() {
		// TODO Auto-generated method stub
		return fDao.mainTodayListData();
	}

	@Override
	public List<FundingVO> mainDeadlineListData() {
		// TODO Auto-generated method stub
		return fDao.mainDeadlineListData();
	}

	@Override
	public List<FundingVO> openCateListData(Map map) {
		// TODO Auto-generated method stub
		return fDao.openCateListData(map);
	}

	@Override
	public int openCateTotalPage(String cate) {
		// TODO Auto-generated method stub
		return fDao.openCateTotalPage(cate);
	}

	@Override
	public List<FundingVO> fundingCateListData(Map map) {
		// TODO Auto-generated method stub
		return fDao.fundingCateListData(map);
	}

	@Override
	public int fundingCateTotalPage(String cate) {
		// TODO Auto-generated method stub
		return fDao.fundingCateTotalPage(cate);
	}

	@Override
	public AdVO mainAdData() {
		// TODO Auto-generated method stub
		return fDao.mainAdData();
	}

	@Override
	public FundingVO mainCookieListData(int fno) {
		// TODO Auto-generated method stub
		return fDao.mainCookieListData(fno);
	}

	@Override
	public void fundingBackingInsert(Map map) {
		// TODO Auto-generated method stub
		fDao.fundingBackingInsert(map);
	}

	@Override
	public void fundingBackingInce(int fno) {
		// TODO Auto-generated method stub
		fDao.fundingBackingInce(fno);
	}

	@Override
	public List<FundingVO> mainFundingRankListData() {
		// TODO Auto-generated method stub
		return fDao.mainFundingRankListData();
	}

	@Override
	public List<GoodsVO> mainStoreRankListData() {
		// TODO Auto-generated method stub
		return fDao.mainStoreRankListData();
	}

	@Override
	public void funding_insert() {
		fDao.funding_insert();
	}

	@Override
	public void fundingImgInsert(Map map) {
		fDao.fundingImgInsert(map);
	}

//	@Override
//	public void funding_rewardInsert(Map map) {
//		fDao.funding_rewardInsert(map);
//	}
}
