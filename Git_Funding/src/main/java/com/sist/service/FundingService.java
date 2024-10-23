package com.sist.service;

import java.util.*;
import com.sist.vo.*;

public interface FundingService {
	//메인
	public List<FundingVO> mainWishListData();
	public List<FundingVO> mainBackingListData();
	public List<FundingVO> mainFundingRankListData();
	public List<GoodsVO> mainStoreRankListData();
	public List<FundingVO> mainTodayListData();
	public List<FundingVO> mainDeadlineListData();
	public FundingVO mainCookieListData(int fno);
	public AdVO mainAdData();
	
	//오픈예정
	public List<FundingVO> openListData(Map map);
	public int openTotalPage();
	public List<FundingVO> openCateListData(Map map);
	public int openCateTotalPage(String cate);
	
	//오픈알림
	public void fundingAlertUpdate(int fno);
	public void fundingAlertInsert(Map map);
	public List<AlertVO> openAlertCheck(String id);
	public void fundingAlertDecr(int fno);
	public void fundingAlertDelete(Map map);
	
	//펀딩
	public List<FundingVO> fundingListData(Map map);
	public int fundingTotalPage();
	public List<FundingVO> fundingCateListData(Map map);
	public int fundingCateTotalPage(String cate);
	public void funding_insert();
	public void fundingImgInsert(Map map);
	public void funding_rewardInsert(Map map);
	
	//상세
	public FundingVO fundingDetailData(int fno);
	public List<FundingImgVO> fundingImgDetailData(int fno);
	public List<FundingRewardVO> fundingRewardDetailData(int fno);
	public void fundingBackingInsert(Map map);
	public void fundingBackingInce(int fno);
}
