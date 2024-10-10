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
	public List<GoodsVO> goodsListData(int start, int end) {
		// TODO Auto-generated method stub
		return gDao.goodsListData(start, end);
	}
	@Override
	public String goodsImgdata(int fgno) {
		// TODO Auto-generated method stub
		return gDao.goodsImgdata(fgno);
	}
	
}
