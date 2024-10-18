package com.sist.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.sist.vo.GitstaVO;
import com.sist.vo.MemberVO;

public interface GitstaService {
	public List<GitstaVO> gitstaMyTotalListData(String userId,int start,int end);
	public int gitstaMyTotalCount(String userId);
	public List<GitstaVO> gitstaTotalListData();
	public int gitstaTotalCount();
	public MemberVO gitstaInfoData(String userId);
	public void feedInsert(GitstaVO vo);
	public List<MemberVO> gitstaFollowingListData(String userId);
	public int getFollowingCount(String userId);
	public List<MemberVO> gitstaFollowerListData(@Param("userId") String userId);
	public int getFollowerCount(@Param("userId") String userId);
	public void insertFollow(String followerId,String followingId);
	public void deleteFollow(String followerId,String followingId);
	
	public void setFeedDisplayDate(List<GitstaVO> list);
	
}
