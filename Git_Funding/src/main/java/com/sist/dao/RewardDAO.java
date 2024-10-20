package com.sist.dao;

import org.apache.ibatis.annotations.Select;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.util.*;
import com.sist.mapper.*;
import com.sist.vo.*;
@Repository
public class RewardDAO {
	@Autowired
	private RewardMapper mapper;
	
	/*
	@Select("SELECT rno, name, description, price, delivery "
			+ "FROM funding_reward "
			+ "WHERE rno=#{rno}")
	public FundingRewardVO rewardBuyData(int rno); 
	 */
	public FundingRewardVO rewardBuyData(int rno) {
		return mapper.rewardBuyData(rno);
	}
}
