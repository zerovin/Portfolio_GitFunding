<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/cart.css">
<script type="text/javascript">
$(function() {
    $('#selectedOrder').on('click', function() {
    	
        const checkboxes = document.querySelectorAll('.buyCheck');
        const form = $('#item-form')[0]; // jQuery 객체에서 DOM 요소로 변환
        
        let hasChecked = false; // 체크된 항목이 있는지 여부를 추적
     	// 수량 확인
		let account_ok = true
		
        checkboxes.forEach(checkbox => {
            if (checkbox.checked) {
                hasChecked = true; // 체크된 항목 발견
            }
            let max = parseInt(checkbox.getAttribute('data-max'),10);
            let account = parseInt(checkbox.getAttribute('data-account'),10);
            
            if(account > max){
            	alert(checkbox.getAttribute('data-title')+"의 수량은"+max+"개를 넘을 수 없습니다")
            	account_ok = false
            	return
            }
        });
        
        // 체크된 항목이 없으면 경고
        if (!hasChecked) {
            alert('체크된 항목이 없습니다.');
            return;
        }	
        
        if(account_ok){
	        // 기존의 숨겨진 input 삭제
	        const existingInputs = form.querySelectorAll('input[name="fgcno"], input[name="account"]');
	        existingInputs.forEach(input => input.remove());
	        
			
	        checkboxes.forEach(checkbox => {
	            if (checkbox.checked) {
	                // fgcno 숨겨진 input 생성
	                
	                let max = parseInt(checkbox.getAttribute('data-max'),10);
	                let account = parseInt(checkbox.getAttribute('data-account'),10);
	                
	                if(account > max){
	                	alert(checkbox.getAttribute('data-title')+"의 수량은"+max+"개를 넘을 수 없습니다")
	                	account_ok = false
	                	return
	                }
	                
	                
	                const hiddenNoInput = document.createElement('input');
	                hiddenNoInput.type = 'hidden'; // 수정: hiddenInput -> hiddenNoInput
	                hiddenNoInput.name = 'fgcno';
	                hiddenNoInput.value = checkbox.getAttribute('data-fgcno');
	                form.appendChild(hiddenNoInput);
	
	                // account 숨겨진 input 생성
	                const hiddenEaInput = document.createElement('input');
	                hiddenEaInput.type = 'hidden'; // 수정: hiddenInput -> hiddenEaInput
	                hiddenEaInput.name = 'account';
	                hiddenEaInput.value = checkbox.getAttribute('data-account');
	                form.appendChild(hiddenEaInput);
	            }
	        });
	
			
	        // 폼 제출
	       
	        form.submit();
        }
        else{
        	return
        }
    });
    $('#item-form').submit(function(e){
    	
    	const checkboxes = document.querySelectorAll('.buyCheck');
    	let hasChecked = false
    	checkboxes.forEach(checkbox => {
    		checkbox.checked=true
            if (checkbox.checked) {
                hasChecked = true;
            }
        });

        if (!hasChecked) {
        	e.preventDefault()
            alert('상품목록이 비었습니다');
            return;
        }
    })
});
</script>
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
            <div class="cartBox" >
                <form method="post" action="../goods/order.do" id="item-form">
                <div style="display: flex;justify-content: center;margin: 150px 0px ;" v-if="cartList.length==0" id="cartBlank">
            		<img src="../images/cart_blank.png">
            	</div>
	            <div class="cart" v-if="cartList.length!=0">
	            	<table style="width: 100%">
	            	  <tr class="cartList" style="height: 36px;">
	            	    <th width="5%">
	            	    </th>
	            	    <th width="10%">
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
	            	    <th width="10%">
	            	      주문금액
	            	    </th>
	            	    <th width="8%">
	            	    </th>
	            	  </tr>
	            	  <tr class="cartList" v-for="vo in cartList">
	            	    <td width="5%">
	            	      <input type="checkbox" name="itemIds" class="buyCheck" style="height: 80px;"  v-model="vo.checked" :data-fgcno="vo.fgcno" 
	            	      :data-account="vo.account" :data-max="vo.max" :data-title="vo.gvo.title">
	            	      
	            	      <input type="hidden" :value="vo.fgcno" name="fgcno">
	            	    </td>
	            	    <td width="10%">
	            	      <p style="font-size: 13px">{{vo.gvo.delivery}}</p>
	            	      <p>{{vo.fgno}}</p>
	            	    </td>
	            	    <td width="10%">
	            	      <p>{{vo.gvo.brand}}</p>
	            	    </td>
	            	    <td width="12%">
	            	      <img :src="vo.gvo.img" style="width: 60px;height: 60px">
	            	    </td>
	            	    <td width="25%" style="text-align: left;padding-left: 5px ">
	            	      <p>{{vo.gvo.title}}</p>
	            	      <p style="color: #999;margin-top: 3px;font-weight: bold;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;">[옵션]:{{vo.ops}}</p>
	            	    </td>
	            	    <td width="10%">
	            	      <p style="text-decoration-line: line-through;color: #899c8f;">{{vo.gvo.price}}</p>
	            	      <p>{{vo.price}}</p>
	            	    </td>
	            	    <td width="10%" >
	            	      <input type="number" min="1" :max="vo.max" style="border: 1px solid #888;width: 40px" :value="vo.account" class="item-quantity" :data-price="vo.price" v-model="vo.account" name="account">
	            	    </td>
	            	    <td width="10%">
	            	      <p class="item-price">{{formatCurrency(total(vo)) }}</p>
	            	      <input type="hidden" value="delivery(vo)">
	            	    </td>
	            	    <td width="8%">
	            	      <!-- <input type="button" value="바로 주문" style="font-size: 13px;width: 62px;background-color: #F8C200;color: white;line-height: 13px;border-radius: 5px;">
	            	      <input type="button" value="X삭제" style="font-size: 13px;width: 62px;background-color: #444;color: white;line-height: 13px;border-radius: 5px;"> -->
	            	    </td>
	            	  </tr>
	            	  <tr>
	            	    <td colspan="11" style="height: 35px;padding: 15px 8px;background-color: #eaeaea;text-align: right;">
	            	    	<p style="padding-top: 10px"> 상품 합계 금액 {{formatCurrency(totalPrice())}} 원 + 배송비 {{formatCurrency(deliveryTotal())}} 원 = {{formatCurrency(totalPrice() + deliveryTotal())}} 원<p>	
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
			                     <span>{{formatCurrency(totalPrice())}} 원</span>
		                     </div>
		                   </li>
		                   <li><hr style="width: 300px; background-color: rgb(234, 234, 234);height: 1px;border: 0"></li>
		                   <li>
		                     <div style="display: flex; justify-content: space-between;">
			                     <span>배송비</span>
			                     <span>{{formatCurrency(deliveryTotal())}} 원</span>
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
		               	  <p style="display: inline;color: #d50c0c;font-size: 20px;font-weight: bold; padding-left: 10px">{{formatCurrency(totalPrice() + deliveryTotal())}} 원</p>
	               	  </div>
	               	 </div>
	               </div>
	            </div>
	            
	            <div style="margin-top: 20px;display: flex;justify-content: space-between;">
	              <div style="display: grid">
	                <div style="font-weight: bold; font-size: 12px">
	                  <input type="checkbox" v-model="selectAll" @change="toggleAll">&nbsp;전체선택
	                </div>
	                <div id="chooseBtn">
	                  <div>
	                    <button type="button" @click="cartCancel()">선택상품 삭제</button>
	                  </div>
	                  <div>
	                   
	                  </div>
	                </div>
	              </div>
	              <div id="f_button" style="display: flex; gap: 15px;">
	                <div><button type="button" style="color: #666; border: 1px solid #999; " @click="goShoping()">계속 쇼핑하기</button></div>
	                <div><button type="button" id="selectedOrder" style="color: #d50c0c">선택상품 주문하기</button></div>
	                <div><button type="submit" style="color: white;background-color: #d50c0c" >전체상품 주문하기</button></div>
	              </div>
	            </div>
	            </form>
            </div>
      </div>
      <script>
        let cart=Vue.createApp({
        	data(){
        		return{
        			id:'${sessionScope.userId}',
        			cartList:[],
        			selectAll:false
        		}
        	},
        	mounted(){
        		this.dataRecv()
        	},
        	methods:{
        		toggleAll() {
        		      // 모든 체크박스를 selectAll의 상태로 변경
        		      this.cartList.forEach(cartList => {
        		        cartList.checked = this.selectAll;
        		      });
        		},
        		dataRecv(){
        			axios.post('../goods/cartList_vue.do',null,{
        				params:{
        					id:this.id
        				}
        			}).then(response=>{
        				console.log(response)
        				this.cartList=response.data.cList
        			}).catch(error=>{
        				console.log(error.response)
        			})
        		},
        		total(vo){
        			const price = parseFloat(vo.price.replace(/[^0-9.-]+/g, ''));
                    const account = vo.account
                    return price * account || 0;    
        		},
        		formatCurrency(value) {
                    if (value !== 0) {
                        return new Intl.NumberFormat('en-US', {
                        	 minimumFractionDigits: 0,
                             maximumFractionDigits: 0,
                        }).format(value);
                    }
                    return '0'; // 0일 때 기본 표시
                },
                totalPrice(){
                	 return this.cartList.filter(vo=> vo.checked).reduce((total, vo) => total + this.total(vo), 0);
                }, 
                delivery(vo){
                	const deli = vo.gvo.delivery
                	let delp = 0
                	if(deli=="텐텐배송"){
                		delp = 3000
                	}else if(deli=="업체조건배송"){
                		delp = 5000
                	}else if(deli=="텐바이텐배송"){
                		delp = 4000
                	}else if(deli=="해외직구 배송"){
                		delp = 10000
                	}
                	return delp
                },
                deliveryTotal(){
                	return this.cartList.filter(vo=> vo.checked).reduce((total, vo) => total + this. delivery(vo), 0)
                },
                cartCancel() {
                	if(this.cartList.length == 0){
                		alert("카트 목록이 비었습니다")
                		return
                	}
                	
                    const selected = this.cartList.filter(vo => vo.checked).map(vo => vo.fgcno);
                    console.log("selected"+selected); // 선택된 항목 확인
					
                    if (selected.length == 0){
                    	alert("체크한 항목이 없습니다")
                    	return
                    }
                    
                    // FormData 객체 생성
                    const formData = new FormData();
                    selected.forEach(id => formData.append('selected', id)); // 각 ID를 FormData에 추가
                    console.log(formData)
                    
                    // Axios 요청
                    axios.post('../goods/cart_delete.do', formData, {
                        headers: {
                            'Content-Type': 'multipart/form-data' // FormData를 사용하므로 Content-Type 설정
                        }
                    })
                    .then(response => {
                        if (response.data === "ok") {
                            this.dataRecv(); // 성공적으로 삭제 후 데이터 새로 고침
                        } else {
                            alert("카트 목록 삭제에 실패하였습니다: " + response.data);
                        }
                    })
                    .catch(error => {
                        console.error("An error occurred:", error);
                        alert("카트 목록 삭제 중 오류가 발생했습니다.");
                    });
                },
                goShoping(){
                	location.href="../goods/list.do"
                }
        	}
        }).mount("#cart")
      </script>
</body>
</html>