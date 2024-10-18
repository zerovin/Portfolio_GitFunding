package com.sist.service;

import java.util.List;


import com.sist.vo.GitstaVO;
import com.sist.vo.MemberVO;

public interface GitstaService {
	public List<GitstaVO> gitstaMyTotalListData(String userId,int start,int end);
	public int gitstaMyTotalCount(String userId);
	public List<GitstaVO> gitstaTotalListData();
	public int gitstaTotalCount();
	public MemberVO gitstaInfoData(String userId);
	public void feedInsert(GitstaVO vo);
}
