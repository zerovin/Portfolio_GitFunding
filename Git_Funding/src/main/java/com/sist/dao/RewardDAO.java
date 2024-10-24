package com.sist.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
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
	
	/*
	@Insert("INSERT reward_buy VALUES(NVL(MAX(rbno)+1,1), #{rno}, #{account}, #{price}, #{delivery}, #{totalprice}, #{userId}, #{name}, #{phone}, "
			+ "#{post}, #{addr1}, #{addr2}, #{requestMsg}, SYSDATE)")
	public void rewardBuyInsert(RewardBuyVO vo); 
	 */
	public void rewardBuyInsert(RewardBuyVO vo) {
		mapper.rewardBuyInsert(vo);
	}
	
	/*
	@Update("UPDATE funding_reward SET "
			+ "amount=amount-#{account} "
			+ "WHERE rno=#{rno}")
	public void rewardBuyMinusAmount(RewardBuyVO vo);
	 */
	public void rewardBuyMinusAmount(RewardBuyVO vo){
		mapper.rewardBuyMinusAmount(vo);
	}
	
	public List<RewardVO> project_rewardDetailList(int fno) {
		return mapper.project_rewardDetailList(fno);
	}
	
	public void fundingRewardInsert(RewardVO vo) {
		mapper.fundingRewardInsert(vo);
	}
	
	
	
	public void rewardDelete(int fno, int rno) {
		mapper.rewardDelete(fno, rno);
	}
}
