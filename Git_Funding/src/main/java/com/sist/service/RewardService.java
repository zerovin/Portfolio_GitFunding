package com.sist.service;

import java.util.*;
import com.sist.vo.*;
public interface RewardService {
	public FundingRewardVO rewardBuyData(int rno);
	public void rewardBuyInsert(RewardBuyVO vo);
	public void rewardBuyMinusAmount(RewardBuyVO vo);
}
