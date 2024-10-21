package com.sist.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.sist.vo.GitstaReVO;
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
	public GitstaVO gitstaDetailData(int no);
	public String deletePost(int no);
	public GitstaVO deleteInfoData(int no);
	public String updatePost(GitstaVO vo);
	public GitstaVO postUpdateData(int no);   
	
	
	public List<GitstaReVO> commentListData(Map<String, Object> map);  // 댓글 목록 가져오기
    public int commentTotalPage(int rno);   
    public void commentInsert(GitstaReVO vo);                       
    public void commentReplyReplyInsert(int gno, GitstaReVO vo);                    
    public void commentDelete(Map<String, Object> map);
    public void commentReplyDecrement(int gno);               
    public void commentUpdate(GitstaReVO vo);
    public GitstaReVO commentDeleteInfoData(int gno);
	
}
