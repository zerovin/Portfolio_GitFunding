package com.sist.mapper;
import java.util.*;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;

import com.sist.vo.*;

public interface GoodsMapper {
	
	public GoodsVO goodsDetailData(int fgno);
	public List<GoodsVO> goodsListData(Map map);
	
	
	@Select("SELECT COUNT(*) FROM f_goods WHERE cate1 LIKE '%'||#{cate1}||'%'")
	public int goodsTotalData(String cate1);
	
	@Results({
		   @Result(property = "gvo.goods_price",column = "goods_price")
	 })
	@Select("SELECT cno,gno,account,isBuy,TO_CHAR(regdate,'YYYY-MM-DD') as dbday,"
			  +"goods_name,goods_poster,goods_price "
			  +"FROM spring_cart sc,goods_all ga "
			  +"WHERE sc.gno=ga.no "
			  +"AND id=#{id} AND isBuy=1 "
			  +"ORDER BY cno DESC")
	   public List<GoodsVO> goodsBuyListData(String id);
}
