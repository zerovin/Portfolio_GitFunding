package com.sist.service;

import java.util.*;
import com.sist.vo.*;

public interface FundingService {
	public List<FundingVO> openListData(Map map);
	public int openTotalPage();
	public List<FundingVO> fundingListData(Map map);
	public int fundingTotalPage();
	public void fundingAlertUpdate(int fno);
	public void fundingAlertInsert(Map map);
}
