package com.sist.mapper;
import java.util.*;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.sist.vo.*;

public interface GoodsMapper {
	
	public GoodsVO goodsDetailData(int fgno);
	public List<GoodsVO> goodsListData(Map map);
	public List<CartVO> cartListData(String id);
	
	@Select("SELECT COUNT(*) FROM f_goods WHERE cate1 LIKE '%'||#{cate1}||'%'")
	public int goodsTotalData(String cate1);
	
	@Insert("INSERT INTO f_goods_cart VALUES(fgc_fgcno_seq.nextval,#{fgno},#{id},#{account},#{price},#{ops})")
	public void cartInsert(Map map);
	
	@Select("SELECT COUNT(*) FROM f_goods_cart WHERE fgno=#{fgno} AND id=#{id} AND ops=#{ops}")
	public int cartCount(Map map);
	
	@Update("UPDATE f_goods_cart SET account=#{account} WHERE fgno=#{fgno} AND id=#{id} AND ops=#{ops}")
	public void cartUpdate(Map map);
	
	@Delete("DELETE FROM f_goods_cart WHERE fgcno=#{fgcno}")
	public void cartDelete(int fgcno);
}
