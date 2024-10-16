package com.sist.mapper;

import java.util.Map;
import com.sist.vo.*;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

public interface WishMapper {
	// 위시리스트 체크
	@Select("SELECT COUNT(*) FROM funding_wish "
			+ "WHERE pno=#{pno} AND cate=#{cate} AND userId=#{userId}")
	public int fundingWishCheck(WishVO vo);
	
	// 위시리스트 추가
	@Update("UPDATE funding SET "
			+ "wish=wish+1 "
			+ "WHERE fno=#{fno}")
	public void fundingWishUpdate(int fno);
	@Insert("INSERT INTO funding_wish VALUES(fwish_wno_seq.nextval, #{userId}, #{pno}, #{cate}, SYSDATE)")
	public void fundingWishInsert(WishVO vo);
	
	//위시리스트 삭제 
	@Update("UPDATE funding SET "
			+ "wish=wish-1 "
			+ "WHERE fno=#{fno}")
	public void fundingWishtDecr(int fno);
	
	@Delete("DELETE FROM funding_wish WHERE pno=#{pno} AND cate=#{cate} AND userId=#{userId}")
	public void fundingWishDelete(WishVO vo);
}
