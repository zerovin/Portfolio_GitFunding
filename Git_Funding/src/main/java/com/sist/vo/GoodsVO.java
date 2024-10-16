package com.sist.vo;
import java.util.*;

import lombok.Data;

@Data
public class GoodsVO {
	private int fg_no,hit;
	private String title,brand,price,discount,delivery,cate1,cate2,cate3,cate4,img,realprice;
	private List<Goods2VO> gvo;
}
