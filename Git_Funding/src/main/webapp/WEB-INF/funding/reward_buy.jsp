<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<head>
<link rel="stylesheet" href="../css/reward.css">
</head>
<body>
	<div id="reward" class="container">
        <form method="POST" action="">
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
                    <input type="checkbox" id="info_check">
                    <label for="info_check">회원정보로 입력</label>
                </div>
                <div>
                    <label for="name">이름</label>
                    <input type="text" id="name" name="userName">
                </div>
                <div>
                    <label for="phone">휴대폰 번호</label>
                    <input type="text" id="phone" name="phone" placeholder="숫자만 입력해주세요">
                </div>
                <div class="addr">
                    <div>
                        <label for="address">주소</label>
                        <button>주소 찾기</button>
                    </div>
                    <p class="addr1"></p>
                    <input type="type" id="address" name="address" placeholder="상세주소">
                </div>
                <div>
                    <label for="request">배송시 요청사항</label>
                    <input type="text" id="request" name="requestMsg">
                </div>
            </div>
            <button>결제하기</button>
        </form>
    </div>
    <script>
    	let reward_buy=Vue.createApp({
    		data(){
    			return{
    				rno:${rno},
    				reward_vo:{},
    				account:1,
    				totalprice:''
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
    			}
    		}
    	}).mount('#reward')
    </script>
</body>
