package com.sist.vo;

import lombok.Data;

/*
 * CREATE TABLE gitsta_comment(
    gno NUMBER,
    rno NUMBER,
    userId VARCHAR2(20),
    msg CLOB CONSTRAINT gc_msg_nn NOT NULL,
    regdate DATE DEFAULT SYSDATE,
    likecount NUMBER DEFAULT 0,
    group_id NUMBER,
    group_step NUMBER DEFAULT 0, --순서
    group_tab NUMBER DEFAULT 0, -- 댓글인지,대댓글인지
    depth NUMBER DEFAULT 0,
    root NUMBER DEFAULT 0,
    type NUMBER,
    modifyDate DATE DEFAULT SYSDATE,
    CONSTRAINT gc_cno_pk PRIMARY KEY(gno),
    CONSTRAINT gc_userId_fk FOREIGN KEY(userId)
    REFERENCES funding_member(userId),
    CONSTRAINT gc_rno_fk FOREIGN KEY(rno)
    REFERENCES gitsta_feed(no)
);
 */
import java.util.*;
@Data
public class GitstaReVO {
	private int gno,rno,likecount,group_id,group_step,group_tab,depth,root,type;
	private String userId,msg,dbday,mday;
	private Date regdate,modifydate;
	private String userName,nickname,profile;
}
