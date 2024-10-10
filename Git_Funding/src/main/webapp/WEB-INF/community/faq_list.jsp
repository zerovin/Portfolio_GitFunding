<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자주 묻는 질문</title>
<script src="https://cdn.jsdelivr.net/npm/vue@3.2.31/dist/vue.global.js"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<style type="text/css">
.commu_list {
	width: 960px;
    margin: 0 auto;
    padding: 20px;
    font-family: 'NexonLv2Gothic';
}
.commu_list>h1{
	text-align: center;
	font-weight: bold;
	font-size: 35px;
	font-family: 'NexonLv2Gothic';
}
.commu_tab {
	margin-top : 10px;
    text-align : center;
    margin-bottom: 20px;
}
.commu_tab button {
    margin: 5px;
    font-size: 20px;
}
.commu_tab button:hover{
	color : #f8c200;
}
.faq-tabs {
    display: flex;
    justify-content: center;
    flex-wrap: wrap;
    gap: 15px;
    margin-bottom: 30px;
}
.faq-tabs button {
    background-color: #f1f1f1;
    border: none;
    border-radius: 20px;
    padding: 10px 20px;
    font-size: 16px;
    cursor: pointer;
}
.faq-tabs button.active {
    background-color: #f8c200;
    color: white;
    font-weight: bold;
}
.faq-content {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 20px;
}
.faq-item {
    background-color: white;
    border-radius: 10px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    padding: 20px;
    margin-bottom: 20px;
}
.faq-item h3 {
    font-size: 18px;
    margin-bottom: 10px;
}
.faq-item p {
    font-size: 14px;
    color: #666;
    line-height: 1.6;
}
.view-all {
    display: block;
    text-align: center;
    margin-top: 20px;
    padding: 10px 20px;
    background-color: #f8c200;
    color: white;
    border-radius: 5px;
    text-decoration: none;
    font-weight: bold;
    width: 600px;
    height: 50px;
}
.view-all:hover {
    background-color: #FFA500;
}
</style>
</head>
<body>
<div class="commu_list" id="faqApp">
    <h1>자주 묻는 질문</h1>
	<div class="commu_tab">
	    <button onclick="location.href='../community/faq_list.do'" style="color:#f8c200">FAQ</button>
	    <button onclick="location.href='#'">NOTICE</button>
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