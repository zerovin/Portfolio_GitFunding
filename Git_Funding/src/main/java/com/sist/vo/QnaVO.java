package com.sist.vo;
import java.util.*;

import lombok.Data;
     
@Data
public class QnaVO {
	private int qno,type,hit,group_id,reok,admin,secret;
	private String subject,content,id,nickname,name,dbday,mday;
	private Date regdate,modifydate;
}
