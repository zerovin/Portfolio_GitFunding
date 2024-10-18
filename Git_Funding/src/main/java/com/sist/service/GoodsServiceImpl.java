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
	public void cartDelete(int fgcno) {
		// TODO Auto-generated method stub
		gDao.cartDelete(fgcno);
	}
	

	
}
