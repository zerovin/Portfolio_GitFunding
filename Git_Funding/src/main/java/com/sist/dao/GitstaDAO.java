package com.sist.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.util.*;
import com.sist.vo.*;
import com.sist.mapper.*;
@Repository
public class GitstaDAO {
	@Autowired
	private GitstaMapper mapper;
	
	public List<GitstaVO> gitstaMyTotalListData(String userId,int start,int end){
		return mapper.gitstaMyTotalListData(userId,start, end);
	}
	public int gitstaMyTotalCount(String userId) {
		return mapper.gitstaMyTotalCount(userId);
	}
	public MemberVO gitstaInfoData(String userId) {
		return mapper.gitstaInfoData(userId);
	}
	public List<GitstaVO> gitstaTotalListData(){
		return mapper.gitstaTotalListData();
	}
	public int gitstaTotalCount() {
		return mapper.gitstaTotalCount();
	}
	public void feedInsert(GitstaVO vo) {
		mapper.feedInsert(vo);
	}
}
