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
	public List<CartVO> orderListData(List<Integer> fgcno);
	public void cartDelete(List<Integer> fgcno);
	
	@Select("SELECT COUNT(*) FROM f_goods WHERE ${cateInfo} LIKE '%'||#{cate}||'%'")
	public int goodsTotalData(Map map);
	
	@Update("UPDATE f_goods SET hit=hit+1 WHERE fgno=#{fgno}")
	public void goodsHitIncrement(int fgno);
	
	@Insert("INSERT INTO f_goods_cart VALUES(fgc_fgcno_seq.nextval,#{fgno},#{id},#{account},#{price},#{ops})")
	public void cartInsert(Map map);
	
	@Select("SELECT COUNT(*) FROM f_goods_cart WHERE fgno=#{fgno} AND id=#{id} AND ops=#{ops}")
	public int cartCount(Map map);
	
	@Update("UPDATE f_goods_cart SET account=#{account} WHERE fgno=#{fgno} AND id=#{id} AND ops=#{ops}")
	public void cartUpdate(Map map);

	@Select("SELECT title,brand,price,discount,delivery,fgi.img as img "
			+ "FROM f_goods fg LEFT JOIN (SELECT fgno,MAX(img) as img FROM f_goods_img fgi GROUP BY fgno order by fgno) fgi "
			+ "ON fg.fgno=fgi.fgno "
			+ "WHERE fg.fgno=#{fgno}")
	public GoodsVO goodsOrderData(int fgno);
	
	
	@Insert("INSERT INTO f_goods_order(fgono,id,payment,recvaddress,msg,send,recv,sendphone,recvphone,email) "
			+ "VALUES(#{fgono},#{id},#{payment},#{recvaddress},#{msg},#{send},#{recv},#{sendPhone},#{recvPhone},#{email})")
	public void orderInsert(Map map);

	// 남은 수량 검사
	@Select("SELECT ea FROM f_goods_option WHERE fgno=#{fgno} AND ops=#{ops}")
	public int goodsEaData(Map map);
	
	@Insert("INSERT INTO f_ordered VALUES(#{fgono},#{fgno},#{ops},#{account})")
	public void orderedDicInsert(Map map);
	
	// 주문 확인
	
	 @Select("SELECT * FROM (SELECT * FROM f_goods_order WHERE id=#{id} ORDER BY buydate DESC) WHERE rownum=1") 
	 public OrderGVO orderSelect(String id);
	 
	 @Select("SELECT fo.ops as ops ,fg.title as title ,fo.account as account "
	 		+ "FROM f_goods fg JOIN (SELECT ops,fgno,account FROM f_ordered WHERE fgono = #{fgono}) fo "
	 		+ "ON fg.fgno = fo.fgno")
	 public List<OrderVO> orderInfo(String fgono);
	 
	 @Select("SELECT fgono,payment,TO_CHAR(buydate,'YY/MM/DD') as dbday,num "
	 		+ "FROM (SELECT fgono,payment,buydate,rownum as num "
	 		+ "FROM (SELECT fgono,payment,buydate "
	 		+ "FROM f_goods_order WHERE id=#{id} ORDER BY buydate DESC)) "
	 		+ "WHERE num BETWEEN #{start} AND #{end}")
	 public List<OrderGVO> mypageStore(Map map);
	 
	 @Select("SELECT CEIL(COUNT(*)/6.0) FROM f_goods_order WHERE id=#{id}")
	 public int mypageStoreTotal(String id);
	 
	 @Select("SELECT * FROM f_goods_order WHERE fgono=#{fgono}")
	 public OrderGVO mypageOrder(String fgono);
}
