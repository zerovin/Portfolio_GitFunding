<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A 상세보기</title>
<script src="https://cdn.jsdelivr.net/npm/vue@3.2.31/dist/vue.global.js"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<style type="text/css">
.qna_detail {
    width: 960px;
    margin: 0 auto;
    padding: 20px;
    font-family: 'NexonLv2Gothic';
    background-color: #F9F9F9;
    border-radius: 10px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
}
.qna_detail > h1 {
    text-align: center;
    font-weight: bold;
    font-size: 35px;
    color: #2C3E50;
    margin-bottom: 20px;
}
.qna_content {
    background: #FFFFFF;
    padding: 30px;
    border-radius: 8px;
    margin-top: 20px;
    box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.05);
}
.qna_title {
    font-size: 26px;
    margin-bottom: 20px;
    color: #34495E;
    border-bottom: 2px solid #f8c200;
    padding-bottom: 10px;
    text-align: center;
}
.info_table {
    width: 100%;
    border-collapse: collapse;
    background: white;
    border-radius: 8px;
    overflow: hidden;
    margin-bottom: 20px;
    box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.05);
}
.info_table th, .info_table td {
    padding: 15px;
    text-align: left;
    border-bottom: 1px solid #ddd;
}
.info_table th {
    background-color: #f8c200;
    color: white;
    font-weight: bold;
    text-align: center;
}
.info_table td {
    color: #333;
}
.content {
    white-space: pre-wrap;
    background-color: #fff;
    padding: 20px;
    border: 1px solid #ddd;
    border-radius: 5px;
    overflow: auto;
    min-height: 300px;
    margin-bottom: 20px;
}
.answer {
    white-space: pre-wrap;
    background-color: #fff;
    padding: 20px;
    border: 1px solid #ddd;
    border-radius: 5px;
    overflow: auto;
    min-height: 100px;
    margin-top: 20px;
}
.answer_item {
    border-bottom: 1px solid #ddd;
    padding-bottom: 10px;
    margin-bottom: 10px;
}
.answer_item:last-child {
    border-bottom: none;
}
.button-container {
    margin-top: 30px;
    text-align: right;
}
.button {
    padding: 10px 20px;
    text-decoration: none;
    color: white;
    background-color: #f8c200;
    border-radius: 5px;
    font-size: 14px;
    border: none;
    cursor: pointer;
}
.button:hover {
    background-color: #FFA500;
}
.AnswerToQnABtn{
	padding: 10px 20px;
    text-decoration: none;
    color: white;
    background-color: #f8c200;
    border-radius: 5px;
    font-size: 14px;
    border: none;
    cursor: pointer;
    margin-right:212.085px;
}
.AnswerToQnABtn:hover {
    background-color: #FFA500;
}
</style>
</head>
<body>
<div id="detailApp" class="qna_detail">
    <div class="qna_content">
        <div v-if="vo.secret == 1 && vo.id !== sessionId" class="content" style="text-align: center;">
            <p style="margin-bottom: 10px">비밀글입니다. 작성자만 볼 수 있습니다.<p>
            <button class="button" @click="goToList">돌아가기</button>
        </div>
        <div v-else>
            <div class="qna_title">{{ vo.subject }}</div>
            <table class="info_table">
                <tr>
                    <th width="20%">작성자</th>
                    <td width="30%" v-if="vo.nickname===null">{{ vo.name }}</td>
                    <td width="30%" v-else>{{ vo.nickname }}</td>
                    <th width="20%">작성일</th>
                    <td width="30%" v-if="vo.dbday===vo.mday">{{ vo.dbday }}</td>
                    <td width="30%" v-if="vo.dbday!==vo.mday"><span style="color: gray">[수정됨]</span>{{ vo.mday }}</td>
                </tr>
                <tr>
                    <th width="20%">문의 종류</th>
                    <td width="30%">
                        <span v-if="vo.type === 1">사이트</span>
                        <span v-else-if="vo.type === 2">펀딩</span>
                        <span v-else-if="vo.type === 3">상품</span>
                        <span v-else>기타</span>
                    </td>
                    <th width="20%">조회수</th>
                    <td width="30%">{{ vo.hit }}</td>
                </tr>
            </table>
            <div class="content">
                {{ vo.content }}
            </div>
            <div v-if="answerList && answerList.length > 0" class="answer">
                <h3 style="color: orange; font-weight: bold;margin-bottom: 10px;">관리자 답변입니다</h3>
                <div v-for="answer in answerList" :key="answer.qno" class="answer_item">
                    <p style="color: gray" v-if="answer.dbday === answer.mday">{{ answer.dbday }}</p>
                    <p style="color: gray" v-if="answer.dbday !== answer.mday">[수정됨]{{ answer.mday }}</p>
                    <p style="margin: 10px">{{ answer.content }}</p>
                </div>
            </div>
            <div class="button-container">
            	<sec:authorize access="hasRole('ROLE_ADMIN')">
		        	<button class="AnswerToQnABtn" @click="AnswerToQnA">답변하기</a></li>
		        </sec:authorize>
		            
                <button class="button" @click="boardUpdate()" v-if="vo.id === sessionId">수정</button>
                <button class="button" @click="boardDelete()" v-if="vo.id === sessionId">삭제</button>
                <button class="button" @click="goToList">목록</button>
            </div>
        </div>
    </div>
</div>

<script>
let detailApp = Vue.createApp({
    data() {
        return {
            vo: {},
            qno: ${qno},
            sessionId: '${sessionId}',
            answerList: [],
            isAdmin: false,
            groupId: 0
        }
    },
    mounted() {
        this.getQnaDetail()
        this.getQnaAnswers()
    },
    methods: {
    	boardUpdate(){
    		window.location.href = '../community/qna_update.do?qno='+this.qno
    	},
    	boardDelete(){
    		axios.get('../community/qna_delete_vue.do',{
    			params:{
    				groupId:this.groupId
    			}
    		}).then(res=>{
    			if(res.data==='yes'){
    				alert("문의가 삭제됐습니다")
    				location.href="../community/qna_list.do"
    			}else{
    				alert("삭제 실패!!")
    				console.log(res.data)
    			}
    		}).catch(error=>{
    			console.log(error.response)
    		})
    	},
    	getQnaDetail() {
    	    axios.get('../community/qna_detail_vue.do', {
    	        params: {
    	            qno: this.qno
    	        }
    	    }).then(res => {
    	        console.log("QnA Detail Response:", res.data)
    	        if (res.data) {
    	            this.vo = res.data
    	            this.groupId = res.data.group_id
    	            if (this.groupId) {
    	                this.getQnaAnswers()
    	            }
    	        }
    	    }).catch(error => {
    	        console.log("QnA Detail Error:", error.response)
    	    })
    	},
    	getQnaAnswers() {
    	    axios.get('../community/qna_answers_vue.do', {   
    	        params: {
    	            groupId: this.groupId
    	        }
    	    }).then(res => {
    	        console.log("Answers Response:", res.data)
    	        if (res.data.answerList) {
    	            this.answerList = res.data.answerList
    	        } else {
    	            this.answerList = []
    	        }
    	    }).catch(error => {
    	        console.log("QnA Answer Error:",error.response)
    	        this.answerList = []
    	    })
    	},
        goToList() {
            window.location.href = '../community/qna_list.do'
        },
        AnswerToQnA() {
	
		}
    }
}).mount('#detailApp')
</script>
</body>
</html>