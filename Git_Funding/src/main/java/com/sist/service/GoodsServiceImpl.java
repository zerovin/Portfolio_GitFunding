package com.sist.service;
import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.dao.*;
import com.sist.vo.*;

@Service
public class GoodsServiceImpl implements GoodsService{
	private GoodsDAO gDao;
	@Autowired
	public GoodsServiceImpl(GoodsDAO dao) {
		this.gDao=dao;
	}
	@Override
	public List<GoodsVO> goodsListData(Map map) {
		// TODO Auto-generated method stub
		return gDao.goodsListData(map);
	}
	@Override
	public int goodsTotalData(String cate1) {
		// TODO Auto-generated method stub
		return gDao.goodsTotalData(cate1);
	}
	@Override
	public GoodsVO goodsDetailData(int fgno) {
		// TODO Auto-generated method stub
		gDao.goodsHitIncrement(fgno);
		return gDao.goodsDetailData(fgno);
	}
	@Override
	public void cartInsert(Map map) {
		gDao.cartInsert(map);
	}
	@Override
	public List<CartVO> cartListData(String id) {
		// TODO Auto-generated method stub
		return gDao.cartListData(id);
	}
	@Override
	public int cartCount(Map map) {
		// TODO Auto-generated method stub
		return gDao.cartCount(map);
	}
	@Override
	public void cartUpdate(Map map) {
		// TODO Auto-generated method stub
		gDao.cartUpdate(map);
		
	}
	@Override
	public void cartDelete(List<Integer> fgcno) {
		// TODO Auto-generated method stub
		gDao.cartDelete(fgcno);
	}
	@Override
	public List<CartVO> orderListData(List<Integer> fgcno) {
		// TODO Auto-generated method stub
		return gDao.orderListData(fgcno);
	}
	@Override
	public GoodsVO goodsOrderData(int fgno) {
		// TODO Auto-generated method stub
		return gDao.goodsOrderData(fgno);
	}
	@Override
	public void orderInsert(Map map) {
		// TODO Auto-generated method stub
		gDao.orderInsert(map);
	}
	@Override
	public void orderedDicInsert(Map map) {
		// TODO Auto-generated method stub
		gDao.orderedDicInsert(map);
	}
	@Override
	public int goodsEaData(Map map) {
		// TODO Auto-generated method stub
		return gDao.goodsEaData(map);
	}
	@Override
	public OrderGVO orderSelect(String id) {
		// TODO Auto-generated method stub
		return gDao.orderSelect(id);
	}
	@Override
	public OrderVO orderInfo(String fgono) {
		// TODO Auto-generated method stub
		return gDao.orderInfo(fgono);
	}
	
}
