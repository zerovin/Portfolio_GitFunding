<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>

<!-- <script src="https://cdn.jsdelivr.net/npm/vue@3.2.31/dist/vue.global.js"></script> -->
<!-- <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script> -->
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
.NoticeList {
    border-radius: 10px;
    width: 960px;
    height: 700px;
}
.NoticeTable {
	width: 950px;
	margin-bottom: 15px;
}
.NoticeTh {
	background-color: #f8c200;
	border-bottom: 3px solid;
    height: 40px;
    vertical-align: middle; 
}
.NoticeTh>th{
    display: table-cell;
    vertical-align: middle; 
    text-align: center; 
}
.NoticeTd {
	border: 1px solid gray;
}
.NoticeTd>tr{
	border: 1px solid gray;
	height: 40px;
	line-height: 40px;
	text-align: center;
}
.NoticeSearch{
    display:flex;
    justify-content:flex-end;
    align-items:center;
    gap:120px;
    margin-right:10px;
    margin-bottom:30px;
}
.NoticeSearch form{
    display:flex;
    align-items:center;
    gap:20px;
    position:relative;
}
.NoticeSearch form label{
    display:none;
}
.NoticeSearch form input{
    width:550px;
    height:50px;
    border:2px solid #F8C200;
    border-radius:27px;
    padding:25px;
    padding-right:40px;
}
.NoticeSearch form button{
    width:24px;
    height:23px;
    background:url(../images/search.png) no-repeat;
    text-indent:-9999em;
    position:absolute;
    right:20px;
    top:50%;
    transform:translateY(-50%);
}
.NoticeSearch #CreateNotice{
	text-align: center;
	background-color: #f8c200;
	width: 120px;
	height: 50px;
	border-radius: 5px;
	font-weight: bold;
	color: white;
}
#CreateNotice:hover{
	background-color: #FFA500;
}
.NoticeTable select {
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
    font-weight:bold;
    font-size:18px;
    background-color:#f8c200;
    color:#fff;
}
.NavToDetail{
	text-align: left;
}

</style>
</head>
<body>
<div class="commu_list">
    <h1>공지사항</h1>
	<div class="commu_tab">
	    <button onclick="location.href='../community/faq_list.do'">FAQ</button>
	    <button onclick="location.href='../notice/list.do'" style="color:#f8c200">NOTICE</button>
	    <button onclick="location.href='../community/qna_list.do'"">Q&A</button>
	</div>
    <div class="NoticeList" id="listApp">
	    <table class="NoticeTable">
	        <thead>
	            <tr class="NoticeTh">
				    <th style="width: 50px;">번호</th>
				    <th style="width: 100px;">
					    <select>
					        <option value="all_view">전체</option>
					        <option value="notice">공지</option>
					        <option value="event">이벤트</option>
					    </select>
					</th>
				    <th style="width: 200px;">제목</th>
				    <th style="width: 100px;">작성자</th>
				    <th style="width: 70px;">등록일</th>
	            </tr>
	        </thead>
	        <tbody class="NoticeTd">
                <tr v-for="(vo, index) in notice_list" :key="vo.qno">
                    <td>{{ (curpage - 1) * 10 + index + 1 }}</td>
                    <td v-if="vo.type === 0">전체</td>
                    <td v-if="vo.type === 1">공지</td>
                    <td v-if="vo.type === 2">이벤트</td>
                    
                    <td class="NavToDetail">
					    <a :href="'../notice/detail.do?no='+vo.no">{{vo.subject}}</a>
					</td>
                    <td>${sessionScope.nickname}</td>
                    <td>{{ vo.dbday }}</td>
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
		<div class="NoticeSearch">
		    <form>
		        <label for="NoticeSearch">검색</label>
		        <input type="search" name="search" id="search">
		        <button>검색</button>
		    </form>
		    <sec:authorize access="hasRole('ROLE_ADMIN')">
		    	<button id="CreateNotice" @click="CreateNotice()">새 공지 작성</button>
		    </sec:authorize>
		</div>
    </div>
</div>
<script>
	let noticeApp = Vue.createApp({
		data() {
			return {
				notice_list: [],
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
			CreateNotice() {
				location.href = '../notice/insert.do'; 
			},
			dataRecv() {
				axios.get('../notice/list_vue.do', {
					params: {
						page: this.curpage
					}
				}).then(res => {
					console.log(res.data)
					this.notice_list = res.data.list
					this.curpage = res.data.curpage
					this.totalpage = res.data.totalpage
			        this.startPage = res.data.startPage
			        this.endPage = res.data.endPage
				}).catch(error => {
					console.log(error.response);
				})
			},
    		range(start,end){
    			let arr = []
    			let len = end - start
    			for (let i = 0; i <= len; i++) {
    				arr[i] = start
    				start++
    			}
    			return arr
    		},
    		pageChange(page){
    			this.curpage = page
    			this.dataRecv()
    		},
    		prev(){
    			this.curpage = this.startPage-1
    			this.dataRecv()
    		},
    		next(){
    			this.curpage = this.endPage+1
    			this.dataRecv()
    		}
		}
	}).mount('#listApp')
</script>
</body>
</html>