<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Funding Detail Page</title>
<link rel="stylesheet" type="text/css" href="../css/gitsta_post.css">
<script src="https://unpkg.com/vue@3"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
</head>
<body>
<div id="postDetailApp" class="detail-page">
    <div class="header">
        <img src="../images/back.png" alt="뒤로가기" @click="historyBack">
        <div class="post-info" v-if="vo.nickname"><span style="font-weight: bold">{{vo.nickname}}</span>님의 포스팅&nbsp;</div>
        <div class="post-info" v-else><span style="font-weight: bold">{{vo.userName}}</span>님의 포스팅&nbsp;</div>
        <span class="tag" v-if="vo.dbday === vo.mday">{{ vo.dbday }}</span>
        <span class="tag" v-else>[수정됨]{{ vo.mday }}</span>
    </div>

    <div class="project-info" v-if="vo.type === 1">
        <img :src="'../profile/' + vo.filename" alt="펀딩 이미지">
        <p>{{ vo.content }}</p>
    </div>
    <div class="project-info" v-else>
        <img :src="vo.filename" alt="펀딩 이미지">
        <p>{{ vo.content }}</p>
        <a :href="'../funding/funding_detail.do?fno=' + vo.fno"><span class="tag" style="margin-top: 20px;">{{ vo.projectname }}</span></a>
    </div>

    <div class="comment-section">
	   	<h3>댓글</h3>
	
	       <!-- 댓글 리스트 -->
		<div v-for="comment in comments" :class="{'comment': comment.group_tab === 0, 'reply-comment': comment.group_tab === 1}">
		    <img :src="'../profile/' + comment.profile" alt="사용자 프로필">
		    <div class="comment-content">
		        <p v-if="comment.nickname"><strong>{{ comment.nickname }}</strong>: {{ comment.msg }}</p>
		        <p v-else><strong>{{ comment.userName }}</strong>: {{ comment.msg }}</p>
		        
		        <!-- 날짜 표시 -->
		        <span class="comment-date" v-if="comment.dbday === comment.mday">{{ comment.dbday }}</span>
		        <span class="comment-date" v-else>[수정됨] {{ comment.mday }}</span>
		
		        <!-- 수정 및 삭제 버튼 (sessionId와 userId가 같을 때) -->
		        <div class="comment-actions" v-if="sessionId === comment.userId">
		            <button @click="editComment(comment)">수정</button>
		            <button @click="deleteComment(comment.gno)">삭제</button>
		        </div>
		
		        <!-- 대댓글 작성 버튼 -->
		        <div v-if="comment.group_tab === 0">
		            <button class="reply-button" @click="showReplyForm(comment.gno)">답글</button>
		        </div>
		
		        <!-- 대댓글 작성 폼 -->
		        <div class="reply-form" v-if="replyFormVisible && parentCommentId === comment.gno">
		            <input type="text" v-model="replyMessage" placeholder="답글을 입력하세요">
		            <button @click="submitReply(comment.gno)">답글 작성</button>
		        </div>
		
		        <!-- 댓글 수정 폼 -->
		        <div v-if="editingComment && editingComment.gno === comment.gno" class="edit-comment-form">
		            <input type="text" v-model="editingComment.msg" placeholder="댓글을 수정하세요">
		            <button @click="submitEditComment">수정 완료</button>
		            <button @click="cancelEdit">취소</button>
		        </div>
		    </div>
		</div>
		
		<!-- 페이징 -->
		<div class="pagination">
		    <button @click="prevPage" :disabled="curpage === 1">이전</button>
		    <span>{{ curpage }} / {{ totalpage }}</span>
		    <button @click="nextPage" :disabled="curpage === totalpage">다음</button>
		</div>
		
		<!-- 댓글 작성 폼 -->
		<div class="comment-form">
		    <input type="text" v-model="newComment" placeholder="댓글을 입력하세요" class="comment-input">
		    <button @click="submitComment" class="comment-submit-btn">댓글 작성</button>
		</div>
	</div>
</div>


<script>
 let postDetailApp = Vue.createApp({
     data() {
         return {
             vo: {},
             no: ${no}, // 서버로부터 받은 게시글 번호
             sessionId: '', // 현재 로그인한 사용자 ID
             comments: [], // 댓글 리스트
             curpage: 1,
             totalpage: 0,
             replyFormVisible: false, // 대댓글 작성 폼 표시 여부
             parentCommentId: null, // 현재 대댓글을 작성할 댓글의 ID
             replyMessage: '', // 대댓글 입력 메시지
             newComment: '', // 새로운 댓글 입력 메시지
             editingComment: null // 현재 수정 중인 댓글
         }
     },
     mounted(){
         this.getSessionId();
         this.fetchPostDetail();
         this.fetchComments();
     },
     methods: {
         getSessionId() {
             axios.get('../gitsta/getSessionId.do')
                 .then(response => {
                     this.sessionId = response.data; // 세션 ID 저장
                 })
                 .catch(error => {
                     console.error('세션 ID 가져오기 오류:', error.response);
                 });
         },
         fetchPostDetail() {
             axios.get('../gitsta/post_detail_vue.do', {
                 params: {
                     no: this.no
                 }
             }).then(res => {
                 console.log(res.data);
                 this.vo = res.data;
             }).catch(error => {
                 console.log(error.response);
             });
         },
         fetchComments() {
             axios.get('../gitsta/comment_list_vue.do', {
                 params: {
                     page: this.curpage,
                     no: this.no
                 }
             }).then(res => {
                 console.log(res.data);
                 this.comments = res.data.list;
                 this.curpage = res.data.curpage;
                 this.totalpage = res.data.totalpage;
             }).catch(error => {
                 console.log(error.response);
             });
         },
         prevPage() {
             if (this.curpage > 1) {
                 this.curpage--;
                 this.fetchComments();
             }
         },
         nextPage() {
             if (this.curpage < this.totalpage) {
                 this.curpage++;
                 this.fetchComments();
             }
         },
         showReplyForm(gno) {
             this.replyFormVisible = true;
             this.parentCommentId = gno;
         },
         submitReply(parentGno) {
             axios.post('../gitsta/comment_reply_insert_vue.do', null, {
                 params: {
                     gno: parentGno,  // 부모 댓글 번호
                     rno: this.no,  // 게시글 번호
                     msg: this.replyMessage  // 대댓글 내용
                 }
             }).then(() => {
                 this.replyFormVisible = false;
                 this.replyMessage = '';  // 입력 필드 초기화
                 this.fetchComments();  // 댓글 목록 새로고침
             }).catch(error => {
                 console.log(error.response);
             });
         },
         deleteComment(gno) {
             axios.get('../gitsta/comment_delete_vue.do', {
                 params: {
                     gno: gno,
                     rno: this.no // 게시글 번호를 rno로 전달
                 }
             }).then(() => {
                 this.fetchComments(); // 삭제 후 댓글 목록 새로고침
             }).catch(error => {
                 console.log(error.response);
             });
         },
         submitComment() {
             axios.post('../gitsta/comment_insert_vue.do', null, {
                 params: {
                     rno: this.no,  // 게시글 번호
                     msg: this.newComment  // 댓글 내용
                 }
             }).then(() => {
                 this.newComment = ''; // 댓글 작성 후 입력 필드 초기화
                 this.fetchComments(); // 새로고침
             }).catch(error => {
                 console.log(error.response);
             });
         },
         editComment(comment) {
             this.editingComment = { ...comment }; // 수정하려는 댓글을 복사해서 editingComment로 설정
         },
         submitEditComment() {
             axios.post('../gitsta/comment_update_vue.do', null, {
                 params: {
                     gno: this.editingComment.gno,  // 댓글 번호
                     msg: this.editingComment.msg  // 수정된 댓글 내용
                 }
             }).then(() => {
                 this.editingComment = null; // 수정 완료 후 초기화
                 this.fetchComments(); // 새로고침
             }).catch(error => {
                 console.log(error.response);
             });
         },
         cancelEdit() {
             this.editingComment = null; // 수정 취소
         },
         historyBack() {
             window.history.back();
         }
     }
 }).mount('#postDetailApp');
</script>
</body>
</html>
