package com.sist.dao;
import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.vo.*;
import com.sist.mapper.*;

@Repository
public class GoodsDAO {
	private GoodsMapper mapper;
	@Autowired
	public GoodsDAO(GoodsMapper mapper){
		this.mapper=mapper;
	}
	
	public List<GoodsVO> goodsListData(Map map){
		return mapper.goodsListData(map);
		
	}
	
	public int goodsTotalData(String cate1) {
		return mapper.goodsTotalData(cate1);
	}
	
	public GoodsVO goodsDetailData(int fgno){
		return mapper.goodsDetailData(fgno);
	}
	public void goodsHitIncrement(int fgno) {
		mapper.goodsHitIncrement(fgno);
	}
	public void cartInsert(Map map) {
		mapper.cartInsert(map);
	}
	
	public List<CartVO> cartListData(String id){
		return mapper.cartListData(id);
	}
	public int cartCount(Map map) {
		return mapper.cartCount(map);
	}
	public void cartUpdate(Map map) {
		mapper.cartUpdate(map);
	}
	public void cartDelete(List<Integer> fgcno) {
		mapper.cartDelete(fgcno);
	}
	
	public List<CartVO> orderListData(List<Integer> fgcno){
		return mapper.orderListData(fgcno);
	}
	
	public GoodsVO goodsOrderData(int fgno) {
		return mapper.goodsOrderData(fgno);
	}
	
	public void orderInsert(Map map) {
		mapper.orderInsert(map);
	}
	
	public void orderedDicInsert(Map map) {
		mapper.orderedDicInsert(map);
	}
	
	public int goodsEaData(Map map) {
		return mapper.goodsEaData(map);
	}
	public OrderGVO orderSelect(String id) {
		return mapper.orderSelect(id);
	}
}
