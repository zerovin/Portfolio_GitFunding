<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A List</title>
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
	margin-top: 10px;
    text-align: center;
    margin-bottom: 20px;
}
.commu_tab button {
    margin: 5px;
    font-size: 20px;
}
.commu_tab button:hover{
	color: #f8c200;
}
.qna_list {
    border-radius: 10px;
    width: 960px;
    height: 700px;
}
.qnaTable {
	width: 950px;
	margin-bottom: 15px;
}
.qnaTh {
	background-color: #f8c200;
	border-bottom: 3px solid;
    height: 40px;
    vertical-align: middle; 
}
.qnaTh>th{
    display: table-cell;
    vertical-align: middle; 
    text-align: center; 
}
.qnaTd {
	border: 1px solid gray;
}
.qnaTd>tr{
	border: 1px solid gray;
	height: 40px;
	line-height: 40px;
	text-align: center;
}
.search{
    display:flex;
    justify-content:center;
    align-items:center;
    gap:40px;
    margin-bottom:30px;
}
.search form{
    display:flex;
    align-items:center;
    gap:20px;
    position:relative;
}
.search form label{
    display:none;
}
.search form input{
    width:550px;
    height:50px;
    border:2px solid #F8C200;
    border-radius:27px;
    padding:25px;
    padding-right:40px;
}
.search form button{
    width:24px;
    height:23px;
    background:url(../images/search.png) no-repeat;
    text-indent:-9999em;
    position:absolute;
    right:20px;
    top:50%;
    transform:translateY(-50%);
}
.search #qnaBtn{
	text-align: center;
	background-color: #f8c200;
	width: 100px;
	height: 50px;
	font-weight: 500;
	border-radius: 5px;
	font-weight: bold;
	color: white;
}
.search #qnaBtn:hover{
	background-color: #FFA500;
}
.qnaTable select {
    border: none;
    padding: 5px; 
    text-align: center; 
    background-color: #f8c200;
}
.pagination{
    display:flex;
    justify-content:center;
    align-items:center;
    gap:20px;
    margin-bottom:30px;
}
.pagination li a {
    display: block;
    width: 30px;
    height: 30px;
    text-align: center;
    line-height: 30px;
    color: #000; /* 기본 글자색 */
}

.pagination li.active a {
    font-weight: bold;
    font-size: 18px;
    background-color: #f8c200; /* 활성화된 버튼 배경색 */
    color: #fff; /* 활성화된 버튼 글자색 */
}
</style>
</head>
<body>
<div class="commu_list">
    <h1>묻고 답하기</h1>
	<div class="commu_tab">
	    <button onclick="location.href='../community/faq_list.do'">FAQ</button>
	    <button onclick="location.href='../notice/list.do'">NOTICE</button>
	    <button onclick="location.href='../community/qna_list.do'" style="color:#f8c200">Q&A</button>
	</div>
    <div class="qna_list" id="qnaApp">
	    <table class="qnaTable">
	        <thead>
	            <tr class="qnaTh">
				    <th style="width: 50px;">번호</th>
				    <th style="width: 100px;">
					    <select>
					        <option value="" disabled selected>문의 종류</option>
					        <option value="site">사이트</option>
					        <option value="funding">펀딩</option>
					        <option value="product">상품</option>
					    </select>
					</th>
				    <th style="width: 200px;">제목</th>
				    <th style="width: 100px;">작성자</th>
				    <th style="width: 70px;">등록일</th>
				    <th style="width: 100px;">답변 여부</th> 
	            </tr>
	        </thead>
	        <tbody class="qnaTd">
                <tr v-for="(vo, index) in qna_list" :key="vo.qno">
                    <td>{{ (curpage - 1) * 10 + index + 1 }}</td>
                    <td v-if="vo.type === 1">[사이트]</td>
                    <td v-if="vo.type === 2">[펀딩]</td>
                    <td v-if="vo.type === 3">[상품]</td>
                    
                    <td style="text-align: left;">
					    <span v-if="vo.secret == 1 && vo.id !== sessionId" >
					    <a :href="'../community/qna_detail.do?qno='+vo.qno" style="color: gray">🔒비밀글입니다</a></span>
			            <span v-else><a :href="'../community/qna_detail.do?qno='+vo.qno">{{ vo.subject }}</a></span>
					</td>
                    
                    <td v-if="vo.nickname===null">{{ vo.name }}</td>
                    <td v-else>{{vo.nickname}}</td>
                    
                    <td v-if="vo.dbday===vo.mday">{{ vo.dbday }}</td>
                    <td v-if="vo.dbday!==vo.mday">{{ vo.mday }}</td>
                    
                    <td>
                        <span v-if="vo.reok === 1" style="font-weight: bold;">[답변완료]</span>
                        <span v-else style="color: gray">[답변대기]</span>
                    </td>
                </tr>
	        </tbody>
	    </table>
		<ul class="pagination">
		    <li v-if="startPage > 1">
		        <a class="nav-link" @click="prev()">&lt;&lt;</a>
		    </li>
		    <li v-for="i in range(startPage, endPage)" :class="{ active: i === curpage }">
		        <a class="nav-link" @click="pageChange(i)">{{ i }}</a>
		    </li>
		    <li v-if="endPage < totalpage">
		        <a class="nav-link" @click="next()">&gt;&gt;</a>
		    </li>
		</ul>
		<div class="search">
		    <form>
		        <label for="search">검색</label>
		        <input type="search" name="search" id="search">
		        <button>검색</button>
		    </form>
		    <button id="qnaBtn" @click="checkLogin()">문의 하기</button>
		</div>
    </div>
</div>
<script>
	let qnaApp = Vue.createApp({
		data() {
			return {
				qna_list: [],
				curpage: 1,
				totalpage:0,
				startPage:0,
				endPage:0,
				sessionId:'${sessionId}'
			}
		},
		mounted() {
			this.dataRecv()
		},
		methods: {
			checkLogin() {
				if (this.sessionId === 'null' || !this.sessionId) {
					alert("로그인이 필요합니다.")
					window.location.href = '../member/login.do'; 
				} else {
					window.location.href = '../community/qna_insert.do'; 
				}
			},
			dataRecv() {
				axios.get('../community/qna_list_vue.do', {
					params: {
						page: this.curpage
					}
				}).then(res => {
					console.log(res.data)
					this.qna_list = res.data.list
					this.curpage = res.data.curpage
					this.totalpage = res.data.totalpage
			        this.startPage = res.data.startPage
			        this.endPage = res.data.endPage
				}).catch(error => {
					console.log(error.response);
				})
			},
			AnswerToQna() {
				location.href = '../community/Answer.jsp'
			},
    		range(start,end){
    			let arr=[]
    			let len=end-start
    			for(let i=0;i<=len;i++){
    				arr[i]=start
    				start++
    			}
    			return arr
    		},
    		pageChange(page){
    			this.curpage=page
    			this.dataRecv()
    		},
    		prev(){
    			this.curpage=this.startPage-1
    			this.dataRecv()
    		},
    		next(){
    			this.curpage=this.endPage+1
    			this.dataRecv()
    		}
		}
	}).mount('#qnaApp')
</script>
</body>
</html>
