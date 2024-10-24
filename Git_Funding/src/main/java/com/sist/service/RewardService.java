package com.sist.service;

import java.util.*;
import com.sist.vo.*;
public interface RewardService {
	public FundingRewardVO rewardBuyData(int rno);
	public void rewardBuyInsert(RewardBuyVO vo);
	public void rewardBuyMinusAmount(RewardBuyVO vo);
	public List<RewardVO> project_rewardDetailList(int fno);
	public void fundingRewardInsert(RewardVO vo);
	
	public void rewardDelete(int fno, int rno);
}
