<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/cart.css">
</head>
<body>
      <div class="container commu_list" style="margin-top: 20px;" id="cart">
            <div class="cartHead">
            	<div class="cartHeadInfo">
	            	<p style="color: white;">STEP1</p>
	            	<h1 style="color: white;">장바구니</h1>
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
	                    <button>선택상품 삭제</button>
	                  </div>
	                  <div>
	                    <button>품절상품 삭제</button>
	                  </div>
	                </div>
	              </div>
	              <div id="f_button" style="display: flex; gap: 15px;">
	                <div><button style="color: #666; border: 1px solid #999; ">계속 쇼핑하기</button></div>
	                <div><button style="color: #d50c0c">선택상품 주문하기</button></div>
	                <div><button style="color: white;background-color: #d50c0c" @click="buyInfo()">전체상품 주문하기</button></div>
	              </div>
	            </div>
            </div>
      </div>
      <script>
        let cart=Vue.createApp({
        	data(){
        		return{
        			gno:1
        		}
        	},
        	methods:{
        		buyInfo(){
        			axios.post('../goods/buyInfo_vue.do',null,{
        				params:{
        					gno:this.gno
        				}
        			}).then(response=>{
        				console.log(response)
        				location.href="../goods/order.do"
        			}).catch(error=>{
        				console.log(error.response)
        			})
        		}
        	}
        }).mount("#cart")
      </script>
</body>
</html>