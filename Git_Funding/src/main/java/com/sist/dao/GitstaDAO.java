package com.sist.dao;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
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
	//팔로잉
	public List<MemberVO> gitstaFollowingListData(String userId){
		return mapper.gitstaFollowingListData(userId);
	}
	public int getFollowingCount(String userId) {
		return mapper.getFollowingCount(userId);
	}
	//팔로워
	public List<MemberVO> gitstaFollowerListData(@Param("userId") String userId){
		return mapper.gitstaFollowerListData(userId);
	}
	
	public int getFollowerCount(@Param("userId") String userId) {
		return mapper.getFollowerCount(userId);
	}
	
	public void insertFollow(String followerId,String followingId) {
		mapper.insertFollow(followerId, followingId);
	}
	
	public void deleteFollow(String followerId,String followingId) {
		mapper.deleteFollow(followerId, followingId);
	}
	
	// 상세보기
	public GitstaVO gitstaDetailData(int no) {
		return mapper.gitstaDetailData(no);
	}
}
