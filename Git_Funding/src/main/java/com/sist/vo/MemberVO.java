package com.sist.vo;
import java.util.*;

import lombok.Data;
@Data
public class MemberVO {
	private String userId, userName, userPwd, gender, email, email_id, email_domain, post, addr1, addr2, phone, profile, admin, nickname;
	private int enabled;
	private Date regdate, modifydate, lastlogin;
	private String msg, authority;
}
