package com.sist.dao;

import org.apache.ibatis.annotations.Select;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.util.*;
import com.sist.mapper.*;
import com.sist.vo.AlertVO;
import com.sist.vo.FundingDetailCommVO;
import com.sist.vo.FundingVO;
import com.sist.vo.MemberVO;
import com.sist.vo.RewardBuyVO;
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
	
	//펀딩 구매 내역
	public List<RewardBuyVO> getRewardBuyList(Map map){
		return mapper.getRewardBuyList(map);
	}

    public int getTotalRewardBuyCount(String userId) {
    	return mapper.getTotalRewardBuyCount(userId);
    }

    public RewardBuyVO getPurchaseDetail(int rbno) {
    	return mapper.getPurchaseDetail(rbno);
    }
    // 상품 구매
    public int goodsBuyTotalCount(String userId) {
    	return mapper.goodsBuyTotalCount(userId);
    }
    
    // 커뮤니티 관리
    /*
     * @Select("SELECT c.dcno, c.fno, c.userId, c.cate, c.content, TO_CHAR(c.regdate, 'YYYY.MM.DD HH24:MI:SS') as dbday," 
            +"f.title, f.thumb, c.num " 
            +"FROM (SELECT dcno, fno, userId, cate, content, regdate, rownum as num " 
            +"FROM (SELECT dcno, fno, userId, cate, content, regdate " 
            +"FROM funding_detail_comm WHERE userId = #{userId} ORDER BY dcno DESC) " 
            +"WHERE rownum <= #{end}) c " 
            +"JOIN funding f ON c.fno = f.fno " 
            +"WHERE c.num BETWEEN #{start} AND #{end}")
	    List<FundingDetailCommVO> myFundingCommuList(String userId);
	
	    @Select("SELECT CEIL(COUNT(*)/5.0) FROM funding_detail_comm WHERE userId = #{userId}")
	    int myFundingCommuTotalPage(String userId);
	
	    @Select("SELECT COUNT(*) FROM funding_detail_comm WHERE userId = #{userId}")
	    int myFundingCommuListCount(String userId);
     */
    
    
    // 프로젝트 관리자 펀딩 내역
    public List<FundingVO> myFundingListData(Map map){
    	return mapper.myFundingListData(map);
    }
	
	public int myFundingTotalCount(String userId) {
		return mapper.myFundingTotalCount(userId);
	}
	
	public int myFundingTotalPage(String userId) {
		return mapper.myFundingTotalPage(userId);
	}
	public List<FundingVO> myFundingTotalData(String userId){
		return mapper.myFundingTotalData(userId);
	}
	
}
