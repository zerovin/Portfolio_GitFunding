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
<div class="commu_list" id="faqApp">
    <h1>공지사항</h1>
	<div class="commu_tab">
	    <button onclick="location.href='../community/faq_list.do'" style="color:#f8c200">FAQ</button>
	    <button onclick="location.href='../notice/list.do'">NOTICE</button>
	    <button onclick="location.href='../community/qna_list.do'">Q&A</button>
	</div>
    <div class="faq-tabs">
	    <button v-for="category in ['회원정보', '결제', '상품/배송', '교환/AS', '프로젝트', '서비스 이용 문의']" 
	            :key="category"
	            :class="{ active: cate === category }"
	            @click="changeCategory(category)">
	        {{ category }}
	    </button>
    </div>
    
   	<div class="faq-item" v-for="item in faq_list" :key="item.no">
        <h3>Q. {{ item.question }}</h3>
        <p>A. {{ item.answer }}</p>
    </div>
 
    <button @click="checkLogin()" class="view-all" style="margin: 0px auto;">다른 문의하기 &gt;</button>
</div>
<script>
let faqApp = Vue.createApp({
    data() {
        return {
            faq_list: [],
            cate: '회원정보',
            sessionId:'${sessionId}'
        }
    },
    mounted() {
        this.dataRecv();
    },
    methods: {
		checkLogin() {
			if (this.sessionId === 'null' || !this.sessionId) {
				alert("로그인이 필요합니다.");
				window.location.href = '../member/login.do'; // 로그인 페이지로 이동
			} else {
				// sessionId가 null이 아닐 경우 insert로 이동
				window.location.href = '../community/qna_insert.do'; // insert 페이지로 이동
			}
		},
        changeCategory(category) {
            this.cate = category
            this.dataRecv()
        },
        dataRecv() {
            axios.get('../community/faq_list_vue.do', {
                params: {
                    cate: this.cate
                }
            }).then(res => {
                console.log(res.data)
                this.faq_list = res.data  
            }).catch(error => {
                console.log(error.response)
            });
        }
    }
}).mount('#faqApp');
</script>
</body>
</html>