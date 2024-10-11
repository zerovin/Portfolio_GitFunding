<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.cartHead{
	padding-left:20px;
	margin-top: 20px;
    display: flex; /* 플렉스 박스 사용 */
    justify-content: space-around; /* 각 div를 고르게 분배 */
    height: 100px; /* div의 높이 설정 (필요에 따라 조정) */
    background-color: #F8C200;
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
.cartHeadInfo{
	padding-top: 40px;
}
.commu_list {
	width: 960px;
    margin: 0 auto;
    padding: 20px;
    font-family: 'NexonLv2Gothic';
}
.cartList{
	border-top: 1px solid #F8C200;
}
.cartList > th{
	padding: 9px;
	font-family: 'NEXON Lv2 Gothic';
}
.cartList > td{
	height:80px;
	font-family: 'NEXON Lv2 Gothic';
	text-align: center;
	vertical-align: middle;
}
.cartList input[type="button"]:hover {
	filter: brightness(0.9);
}
</style>
</head>
<body>
      <div class="container commu_list" style="margin-top: 20px;">
            <div class="cartHead">
            	<div class="cartHeadInfo">
	            	<p>STEP1</p>
	            	<h1>장바구니</h1>
            	</div>
            	<div class="cartHeadInfo">
	            	<p>STEP2</p>
	            	<h1>주문결제</h1>
            	</div>
            	<div class="cartHeadInfo">
	            	<p>STEP3</p>
	            	<h1>주문완료</h1>
            	</div>
            	<div></div>
            </div>
            <div class="cartBox">
	            <div class="cart">
	            	<table style="width: 100%">
	            	  <tr class="cartList" style="height: 36px;">
	            	    <th width="5%">
	            	    </th>
	            	    <th width="10%">
	            	     상품코드
	            	    </th>
	            	    <th width="10%">
	            	      브랜드
	            	    </th>
	            	    <th width="37%" colspan="2">
	            	      상품정보
	            	    </th>
	            	    <th width="10%">
	            	      판매가격
	            	    </th>
	            	    <th width="10%">
	            	      수량
	            	    </th>
	            	    <th width="10%">
	            	      주문금액
	            	    </th>
	            	    <th width="8%">
	            	    </th>
	            	  </tr>
	            	  <tr class="cartList">
	            	    <td width="5%">
	            	      <input type="checkbox" class="buyCheck" style="height: 80px;">
	            	    </td>
	            	    <td width="10%">
	            	      <p>1234546243</p>
	            	    </td>
	            	    <td width="10%">
	            	      <p>SANRIO</p>
	            	    </td>
	            	    <td width="12%">
	            	      <img src="http://webimage.10x10.co.kr/image/small/347/S003471382-1.jpg" style="width: 60px;height: 60px">
	            	    </td>
	            	    <td width="25%" style="text-align: left;padding-left: 5px ">
	            	      <p>크아아아아아악</p>
	            	    </td>
	            	    <td width="10%">
	            	      <p style="text-decoration-line: line-through;color: #899c8f;">17,000원</p>
	            	      <p>15,000원</p>
	            	    </td>
	            	    <td width="10%" >
	            	      <input type="number" min="1" style="border: 1px solid #888;width: 40px" value="5">
	            	    </td>
	            	    <td width="10%">
	            	      <p>65,000원</p>
	            	    </td>
	            	    <td width="8%">
	            	      <input type="button" value="바로 주문" style="font-size: 13px;width: 62px;background-color: #F8C200;color: white;line-height: 13px;border-radius: 5px;">
	            	      <input type="button" value="X삭제" style="font-size: 13px;width: 62px;background-color: #444;color: white;line-height: 13px;border-radius: 5px;">
	            	    </td>
	            	  </tr>
	            	  <tr>
	            	    <td colspan="11" style="height: 35px;padding: 15px 8px;background-color: #eaeaea;text-align: right;">
	            	    	<p style="padding-top: 10px">불고기<p>
	            	    </td>
	            	  </tr>
	            	</table>
	            </div>
	            <div style="height: 20px;"></div>
	            <div>
	            
	            </div>
            </div>
      </div>
</body>
</html>