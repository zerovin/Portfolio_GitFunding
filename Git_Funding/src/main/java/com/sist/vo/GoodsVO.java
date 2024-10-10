package com.sist.vo;
import java.util.*;

import lombok.Data;

@Data
public class GoodsVO {
	private int fgno,hit;
	private String title,brand,price,discount,delivery,cate1,cate2,cate3,cate4,img,realprice;
	private List<String> imgs;
	private List<String> detail;
	private List<String> ops;
	private List<Integer> EA;
}
