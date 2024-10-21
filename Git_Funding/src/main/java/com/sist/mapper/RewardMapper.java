package com.sist.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.*;
import com.sist.vo.*;
public interface RewardMapper {
	//펀딩 상세 리워드 출력
	@Select("SELECT rno, name, description, price, delivery, amount "
			+ "FROM funding_reward "
			+ "WHERE rno=#{rno}")
	public FundingRewardVO rewardBuyData(int rno);
	
	//리워드 구매
	@Insert("INSERT INTO reward_buy VALUES(rbuy_rbno_seq.nextval, #{rno}, #{account}, #{price}, #{delivery}, #{totalprice}, #{userId}, #{name}, #{phone}, "
			+ "#{post}, #{addr1}, #{addr2}, #{requestMsg}, SYSDATE)")
	public void rewardBuyInsert(RewardBuyVO vo);
	
	@Update("UPDATE funding_reward SET "
			+ "amount=amount-#{account} "
			+ "WHERE rno=#{rno}")
	public void rewardBuyMinusAmount(RewardBuyVO vo);
}
