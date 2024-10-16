package com.sist.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.*;
import com.sist.dao.*;
import com.sist.vo.*;
@Service
public class WishServiceImpl implements WishService{
	@Autowired
	private WishDAO wDao;

	@Override
	public int fundingWishCheck(WishVO vo) {
		// TODO Auto-generated method stub
		return wDao.fundingWishCheck(vo);
	}
	
	@Override
	public void fundingWishUpdate(int fno) {
		// TODO Auto-generated method stub
		wDao.fundingWishUpdate(fno);
	}

	@Override
	public void fundingWishInsert(WishVO vo) {
		// TODO Auto-generated method stub
		wDao.fundingWishInsert(vo);
	}

	@Override
	public void fundingWishtDecr(int fno) {
		// TODO Auto-generated method stub
		wDao.fundingWishtDecr(fno);
	}

	@Override
	public void fundingWishDelete(WishVO vo) {
		// TODO Auto-generated method stub
		wDao.fundingWishDelete(vo);
	}

	
	
}
