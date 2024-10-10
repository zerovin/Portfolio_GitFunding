package com.sist.mapper;
import java.util.*;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.sist.vo.*;

public interface GoodsMapper {
	@Select("SELECT fgno,title,brand,discount,price,num "
			+ "FROM (SELECT fgno,title,brand,discount,price,rownum as num "
			+ "FROM (SELECT /*+INDEX_ASC(fg fgs_fgno_pk)*/fg.fgno,fg.title,fg.brand,fg.discount,fg.price "
			+ "FROM f_goods fg ))"
			+ "WHERE num BETWEEN #{start} AND #{end}")
	public List<GoodsVO> goodsListData(@Param("start")int start,@Param("end")int end);
	
	@Select("SELECT img "
			+ "FROM f_goods_img "
			+ "WHERE fgno=#{fgno} AND rownum=1")
	public String goodsImgdata(int fgno);
}
