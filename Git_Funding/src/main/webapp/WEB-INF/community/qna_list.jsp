<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
.qna_list {
    border-radius: 10px;
    width : 960px;
    height: 800px;
}
.qnaTable {
	width: 950px;
	margin-bottom: 15px;
}
.qnaTh {
	background-color : #f8c200;
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
	border : 1px solid gray;
}
.qnaTd>tr{
	border : 1px solid gray;
	height: 40px;
	line-height : 40px;
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
	background-color : #f8c200;
	width: 100px;
	height: 50px;
	font-weight: 500;
	border-radius: 5px;
}
.qnaTable select {
    border: none;
    padding: 5px; 
    text-align: center; 
    background-color: #f8c200;
}
</style>
</head>
<body>
<div class="commu_list">
    <h1>묻고 답하기</h1>
	<div class="commu_tab">
	    <button onclick="location.href='#'">NOTICE</button>
	    <button onclick="location.href='../community/faq_list.do'">FAQ</button>
	    <button onclick="location.href='../community/qna_list.do'" style="color:#f8c200">Q&A</button>
	</div>
    <div class="qna_list">
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
                <tr>
                    <td>1</td>
                    <td>[프로젝트]</td>
                    <td style="text-align: left;">비밀글입니다</td>
                    <td>김다영</td>
                    <td>24.10.08</td>
                    <td>답변 완료</td> 
                </tr>
                <tr>
                    <td>1</td>
                    <td>[프로젝트]</td>
                    <td style="text-align: left;">비밀글입니다</td>
                    <td>김다영</td>
                    <td>24.10.08</td>
                    <td>답변 완료</td> 
                </tr>
                <tr>
                    <td>1</td>
                    <td>[프로젝트]</td>
                    <td style="text-align: left;">비밀글입니다</td>
                    <td>김다영</td>
                    <td>24.10.08</td>
                    <td>답변 완료</td> 
                </tr>
                <tr>
                    <td>1</td>
                    <td>[프로젝트]</td>
                    <td style="text-align: left;">비밀글입니다</td>
                    <td>김다영</td>
                    <td>24.10.08</td>
                    <td>답변 완료</td> 
                </tr>
                <tr>
                    <td>1</td>
                    <td>[프로젝트]</td>
                    <td style="text-align: left;">비밀글입니다</td>
                    <td>김다영</td>
                    <td>24.10.08</td>
                    <td>답변 완료</td> 
                </tr>
                <tr>
                    <td>1</td>
                    <td>[프로젝트]</td>
                    <td style="text-align: left;">비밀글입니다</td>
                    <td>김다영</td>
                    <td>24.10.08</td>
                    <td>답변 완료</td> 
                </tr>
                <tr>
                    <td>1</td>
                    <td>[프로젝트]</td>
                    <td style="text-align: left;">비밀글입니다</td>
                    <td>김다영</td>
                    <td>24.10.08</td>
                    <td>답변 완료</td> 
                </tr>
                <tr>
                    <td>1</td>
                    <td>[프로젝트]</td>
                    <td style="text-align: left;">비밀글입니다</td>
                    <td>김다영</td>
                    <td>24.10.08</td>
                    <td>답변 완료</td> 
                </tr>
                <tr>
                    <td>1</td>
                    <td>[프로젝트]</td>
                    <td style="text-align: left;">비밀글입니다</td>
                    <td>김다영</td>
                    <td>24.10.08</td>
                    <td>답변 완료</td> 
                </tr>
                <tr>
                    <td>1</td>
                    <td>[프로젝트]</td>
                    <td style="text-align: left;">비밀글입니다</td>
                    <td>김다영</td>
                    <td>24.10.08</td>
                    <td>답변 완료</td> 
                </tr>
                <tr>
                    <td>1</td>
                    <td>[프로젝트]</td>
                    <td style="text-align: left;">비밀글입니다</td>
                    <td>김다영</td>
                    <td>24.10.08</td>
                    <td>답변 완료</td> 
                </tr>
                <tr>
                    <td>1</td>
                    <td>[프로젝트]</td>
                    <td style="text-align: left;">비밀글입니다</td>
                    <td>김다영</td>
                    <td>24.10.08</td>
                    <td>답변 완료</td> 
                </tr>
                <tr>
                    <td>1</td>
                    <td>[프로젝트]</td>
                    <td style="text-align: left;">비밀글입니다</td>
                    <td>김다영</td>
                    <td>24.10.08</td>
                    <td>답변 완료</td> 
                </tr>
	        </tbody>
	    </table>
	    <div class="search">
            <form>
                <label for="search">검색</label>
                <input type="search" name="search" id="search">
                <button>검색</button>
            </form>
            <button id="qnaBtn" onclick="location.href='../community/qna_insert.do'">문의 하기</button>
       </div>
    </div>
</div>
</body>
</html>
