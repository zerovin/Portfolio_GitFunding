<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.cartHead{
	margin-top: 20px;
	grid-template-columns: 2fr 2fr 2fr 3fr;
    display: flex; /* 플렉스 박스 사용 */
    justify-content: space-around; /* 각 div를 고르게 분배 */
    align-items: flex-end; /* 아이템을 아래쪽으로 정렬 */
    height: 100px; /* div의 높이 설정 (필요에 따라 조정) */
}
.cartHead div {
    flex: 1; /* 각 div의 너비를 동일하게 설정 */
}
.cartHead > div > h1{
	font-weight: bold;
	font-size: 35px;
	font-family: 'NexonLv2Gothic';
}
.cartBox{
	padding: 20px;
	background-color: #f1f1f1;
	font-family: 'NexonLv2Gothic';
}
.cart{
	background-color: white;
	font-family: 'NexonLv2Gothic';
}
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
}
.view-all:hover {
    background-color: #FFA500;
}
</style>
</head>
<body>
        <div class="container commu_list" style="margin-top: 20px;">
            <div class="cartHead">
            	<div><h1>장바구니</h1></div>
            	<div><h1>주문결제</h1></div>
            	<div><h1>주문완료</h1></div>
            	<div></div>
            </div>
          <div class="cartBox">
        	<div class="cart">
             <div>불고기</div>
        	     <div>
           			<ol class="rank_list">
	                    <li>
	                        <a href="#">
	                            <p class="number">1</p>
	                            <div class="rank_content">
	                                <div class="text">
	                                    <p class="title">지퍼백 한번 쓰고 버리세요? 열탕소독으로 평생 쓰는 &lt;플래티넘 실리콘백&gt;</p>
	                                    <p class="headcount">4,660명 참여</p>
	                                </div>
	                                <img src="../images/rank.jpeg" alt="">
	                            </div>
	                        </a>
	                    </li>
	                    <li>
	                        <a href="#">
	                            <p class="number">2</p>
	                            <div class="rank_content">
	                                <div class="text">
	                                    <p class="title">지퍼백 한번 쓰고 버리세요? 열탕소독으로 평생 쓰는 &lt;플래티넘 실리콘백&gt;</p>
	                                    <p class="headcount">4,660명 참여</p>
	                                </div>
	                                <img src="../images/rank.jpeg" alt="">
	                            </div>
	                        </a>
	                    </li>
	                    <li>
	                        <a href="#">
	                            <p class="number">3</p>
	                            <div class="rank_content">
	                                <div class="text">
	                                    <p class="title">지퍼백 한번 쓰고 버리세요? 열탕소독으로 평생 쓰는 &lt;플래티넘 실리콘백&gt;</p>
	                                    <p class="headcount">4,660명 참여</p>
	                                </div>
	                                <img src="../images/rank.jpeg" alt="">
	                            </div>
	                        </a>
	                    </li>
	                    <li>
	                        <a href="#">
	                            <p class="number">4</p>
	                            <div class="rank_content">
	                                <div class="text">
	                                    <p class="title">지퍼백 한번 쓰고 버리세요? 열탕소독으로 평생 쓰는 &lt;플래티넘 실리콘백&gt;</p>
	                                    <p class="headcount">4,660명 참여</p>
	                                </div>
	                                <img src="../images/rank.jpeg" alt="">
	                            </div>
	                        </a>
	                    </li>
	                    <li>
	                        <a href="#">
	                            <p class="number">5</p>
	                            <div class="rank_content">
	                                <div class="text">
	                                    <p class="title">지퍼백 한번 쓰고 버리세요? 열탕소독으로 평생 쓰는 &lt;플래티넘 실리콘백&gt;</p>
	                                    <p class="headcount">4,660명 참여</p>
	                                </div>
	                                <img src="../images/rank.jpeg" alt="">
	                            </div>
	                        </a>
	                    </li>
	                </ol>
	            </div>
	           
			</div>
        </div>
      </div>
</body>
</html>