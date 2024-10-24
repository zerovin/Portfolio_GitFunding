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
			+ "#{post}, #{addr1}, #{addr2}, #{requestMsg}, SYSDATE, #{fno})")
	public void rewardBuyInsert(RewardBuyVO vo);
	
	@Update("UPDATE funding_reward SET "
			+ "amount=amount-#{account} "
			+ "WHERE rno=#{rno}")
	public void rewardBuyMinusAmount(RewardBuyVO vo);
	
	/*
	 * 	private int rno, fno, price, amount, delivery, limit;
		private String name, description, del_start, userId;
	 */
	@Select("SELECT rno, fno, price, amount, delivery, limit, name, description, del_start, userId "
			+ "FROM funding_reward "
			+ "WHERE fno=#{fno}")
	public List<RewardVO> project_rewardDetailList(int fno);
	
	// 펀딩 프로젝트 생성의 리워드 등록
	// 리워드 넘버, funding번호 (참조), 리워드 이름, 리워드 가격, 리워드 현재 개수, 리워드 설명, 리워드 배송비, 리워드 배송 시작일, 리워드 총 개수
	@Insert("INSERT INTO funding_reward (rno, fno, name, price, amount, description, delivery, del_start, limit, userId) "
			+ "VALUES(fr_rno_seq.nextval, #{fno}, #{name}, #{price}, #{amount}, #{description}, #{delivery}, #{del_start}, #{limit}, #{userId})")
	public void funding_rewardInsert(RewardVO vo);
}
