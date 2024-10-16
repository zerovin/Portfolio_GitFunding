package com.sist.service;
import java.util.*;
import com.sist.vo.*;

public interface GoodsService {
	public List<GoodsVO> goodsListData(int start,int end, String cate1);
	public int goodsTotalData(String cate1);
	public GoodsVO goodsDetailData(int fgno);
}