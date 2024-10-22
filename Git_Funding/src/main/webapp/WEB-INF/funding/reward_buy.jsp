<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<head>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<link rel="stylesheet" href="../css/reward.css">
</head>
<body>
	<div id="reward" class="container">
        <form method="POST" @submit.prevent="submitForm">
            <h2>리워드 정보</h2>
            <div class="reward_box">
                <p class="title">{{reward_vo.name}}</p>
                <pre>{{reward_vo.description}}</pre>
                <div>
	                <div class="account_price">
	                    <div class="account">
	                        <p>수량</p>
	                        <div class="number">
	                            <span @click="minus()">-</span>
	                            <p>{{account}}</p>
	                            <span @click="plus()">+</span>
	                        </div>
	                    </div>
	                    <p class="price">{{reward_vo.fm_price}}원</p>
	                </div>
	                <p class="account_msg">현재 남은 수량은 {{reward_vo.amount}}개 입니다.</p>
                </div>
                <div class="del_pay">
                    <p>배송비</p>
                    <p>{{reward_vo.fm_del}}</p>
                </div>
            </div>
            <div class="pay">
                <h2>결제 금액</h2>
                <p>{{totalprice}}원</p>
            </div>
            <div class="delivery_box">
                <h2>리워드 배송지</h2>
                <div class="ck_box">
                    <input type="checkbox" id="info_check" @change="getMemberInfo()">
                    <label for="info_check">회원정보로 입력</label>
                </div>
                <div>
                    <label for="name">이름</label>
                    <input type="text" id="name" ref="name" name="userName" v-model="reward_del_name">
                </div>
                <div>
                    <label for="phone">휴대폰 번호 <span>{{phoneValidateMsg}}</span></label>
                    <input type="text" id="phone" ref="phone" name="phone" placeholder="숫자만 입력해주세요" v-model="reward_del_phone" @keydown="phoneValidate">
                </div>
                <div class="addr">
                    <div>
                        <label for="address">주소</label>
                        <input type="button" @click="postSearch()" value="주소찾기" ref="postBtn">
                    </div>
                    <p class="post_addr">
                    	<span class="post">{{memberInfo.post}}</span>
                    	<span class="addr1">{{memberInfo.addr1}}</span>
                    </p>
                    <input type="type" id="address" name="address" placeholder="상세주소" v-model="reward_del_addr2">
                </div>
                <div>
                    <label for="request">배송시 요청사항</label>
                    <input type="text" id="request" name="requestMsg" v-model="reward_del_request">
                </div>
            </div>
            <button>결제하기</button>
        </form>
    </div>
    <script>
	    let IMP = window.IMP; 
	    IMP.init("imp57640514"); 
    	let reward_buy=Vue.createApp({
    		data(){
    			return{
    				fno:${fno},
    				rno:${rno},
    				reward_vo:{},
    				account:1,
    				totalprice:'',
    				memberInfo:{},
    				reward_del_name:'',
    				reward_del_phone:'',
    				reward_del_addr2:'',
    				reward_del_request:'',
    				phoneValidateMsg:'',
    				reward_buy_vo:{}
    			}
    		},
    		mounted(){
    			axios.get('../reward/buy_vue.do',{
    				params:{
    					rno:this.rno
    				}
    			}).then(response=>{
    				this.reward_vo=response.data
    				this.totalprice=(this.reward_vo.price*this.account+this.reward_vo.delivery).toLocaleString();
    			}).catch(error=>{
    				console.log(error.response)
    			})
    		},
    		methods:{
    			plus(){
    				if(this.account<this.reward_vo.amount){
	    				this.account=this.account+1
	    				this.totalprice=(this.reward_vo.price*this.account+this.reward_vo.delivery).toLocaleString();    					
    				}
    			},
    			minus(){
    				if(this.account>1){
    					this.account=this.account-1
	    				this.totalprice=(this.reward_vo.price*this.account+this.reward_vo.delivery).toLocaleString();
    				}
    			},
    			getMemberInfo(){
    				if($('#info_check').prop("checked")){
	    				axios.get('../member/reward_delivery.do')
	    				.then(response=>{
	    					this.memberInfo=response.data
	    					this.reward_del_name=response.data.userName
	        				this.reward_del_phone=response.data.phone
	        				this.reward_del_addr2=response.data.addr2
	        				$('.post_addr').show()
	    				}).catch(error=>{
	    					console.log(error.response)
	    				})    					
    				}else{
    					this.memberInfo={}
    					this.reward_del_name=''
        				this.reward_del_phone=''
        				this.reward_del_addr2=''
        					$('.post_addr').hide()
    				}
    			},
    			postSearch(){
    				let _this=this
    				new daum.Postcode({
    					oncomplete:function(data){
    						_this.memberInfo.post=data.zonecode
    						_this.memberInfo.addr1=data.address 
    						$('.post_addr').show()
    					}
    				}).open()
    			},
    			phoneValidate(){
    				let phone=$('#phone').val()
    				if(phone===''){
    					this.phoneValidateMsg=""	
    				}else if(isNaN(phone)){
    					this.phoneValidateMsg="숫자만 입력하세요."
    				}else{
    					this.phoneValidateMsg=""
    				}
    			},
    			submitForm(){
    				if(this.reward_del_name && this.reward_del_phone && this.memberInfo.post!='' && this.memberInfo.addr1!=''){
    					axios.post('../reward/buy_ok.do',null,{
    						params:{
    							"fno":this.fno,
    							"rno":this.rno,
        						"account":this.account,
        						"price":this.reward_vo.price,
        						"delivery":this.reward_vo.delivery,
        						"totalprice":this.reward_vo.price*this.account+this.reward_vo.delivery,
    							"name":this.reward_del_name,
    							"phone":this.reward_del_phone,
    							"post":$('.post').text(),
    							"addr1":$('.addr1').text(),
    							"addr2":this.reward_del_addr2,
    							"requestMsg":this.reward_del_request
    						}
    					}).then(response=>{
    						if(response.data=='ok'){
	    						this.requestPay()    							
    						}else{
    							console.log(response.data)
    						}
    					}).catch(error=>{
    						console.log(error.response)
    					})
    				}else{
    					if(!this.reward_del_name){
    						this.$refs.name.focus()
    					}else if(!this.reward_del_phone){
    						this.$refs.phone.focus()
    					}else if(!this.memberInfo.post=='' || this.memberInfo.addr1==''){
    						this.$refs.postBtn.focus()
    					}
    				}
    			},
    			requestPay() {
					IMP.request_pay({
	    		        pg: "html5_inicis",
	    		        pay_method: "card",
	    		        merchant_uid: "ORD20180131-0000011",   // 주문번호
	    		        name:this.reward_vo.name,
	    		        amount:this.totalprice,      
	    		        buyer_email: '',
	    		        buyer_name:this.reward_del_name,
	    		        buyer_tel:this.reward_del_phone,
	    		        buyer_addr:$('.addr1').text()+" "+this.reward_del_addr2,
	    		        buyer_postcode:$('.post').text()
	    		     }, function (rsp) { // callback
	    		    	location.href="../mypage/funding_buy.do"
	    			 });
				},
    		}
    	}).mount('#reward')
    </script>
</body>
