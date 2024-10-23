package com.sist.vo;
import java.util.*;

import lombok.Data;

@Data
public class OrderGVO {
	private int recall;
	private String fgono,id,payment,recvAddress,msg,send,recv,sendPhone,recvPhone,email,dbday;
	private Date buydate;
}
