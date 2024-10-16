package com.sist.mapper;
import java.util.*;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;

import com.sist.vo.*;

public interface GoodsMapper {
	
	public List<GoodsVO> goodsDetailData(Map map);
	
	
	
	@Select("SELECT fgno,title,brand,discount,price,img,num "
			+ "FROM (SELECT fgno,title,brand,discount,price,img,rownum as num "
			+ "FROM (SELECT /*+INDEX_ASC(fg fgs_fgno_pk)*/fg.fgno,fg.title,fg.brand,fg.discount,fg.price,fgi.img "
			+ "FROM f_goods fg LEFT JOIN (SELECT fgno,MAX(img) as img FROM f_goods_img fgi GROUP BY fgno order by fgno) fgi "
			+ "ON fg.fgno=fgi.fgno "
			+ "WHERE fg.cate1 LIKE '%'||#{cate1}||'%')) "
			+ "WHERE num BETWEEN #{start} AND #{end}")
	public List<GoodsVO> goodsListData(@Param("start")int start,@Param("end")int end,@Param("cate1")String cate1);
	
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
