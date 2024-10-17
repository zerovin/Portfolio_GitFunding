package com.sist.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.util.*;
import com.sist.vo.*;
import com.sist.mapper.*;
@Repository
public class GitstaDAO {
	@Autowired
	private GitstaMapper mapper;
	
	public List<GitstaVO> gitstaTotalListData(String userId,int start,int end){
		return mapper.gitstaTotalListData(userId,start, end);
	}
	public int gitstaTotalCount(String userId) {
		return mapper.gitstaTotalCount(userId);
	}
	public MemberVO gitstaInfoData(String userId) {
		return mapper.gitstaInfoData(userId);
	}
	public void feedInsert(GitstaVO vo) {
		mapper.feedInsert(vo);
	}
}
