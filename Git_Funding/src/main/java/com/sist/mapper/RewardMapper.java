package com.sist.mapper;

import org.apache.ibatis.annotations.Select;
import java.util.*;
import com.sist.vo.*;
public interface RewardMapper {
	@Select("SELECT rno, name, description, price, delivery, amount "
			+ "FROM funding_reward "
			+ "WHERE rno=#{rno}")
	public FundingRewardVO rewardBuyData(int rno);
}
