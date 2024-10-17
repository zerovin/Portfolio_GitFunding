package com.sist.service;

import java.util.List;


import com.sist.vo.GitstaVO;
import com.sist.vo.MemberVO;

public interface GitstaService {
	public List<GitstaVO> gitstaTotalListData(String userId,int start,int end);
	public int gitstaTotalCount(String userId);
	public MemberVO gitstaInfoData(String userId);
	public void feedInsert(GitstaVO vo);
}
