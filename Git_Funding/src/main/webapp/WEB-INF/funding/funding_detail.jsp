<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<head>
<link rel="stylesheet" href="../css/funding_detail.css">
</head>
<body>
	<div id="funding_detail">
        <ul class="detail_tab">
            <li><a href="" class="active">상세설명</a></li>
            <li><a href="">새소식</a></li>
            <li><a href="">커뮤니티</a></li>
        </ul>
        <section class="container">
            <div class="left">
                <img :src="funding_vo.thumb" :alt="funding_vo.title" class="thumb">
                <h2>상세설명</h2>
                <div class="img_scroll">
                    <div class="imgs">
                        <img v-for="img in img_list" :src="img.image" alt="">
                    </div>
                    <button class="readmore">상세내용 더보기 <i class="fa-solid fa-chevron-down"></i></button>
                </div>
            </div>
            <div class="right">
                <div class="top">
                    <p class="cate">{{funding_vo.type}}</p>
                    <button class="share"><i class="fa-solid fa-share-nodes"></i>공유</button>
                </div>
                <div class="content">
                    <p class="title">{{funding_vo.title}}</p>
                    <p class="desc">{{funding_vo.description}}</p>
                    <p class="p_admin">{{funding_vo.p_admin}}</p>
                    <div class="num_icon">
                        <div class="nums">
                            <div>
                                <p class="big"><span class="num">{{funding_vo.fm_percent}}</span> % 달성</p>
                                <p class="small">{{funding_vo.dday}}일 남음</p>
                            </div>
                            <div>
                                <p class="big"><span class="num">{{funding_vo.fm_totalprice}}</span> 원 달성</p>
                                <p class="small">{{funding_vo.fm_headcount}}명 참여</p>
                            </div>
                            <p><span class="num">{{funding_vo.period}}</span> 진행</p>
                        </div>
                        <div class="icons">
                            <button @click="wishUpdate(funding_vo.fno)" v-if="isWish===false"><i class="fa-regular fa-heart"></i>{{funding_vo.fm_wish}}</button>
                            <button @click="wishDelete(funding_vo.fno)" v-else><i class="fa-solid fa-heart"></i>{{funding_vo.fm_wish}}</button>
                            <button><i class="fa-regular fa-handshake"></i>{{funding_vo.fm_backing}}</button>
                        </div>
                    </div>
                </div>
                <div class="reward_wrap">
                    <h2>리워드 선택</h2>
                    <ul class="reward_list">
                    	<li v-if="type==1" class="open_reward">오픈 예정입니다 ☺️</li>
                        <li v-for="reward in reward_list" v-else>
                            <a :href="'../reward/order.do?rno='+reward.rno">
                                <div class="price_account">
                                    <p class="price">{{reward.fm_price}}원</p>
                                    <span class="account">현재 {{reward.amount}}개 남음!</span>
                                </div>
                                <p class="re_title">{{reward.name}}</p>
                                <pre>{{reward.description}}</pre>
                                <dl>
                                    <dt>배송비</dt>
                                    <dd>{{reward.fm_del}}</dd>
                                </dl>
                                <dl>
                                    <dt>발송 시작일</dt>
                                    <dd>{{reward.del_start}}</dd>
                                </dl>
                                <dl>
                                    <dt>제한 수량</dt>
                                    <dd>{{reward.fm_limit}}개</dd>
                                </dl>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </section>
    </div>
    <script>
    	let funding_detail=Vue.createApp({
    		data(){
    			return{
    				fno:${fno},
    				sessionId:'${sessionId}',
    				type:'${type}',
    				funding_vo:{},
    				img_list:[],
    				reward_list:[],
    				isWish:false,
    				wish_count:0
    			}
    		},
    		mounted(){
    			this.dataRecv()
    		},
    		methods:{
    			dataRecv(){
    				axios.get('../funding/funding_detail_vue.do',{
        				params:{
        					fno:this.fno,
        					cate:1
        				}
        			}).then(response=>{
        				this.funding_vo=response.data.funding_vo
        				this.img_list=response.data.img_list
        				this.reward_list=response.data.reward_list
        				this.wish_count=response.data.wish_count
        				if(this.wish_count==0){
        					this.isWish=false
        				}else{
        					this.isWish=true
        				}
        			}).catch(error=>{
        				console.log(error.response)
        			})
    			},
    			wishUpdate(fno){
    				if(this.sessionId==''){
       					alert("로그인 후 이용해주세요")
       				}else{
    	   				axios.get('../wish/update.do',{
    	   					params:{
    	   						fno:fno,
    	   						cate:1
    	   					}
    	   				}).then(response=>{
    	   					if(response.data==='ok'){
    	   						this.isWish=true
								this.dataRecv()
    	   					}else{
    	   						console.log(response.data)
    	   					}
    	   				}).catch(error=>{
    	   					console.log(error.response)
    	   				})   					
       				}
    			},
    			wishDelete(fno){
       				axios.get('../wish/delete.do',{
       					params:{
       						fno:fno,
	   						cate:1
       					}
       				}).then(response=>{
       					if(response.data=="ok"){
       						this.isWish=false
       						this.dataRecv()
       					}else{
       						console.log(response.data)	
       					}
       				}).catch(error=>{
       					console.log(error.response)
       				})
    			}
    		}
    	}).mount('#funding_detail')
    </script>
</body>
</html>