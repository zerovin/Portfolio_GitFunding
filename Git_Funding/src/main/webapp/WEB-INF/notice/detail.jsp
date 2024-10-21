<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A 상세보기</title>
<style type="text/css">
.notice_detail {
    width: 960px;
    margin: 0 auto;
    padding: 20px;
    font-family: 'NexonLv2Gothic';
    background-color: #F9F9F9;
    border-radius: 10px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
}
.notice_detail > h1 {
    text-align: center;
    font-weight: bold;
    font-size: 35px;
    color: #2C3E50;
    margin-bottom: 20px;
}
.notice_content {
    background: #FFFFFF;
    padding: 30px;
    border-radius: 8px;
    margin-top: 20px;
    box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.05);
}
.notice_title {
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
/* .answer { */
/*     white-space: pre-wrap; */
/*     background-color: #fff; */
/*     padding: 20px; */
/*     border: 1px solid #ddd; */
/*     border-radius: 5px; */
/*     overflow: auto; */
/*     min-height: 100px; */
/*     margin-top: 20px; */
/* } */
/* .answer_item { */
/*     border-bottom: 1px solid #ddd; */
/*     padding-bottom: 10px; */
/*     margin-bottom: 10px; */
/* } */
/* .answer_item:last-child { */
/*     border-bottom: none; */
/* } */
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
    margin-left:5px;
}
.button:hover {
    background-color: #FFA500;
}

</style>
</head>
<body>
<div id="detailApp" class="notice_detail">
    <div class="notice_content">
            <div class="notice_title">{{ vo.subject }}</div>
            <table class="info_table">
                <tr>
                    <th width="20%">작성자</th>
                    <td width="30%">{{ vo.nickname }}</td>
                    <th width="20%">작성일</th>
                    <td width="30%">{{ vo.dbday }}</td>
                </tr>
                <tr>
                    <th width="20%">카테고리</th>
                    <td width="30%">
                        <span v-if="vo.type === 1">공지</span>
                        <span v-else="vo.type === 2">이벤트</span>
                    </td>
                    <th width="20%">조회수</th>
                    <td width="30%">{{ vo.hit }}</td>
                </tr>
            </table>
            <div class="content">
                {{ vo.content }}
            </div>
            <div class="button-container">
                <button class="button" @click="NoticeUpdate()" v-if="vo.userId === sessionId">수정</button>
                <button class="button" @click="NoticeDelete()" v-if="vo.userId === sessionId">삭제</button>
                <button class="button" @click="goToList()">목록</button>
            </div>
    </div>
</div>

<script>
let detailApp = Vue.createApp({
    data() {
        return {
            vo: {},
            no: ${no},
            sessionId: '${sessionId}',
            isAdmin: false
        }
    },
    mounted() {
        this.getNoticeDetail()
    },
    methods: {
    	goToList() {
    		location.href = '../notice/list.do'
    	},
    	NoticeUpdate(){
    		location.href = '../notice/update.do?no=' + this.no
    	},
    	NoticeDelete(){
    		axios.get('../notice/delete_vue.do', {
    			params: {
    				no : this.no
    			}
    		}).then(res => {
    			if(res.data === 'yes') {
    				alert("공지가 삭제됐습니다")
    				location.href = "../notice/list.do"
    			} else {
    				alert("삭제 실패!!")
    				console.log(res.data)
    			}
    		}).catch(error => {
    			console.log(error.response)
    		})
    	},
    	getNoticeDetail() {
    	    axios.get('../notice/detail_vue.do', {
    	        params: {
    	            no: this.no
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
    	}
    }
}).mount('#detailApp')
</script>
</body>
</html>