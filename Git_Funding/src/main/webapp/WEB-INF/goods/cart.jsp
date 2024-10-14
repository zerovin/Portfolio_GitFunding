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
#totalprice{
	display: grid;
	margin-top: 20px;
	padding: 20px;
	height: 150px;
	border: 4px solid #999;
	background-color: white;
	grid-template-rows: 4fr 1fr 2fr;
}
#f_button > div {
	height: 50px;
	width: 180px;
	border: 1px solid red;
	text-align: center;
}
#f_button > div > p {
	margin-top: 18px;
	font-family: 'NexonLv2Gothic';
	font-size: 13px;
	font-weight: bold;
}
#f_button > div:hover,#chooseBtn > div:hover {
	cursor: pointer;
	filter: brightness(0.8);
}
#chooseBtn{
	display: flex;
	gap: 3px;
}
#chooseBtn > div{
	background-color: #999;
	color: white;
	font-family: 'NexonLv2Gothic';
	font-size: 12px;
	font-weight: bold;
	padding: 7px 3px 3px 3px;
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
	            <div id="totalprice">
	               <div style="display: flex; justify-content: space-between;">
	                 <div>
	                 	<h1 style="ont-weight: bold;font-size: 27px;font-family: 'NexonLv2Gothic';">총 주문 금액</h1>
	                 </div>
	                 <div style="width: 300px">
		                 <ul>
		                   <li>
		                     <div style="display: flex; justify-content: space-between;">
			                     <span>상품 총 금액</span>
			                     <span>1억</span>
		                     </div>
		                   </li>
		                   <li><hr style="width: 300px; background-color: rgb(234, 234, 234);height: 1px;border: 0"></li>
		                   <li>
		                     <div style="display: flex; justify-content: space-between;">
			                     <span>배송비</span>
			                     <span>2조</span>
		                     </div>
		                   </li>
		                   <li><hr style="width: 300px; background-color: rgb(234, 234, 234);height: 1px;border: 0"></li>
		                 </ul>
	                 </div>
	               </div>
	               <hr style="width: 880px">
	               <div style="display: flex; justify-content: flex-end;">
	                 <div>
	               	  <div style="margin-top: 10px;">
		               	  <p style="display: inline; font-weight: bold;font-size: 12px">결제 예정 금액</p>
		               	  <p style="display: inline;color: #d50c0c;font-size: 20px;font-weight: bold; padding-left: 10px">145조원</p>
	               	  </div>
	               	 </div>
	               </div>
	            </div>
	            <div style="margin-top: 20px;display: flex;justify-content: space-between;">
	              <div style="display: grid">
	                <div style="font-weight: bold; font-size: 12px">
	                  <input type="checkbox">&nbsp;전체선택
	                </div>
	                <div id="chooseBtn">
	                  <div>
	                    선택상품 삭제
	                  </div>
	                  <div>
	                    품절상품 삭제
	                  </div>
	                </div>
	              </div>
	              <div id="f_button" style="display: flex; gap: 15px;">
	                <div style="border: 1px solid #999; "><p style="color: #666">계속 쇼핑하기</p></div>
	                <div><p style="color: #d50c0c">선택상품 주문하기</p></div>
	                <div style="background-color: #d50c0c"><p style="color: white;">전체상품 주문하기</p></div>
	              </div>
	            </div>
            </div>
      </div>
</body>
</html>