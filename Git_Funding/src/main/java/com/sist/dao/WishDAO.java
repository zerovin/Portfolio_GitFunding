package com.sist.dao;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.util.*;
import com.sist.mapper.*;
import com.sist.vo.*;
@Repository
public class WishDAO {
	@Autowired
	private WishMapper mapper;
	
	/*
	// 위시리스트 체크
	@Select("SELECT COUNT(*) FROM funding_wish "
			+ "WHERE pno=#{pno} AND cate=#{cate} AND userId=#{userId}")
	public int fundingWishCheck(WishVO vo); 
	 */
	public int fundingWishCheck(WishVO vo) {
		return mapper.fundingWishCheck(vo);
	}
	
	/*
	//위시리스트 추가 
	@Update("UPDATE funding SET "
			+ "wish=wish+1 "
			+ "WHERE fno=#{fno}")
	public void fundingWishUpdate(int fno);
	*/
	public void fundingWishUpdate(int fno) {
		mapper.fundingWishUpdate(fno);
	}
	
	/*
	@Insert("INSERT INTO funding_wish VALUES(fwish_wno_seq.nextval, #{userId}, #{pno}, #{cate}, SYSDATE)")
	public void fundingWishInsert(WishVO vo); 
	 */
	public void fundingWishInsert(WishVO vo) {
		mapper.fundingWishInsert(vo);
	}
	
	/*
	//위시리스트 삭제 
	@Update("UPDATE funding SET "
			+ "wish=wish-1 "
			+ "WHERE fno=#{fno}")
	public void fundingWishtDecr(int fno);
	*/
	public void fundingWishtDecr(int fno) {
		mapper.fundingWishtDecr(fno);
	}
	
	/*
	@Delete("DELETE FROM funding_wish WHERE pno=#{pno} AND cate=#{cate} AND userId=#{userId}")
	public void fundingWishDelete(WishVO vo); 
	 */
	public void fundingWishDelete(WishVO vo) {
		mapper.fundingWishDelete(vo);
	}
}
