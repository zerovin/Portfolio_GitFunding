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
	
	public List<GoodsVO> goodsListData(int start,int end,String cate1){
		return mapper.goodsListData(start, end , cate1);
		
	}
	
	public int goodsTotalData(String cate1) {
		return mapper.goodsTotalData(cate1);
	}
}
