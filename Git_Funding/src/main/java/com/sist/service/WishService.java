package com.sist.service;

import com.sist.vo.WishVO;

public interface WishService {
	public int fundingWishCheck(WishVO vo);
	public void fundingWishUpdate(int fno);
	public void fundingWishInsert(WishVO vo);
	public void fundingWishtDecr(int fno);
	public void fundingWishDelete(WishVO vo);
}
