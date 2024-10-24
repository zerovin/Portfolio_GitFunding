package com.sist.service;
import java.util.*;
import com.sist.vo.*;

public interface GoodsService {
	public List<GoodsVO> goodsListData(Map map);
	public int goodsTotalData(Map map);
	public GoodsVO goodsDetailData(int fgno);
	public void cartInsert(Map map);
	public List<CartVO> cartListData(String id);
	public int cartCount(Map map);
	public void cartUpdate(Map map);
	public void cartDelete(List<Integer> fgcno);
	public List<CartVO> orderListData(List<Integer> fgcno);
	public GoodsVO goodsOrderData(int fgno);
	public void orderInsert(Map map);
	public void orderedDicInsert(Map map);
	public int goodsEaData(Map map);
	public OrderGVO orderSelect(String id);
	 public List<OrderVO> orderInfo(String fgono);
	 public List<OrderGVO> mypageStore(Map map);
	 public int mypageStoreTotal(String id);
	 public OrderGVO mypageOrder(String fgono);
}