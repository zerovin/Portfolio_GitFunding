<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/cart.css">
<style type="text/css">
 .order > tbody > tr > th{
	background-color: #999;
	text-align: center;
	color: white;
	font-family: 'NexonLv2Gothic';
	font-size: 13px;
	font-weight: bold;
	text-align: center;
	padding: 20px 0px;
}
#orderInfo > tbody > tr > td{
	padding:20px 15px;
}
#orderLoc > tbody > tr > td{
	padding:15px 15px;
}
input[type="text"]:hover{
	cursor: text;
}
</style>
</head>
<body>
	<div class="container commu_list" style="margin-top: 20px;" id="cartOrder">
            <div class="cartHead">
            	<div class="cartHeadInfo">
	            	<p>STEP1</p>
	            	<h1>장바구니</h1>
            	</div>
            	<div class="cartHeadInfo">
	            	<p style="color: white;">STEP2</p>
	            	<h1 style="color: white;">주문결제</h1>
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
	            	    <th width="3%">
	            	    </th>
	            	    <th width="15%">
	            	     상품코드/배송
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
	            	    <th width="15%">
	            	      주문금액
	            	    </th>
	            	  </tr>
	            	  <tr class="cartList">
	            	    <td width="3%">
	            	    </td>
	            	    <td width="15%">
	            	      <p>철가방배송</p>
	            	      <p style="margin-top: 4px;">1234546243</p>
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
	            	      <p>5개</p>
	            	    </td>
	            	    <td width="15%">
	            	      <p>65,000원</p>
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
	            <div style="height: 30px;"></div>
	            <div>
	              <h3>주문고객 정보</h3>
	              <table style="height: 100px;width: 100%;margin-top: 10px;background-color: white;" class="order" id="orderInfo">
	                <tr style="height: 50%;border-top: 2px solid;">
	                  <th width="15%">보내시는 분</th>
	                  <td width="35%"><input type="text" style="border: 1px solid #999; width:150px"></td>
	                  <th width="15%">이메일</th>
	                  <td width="35%">
		                  <input type="text" style="border: 1px solid #999; width:120px">&nbsp;@
		                  <select name="email_domain" v-model="email_domain">
	                                <option value="naver.com" selected>naver.com</option>
	                                <option value="gmail.com">gmail.com</option>
	                                <option value="hanmail.net">hanmail.net</option>
	                                <option value="kakao.com">kakao.com</option>
	                                <option value="daum.net">daum.net</option>
	                                <option value="hotmail.com">hotmail.com</option>
	                                <option value="yahoo.co.kr">yahoo.co.kr</option>
	                       </select>
	                  </td>
	                </tr>
	                <tr style="height: 50%;border-top:1px solid rgb(234, 234, 234);border-bottom: 1px solid rgb(234, 234, 234);">
	                  <th width="15%">휴대전화</th>
	                  <td width="35%">
	                    <input type="text" id="phone" name="phone" v-model="phone" @keydown="phoneValidate" placeholder="숫자만 입력해주세요" required style="width: 250px;border-bottom: 1px solid #999;">
	                  </td>
	                </tr>
	              </table>
	            </div>
	            <div style="height: 30px;"></div>
	            <div>
	              <h3>배송지 정보</h3>
	              <table style="width: 100%;margin-top: 10px;background-color: white;" class="order" id="orderLoc">
	                <tr style="border-top: 2px solid;">
	                  <th style="width: 15%;padding: 15px 15px;">받으시는분</th>
	                  <td width="85%"><input type="text" style="border: 1px solid #999; width:150px"></td>
	                </tr>
	                <tr style="border-top:1px solid rgb(234, 234, 234);border-bottom: 1px solid rgb(234, 234, 234);">
	                  <th style="width: 15%;padding: 40px 15px;">주소</th>
	                  <td width="85%"><input type="text" style="border: 1px solid #999; width:150px"></td>
	                </tr>
	                <tr style="border-top:1px solid rgb(234, 234, 234);border-bottom: 1px solid rgb(234, 234, 234);">
	                  <th style="width: 15%;padding: 15px 15px;">휴대전화</th>
	                  <td width="85%">
	                  	<input type="text" id="phone" name="phone" v-model="phone" @keydown="phoneValidate" placeholder="숫자만 입력해주세요" required style="width: 250px;border-bottom: 1px solid #999;">
	                  </td>
	                </tr>
	                <tr style="border-top:1px solid rgb(234, 234, 234);border-bottom: 1px solid rgb(234, 234, 234);">
	                  <th style="width: 15%;padding: 30px 15px;">배송 요청사항</th>
	                  <td width="85%">
	                     <select name="order_request" v-model="order_request">
	                                <option v-for="(request , index) in requestList" :value="request.value" v-bind:key="index" selected>
	                                {{request.name}}
	                                </option> 
	                     </select>
	                     <input type="text" style="border-bottom: 1px solid #999; width: 400px" v-if="isShow">
	                  </td>
	                </tr>
	              </table>
	            </div>
            </div>
      </div>
      <script>
         let cartOrder=Vue.createApp({
        	 data(){
        		return{
        			isShow:false,
        			requestList:[
        				{name:'배송 요청사항 없음',value:'배송 요청사항 없음'},
        				{name:'배송 전 연락바랍니다.',value:'배송 전 연락바랍니다.'},
        				{name:'부재시 경비실(관리실)에 맡겨주세요.',value:'부재시 경비실(관리실)에 맡겨주세요.'},
        				{name:'부재시 휴대폰으로 연락바랍니다',value:'부재시 휴대폰으로 연락바랍니다'},
        				{name:'직접입력',value:'직접입력'}
        			],
        			order_request:''
        		} 
        	 },
        	 mounted(){
        		 if(this.order_resquest==="직접입력"){
        			 this.isShow=true
        			 console.log(this.isShow)
        		 }
        		 
        	 },
        	 methods:{
        		 
        	 }
         }).mount('#cartOrder')
      </script>
</body>
</html>