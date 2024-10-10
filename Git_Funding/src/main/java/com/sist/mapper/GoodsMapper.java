package com.sist.mapper;
import java.util.*;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.sist.vo.*;

public interface GoodsMapper {
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
}
