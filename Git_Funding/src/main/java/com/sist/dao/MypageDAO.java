package com.sist.dao;

import org.apache.ibatis.annotations.Select;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.util.*;
import com.sist.mapper.*;
import com.sist.vo.AlertVO;
import com.sist.vo.MemberVO;
import com.sist.vo.WishVO;
@Repository
public class MypageDAO {
	@Autowired
	private MypageMapper mapper;
	
	public MemberVO mypageInfoData(String userId) {
		return mapper.mypageInfoData(userId);
	}
	
	public void SetNickname(Map map) {
		mapper.SetNickname(map);
	}
	public void mypageInfoUpdate(MemberVO vo) {
		mapper.mypageInfoUpdate(vo);
	}
	// 찜
	public List<WishVO> fundingWishList(String userId){
		return mapper.fundingWishList(userId);
	}
	
	@Select("SELECT COUNT(*) FROM funding_wish WHERE userId = #{userId}")
	public int fundingWishCount(String userId) {
		return mapper.fundingWishCount(userId);
	}
	// 알림
	public List<AlertVO> fundingAlertList(String userId){
		return mapper.fundingAlertList(userId);
	}
	
	@Select("SELECT COUNT(*) FROM funding_alert WHERE userId = #{userId}")
	public int fundingAlertCount(String userId) {
		return mapper.fundingAlertCount(userId);
	}
}
