package com.sist.dao;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

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
	// 수정하기
	public GitstaVO postUpdateData(int no) {
		return mapper.gitstaDetailData(no);
	}
	public String updatePost(GitstaVO vo) {
		String result="yes";
		mapper.updatePost(vo);
		return result;
	}
	
	// 삭제하기
	public GitstaVO deleteInfoData(int no) {
		return mapper.deleteInfoData(no);
	}
	public String deletePost(int no) {
		String result="yes";
		mapper.deletePost(no);
		return result;
	}
	
	// 댓글
	// 댓글 목록 가져오기
    public List<GitstaReVO> commentListData(Map map) {
        return mapper.commentListData(map);
    }

    // 총 페이지 수 가져오기
    public int commentTotalPage(int rno) {
        return mapper.commentTotalPage(rno);
    }

    // 댓글 추가
    public void commentInsert(GitstaReVO vo) {
        // 댓글 추가 후 해당 게시글의 댓글 수 증가
        mapper.commentReplyIncrement(vo.getRno());
        mapper.commentInsert(vo);
    }

    // 대댓글 추가 (트랜잭션 처리)
    @Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
    public void commentReplyReplyInsert(int gno, GitstaReVO vo) {
        // 부모 댓글 정보 가져오기
        GitstaReVO pvo = mapper.commentParentInfoData(gno);
        vo.setGroup_id(pvo.getGroup_id());
        vo.setGroup_step(pvo.getGroup_step() + 1);
        vo.setGroup_tab(pvo.getGroup_tab() + 1);

        // 대댓글 삽입 처리
        mapper.commentGroupStepIncrement(pvo); // 같은 그룹 내에서 group_step 증가
        mapper.commentReplyReplyInsert(vo);    // 대댓글 삽입
        mapper.commentDepthIncrement(gno);     // 부모 댓글의 depth 증가

        // 게시글의 댓글 수 증가
        mapper.commentReplyIncrement(vo.getRno()); // rno를 사용하여 게시글 번호로 댓글 수 증가
    }

    // 삭제 관련 정보 가져오기
    public GitstaReVO commentDeleteInfoData(int gno) {
        return mapper.commentDeleteInfoData(gno);
    }

    // 댓글 삭제
    public void commentDelete(Map<String, Object> map) {
        mapper.commentDelete(map);
    }

    // 댓글 삭제 시 댓글 수 감소
    public void commentReplyDecrement(int gno) {
        mapper.commentReplyDecrement(gno);
    }

    // 댓글 수정
    public void commentUpdate(GitstaReVO vo) {
        mapper.commentUpdate(vo);
    }
	
}
