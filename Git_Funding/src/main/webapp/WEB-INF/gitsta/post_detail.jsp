<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Funding Detail Page</title>
<style type="text/css">
/* ----------------- 인스타그램 스타일 펀딩 상세 페이지 ------------------- */

.detail-page {
    max-width: 800px;
    margin: 0 auto;
    padding: 20px;
    background-color: #ffffff;
    border-radius: 10px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    font-family: 'NEXON Lv2 Gothic';
}

.header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 10px 20px;
    background-color: #ffffff;
    border-bottom: 1px solid #e0e0e0;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.header img {
    width: 30px;
    height: 30px;
    border-radius: 50%;
    object-fit: cover;
    cursor: pointer;
}

.header .post-info {
    font-size: 16px;
    color: #666;
    margin-left: 10px;
}

.header .post-actions {
    margin-left: auto;
    display: flex;
    gap: 10px;
}

.post-actions button {
    background-color: #ffa500;
    border: none;
    padding: 5px 10px;
    border-radius: 5px;
    cursor: pointer;
    color: #ffffff;
    font-weight: bold;
    transition: background-color 0.3s;
    font-size: 14px;
}

.post-actions button:hover {
    background-color: #cc8400;
}

.project-info {
    text-align: center;
    margin-top: 20px;
}

.project-info img {
    width: auto;
    max-width: 100%;
    height: auto;
    max-height: 400px;
    object-fit: cover;
    border-radius: 10px;
}

.project-info p {
    font-size: 16px;
    color: #666;
    margin-top: 20px;
}

.comment-section {
    margin-top: 30px;
    border-top: 2px solid #e0e0e0;
    padding-top: 20px;
}

.comment {
    display: flex;
    align-items: flex-start;
    margin-bottom: 15px;
}

.comment img {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    margin-right: 10px;
    object-fit: cover;
}

.comment-content {
    background-color: #f0f0f0;
    padding: 15px;
    border-radius: 10px;
    max-width: 600px;
    width: 100%;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
    position: relative;
}

.comment-content p {
    margin: 0;
    font-size: 15px;
    color: #333;
}

.comment-actions {
    display: flex;
    gap: 10px;
    margin-top: 5px;
}

.comment-actions button {
    background: none;
    border: none;
    color: #ffa500;
    cursor: pointer;
    font-size: 13px;
    font-weight: bold;
}

.comment-actions button:hover {
    text-decoration: underline;
}

.reply-button {
    background: none;
    border: none;
    color: #ffa500;
    cursor: pointer;
    margin-top: 5px;
    font-size: 13px;
}

.reply-button:hover {
    text-decoration: underline;
}

.reply-form {
    display: flex;
    align-items: center;
    margin-top: 10px;
    background-color: #f9f9f9;
    padding: 10px;
    border-radius: 10px;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

.reply-form input[type="text"] {
    flex-grow: 1;
    padding: 10px;
    border: 1px solid #e0e0e0;
    border-radius: 5px;
    margin-right: 10px;
    font-size: 14px;
}

.reply-form button {
    background-color: #ffa500;
    border: none;
    padding: 10px 15px;
    border-radius: 5px;
    cursor: pointer;
    color: #ffffff;
    font-weight: bold;
    transition: background-color 0.3s;
    font-size: 14px;
}

.reply-form button:hover {
    background-color: #cc8400;
}

.reply-comment {
    margin-left: 50px;
    margin-top: 10px;
    padding: 10px;
    border-left: 3px solid #ffa500;
}

.reply-comment img {
    width: 35px;
    height: 35px;
    border-radius: 50%;
    margin-right: 10px;
    object-fit: cover;
}

.reply-comment .comment-content {
    background-color: #e9e9e9;
    padding: 10px;
    border-radius: 10px;
    max-width: 550px;
    width: 100%;
    box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
    position: relative;
}

.reply-comment .comment-actions {
    display: flex;
    gap: 10px;
    margin-top: 5px;
}

.reply-comment .comment-actions button {
    background: none;
    border: none;
    color: #ffa500;
    cursor: pointer;
    font-size: 13px;
    font-weight: bold;
}

.reply-comment .comment-actions button:hover {
    text-decoration: underline;
}
.tag {
    display: inline-block;
    background-color: #f0f0f0;
    padding: 5px 10px;
    border-radius: 15px;
    font-size: 14px;
    color: #666;
}

</style>
<script src="https://unpkg.com/vue@3"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script> 
</head>
<body>
<div id="postDetailApp" class="detail-page">
    <div class="header">
        <img src="../images/back.png" alt="뒤로가기" @click="historyBack">
        <div class="post-info" v-if="vo.nickname"><span style="font-weight: bold">{{vo.nickname}}</span>님의 포스팅&nbsp;</div>
        <div class="post-info" v-else><span style="font-weight: bold">{{vo.userName}}</span>님의 포스팅&nbsp;</div>
        <span class="tag" v-if="vo.dbday===vo.mday">{{ vo.dbday }}</span>
        <span class="tag" v-else>[수정됨]{{ vo.mday }}</span>
        <div class="post-actions" v-if="sessionId===vo.userId">
            <button @click="postUpdate()">수정</button>
            <button @click="postDelete()">삭제</button>
        </div>
    </div>

    <div class="project-info" v-if="vo.type===1">
        <img :src="'../profile/'+vo.filename" alt="펀딩 이미지">
        <p>{{vo.content}}</p>
    </div>
    <div class="project-info" v-else>
        <img :src="vo.filename" alt="펀딩 이미지">
        <p>{{vo.content}}</p>
        <a :href="'../funding/funding_detail.do?fno='+vo.fno"><span class="tag" style="margin-top: 20px;">{{vo.projectname}}</span></a>
    </div>

    <div class="comment-section">
        <h3>댓글</h3>
        <div class="comment">
            <img src="../images/profile.png" alt="사용자 프로필">
            <div class="comment-content">
                <p><strong>사용자1</strong>: 정말 멋진 프로젝트네요! 응원합니다!</p>
                <div class="comment-actions">
                    <button>수정</button>
                    <button>삭제</button>
                </div>
                <div class="reply-form">
                    <input type="text" placeholder="답글을 입력하세요">
                    <button>답글 작성</button>
                </div>
                <div class="reply-comment">
                    <img src="../images/profile.png" alt="사용자 프로필">
                    <div class="comment-content">
                        <p><strong>사용자2</strong>: 감사합니다! 저도 함께 하고 싶어요!</p>
                        <div class="comment-actions">
                            <button>수정</button>
                            <button>삭제</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="reply-form" style="margin-top: 20px;">
            <input type="text" placeholder="댓글을 입력하세요">
            <button>댓글 작성</button>
        </div>
    </div>
</div>
<script>
 let postDetailApp=Vue.createApp({
	 data() {
		 return {
			 vo:{},
			 no:${no},
			 isShow:false,
			 sessionId: ''
		 }
	 },
	 mounted(){
		 this.getSessionId()
		 axios.get('../gitsta/post_detail_vue.do',{
			 params:{
				 no:this.no
			 }
		 }).then(res=>{
			 console.log(res.data)
			 this.vo=res.data
		 }).catch(error=>{
			 console.log(error.response)
		 })
	 },
	 methods:{
		 getSessionId() {
	            axios.get('../gitsta/getSessionId.do')
	                .then(response => {
	                    this.sessionId = response.data; // 가져온 sessionId 저장
	                })
	                .catch(error => {
	                    console.error('세션 ID 가져오기 오류:', error.response);
	                })
	        },
	        postDelete(){
	        	axios.get('../gitsta/post_delete_vue.do',{
	        		params:{
	   				 no:this.no
	   			 }
	        	}).then(res=>{
	        		if(res.data==='yes'){
						alert("게시글이 삭제되었습니다")
						location.href="../gitsta/main.do"
					}else{
						alert("삭제에 실패했어요 ㅠ.ㅠ")
					}
				}).catch(error=>{
					console.log(error.response)
				})
	        },
	        postUpdate(){
	            window.location.href = "../gitsta/update_post.do?no=" + this.no;
	        },
	        historyBack(){
	        	 window.history.back();
	        }
	 }
 }).mount('#postDetailApp')
</script>
</body>
</html>
