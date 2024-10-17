<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<script src="https://cdn.jsdelivr.net/npm/vue@3.2.31/dist/vue.global.js"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<link rel="stylesheet" href="../css/notice.css">
</head>
<body>
<div class="commu_list" id="noticeApp">
    <h1>공지사항</h1>
    <div class="commu_tab">
        <button onclick="location.href='../community/faq_list.do'">FAQ</button>
        <button onclick="location.href='../notice/list.do'" style="color:#f8c200">NOTICE</button>
        <button onclick="location.href='../community/qna_list.do'">Q&A</button>
    </div>
    <div class="faq-tabs">
        <button v-for="category in ['전체', '공지', '이벤트', '알려드립니다']" 
                :key="category"
                :class="{ active: cate === category }" 
                @click="changeCategory(category)">
            {{ category }}
        </button>
    </div>
    <div class="faq-item" v-for="item in notice_list" :key="item.no">
    	<h3>{{item.type}} {{item.subject}}</h3>
    	<p>{{item.content}}</p>
    </div>
    <div class="createNoticeBtn" @click="createNotice()">
	    <button class="view_admin">공지사항 작성하기</button>
    </div>
</div>
<script>
    let noticeApp = Vue.createApp({
        data() {
            return {
            	notice_list: [],
                cate: '전체',
                sessionId: '$(sessionId)'
            }
        },
        mounted() {
        	this.dataRecv()
        },
        methods: {
            changeCategory(category) {
                this.cate = category; // 선택된 카테고리 업데이트
                this.dataRecv()
            },
            createNotice() {
            	window.location.href='../notice/insert.do'
            }
        }
    }).mount('#noticeApp');
</script>
</body>
</html>
