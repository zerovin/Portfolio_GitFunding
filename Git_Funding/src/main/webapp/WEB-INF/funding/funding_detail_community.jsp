<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<head>
<link rel="stylesheet" href="../css/funding_detail.css">
</head>
<body>
	<div id="funding_detail">
        <ul class="detail_tab">
            <li><a :href="'../funding/detail_before.do?fno='+fno+'&type='+this.type">상세설명</a></li>
            <li><a :href="'../funding/detail_notice.do?fno='+fno+'&type='+this.type">새소식</a></li>
            <li><a :href="'../funding/detail_community.do?fno='+fno+'&type='+this.type" class="active">커뮤니티</a></li>
        </ul>
        <section class="container">
            <div class="left community">
           		<div class="top">
	            	<h2>커뮤니티 <span>4</span></h2>
	            	<div>
		            	<button @click="openList()"><i class="fa-solid fa-pencil"></i> 글쓰기 <i class="fa-solid fa-chevron-down"></i></button>
		            	<ul class="write_list">
		            		<li @click="commWrite()">응원·의견·리뷰</li>
		            		<li @click="backingWrite()">지지서명</li>
		            	</ul>
	            	</div>
           		</div>
            	<h3>응원·의견·리뷰<span>21</span></h3>
            	<ul class="comm_list">
            		<li>
            			<div class="member_info">
            				<div class="info">
            					<img src="../images/profile.png" alt="">
            					<div class="text">
            						<p class="nick">닉네임</p>
            						<p class="date">2024.10.10</p>
            					</div>
            				</div>
            				<div class="follow_edit">
            					<button><i class="fa-solid fa-plus"></i> 팔로우</button>
            					<button><i class="fa-regular fa-pen-to-square"></i> 수정</button>
            				</div>
            			</div>
            			<div class="content_box">
            				<span class="cate">응원</span>
            				<pre>한번쯤 미니어처를 만들어보고싶었는데, 우연히 발견하여 펀딩하였습니다..! 과연 투박한 손으로 완성할수있을지 기대가됩니다...!! 잘 완성되어서 앞으로도 다른 미니어처도 만들수있는 계기가된다면 너무너무 좋겠네요</pre>
            			</div>
            			<div class="comment">
            				<button class="show"><i class="fa-regular fa-comment-dots"></i> 댓글</button>
            				<div class="wrap">
	            				<div class="form">
	            					<img src="../images/profile.png" alt="">
	            					<input type="text" placeholder="댓글을 작성해주세요">
	            					<button>입력</button>
	            				</div>
	            				<ul class="comment_list">
	            					<li>
	            						<img src="../images/profile.png" alt="">
	            						<div class="comm_content">
	            							<div>
		            							<p>제이닷 <span>2024.10.11</span></p>
		            							<button class="edit">수정</button>
	            							</div>
	            							<pre>선택하신 제품에 따라 난이도는 상이하지만 잘 하실 수 있을거에요!! 참여해주셔서 감사합니다^^^^^^^^^^^^^^^^^^^^^^^^^^^</pre>
	            						</div>
	            					</li>
	            				</ul>
            				</div>
            			</div>
            		</li>
            	</ul>
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
                            <button class="backingBtn" @click="backingWrite()"><i class="fa-regular fa-handshake"></i>{{funding_vo.fm_backing}}</button>
                        </div>
                    </div>
                </div>
                <div class="reward_wrap">
                    <h2>리워드 선택</h2>
                    <ul class="reward_list">
                    	<li v-if="type==1" class="open_reward">오픈 예정입니다 ☺️</li>
                        <li v-for="reward in reward_list" v-else>
                            <button @click="rewardClick(fno, reward.rno)">
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
                            </button>
                        </li>
                    </ul>
                </div>
            </div>
        </section>
        <aside id="communityWindow" ref="communityWindow">
        	<h2>응원·의견·리뷰 📣</h2>
        	<p>응원·의견·리뷰를 자유롭게 작성해주세요!</p>
       		<div class="radio_box">
	        	<div>
	        		<input type="radio" name="cate" id="cheer" value="응원" v-model="comm_cate">
	        		<label for="cheer">응원</label>
	        	</div>
	        	<div>
	        		<input type="radio" name="cate" id="opinion" value="의견" v-model="comm_cate">
	        		<label for="opinion">의견</label>
	        	</div>
	        	<div>
	        		<input type="radio" name="cate" id="review" value="리뷰" v-model="comm_cate">
	        		<label for="review">리뷰</label>
	        	</div>
        	</div>
        	<textarea placeholder="소통의 글을 남겨주세요 :)" v-model="commContent"></textarea>
        	<button class="insert" @click="commInsert(funding_vo.fno)">등록하기</button>
        	<span class="close" @click="commInsertClose"><i class="fa-solid fa-xmark"></i></span>
        </aside>
        <aside id="backingWindow" ref="backingWindow">
        	<h2>친구에게 소개해 보세요 📣</h2>
        	<p>지지서명으로 프로젝트 관리자에게 힘이 되어주세요!</p>
        	<textarea placeholder="응원의 글을 남겨주세요 :)" v-model="backingContent"></textarea>
        	<button class="insert" @click="backingInsert(funding_vo.fno)"><i class="fa-regular fa-handshake"></i> 지지서명하기</button>
        	<button class="close" @click="backingClose"><i class="fa-solid fa-xmark"></i></button>
        </aside>
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
    				wish_count:0,
    				backingContent:'',
    				isOpen:false,
    				comm_cate:'',
    				commContent:'',
    			}
    		},
    		mounted(){
    			this.dataRecv()
    			$('.reward_click').click(function(e){
    				if(this.sessionId==''){
    					e.prventDefault()
       					alert("로그인 후 이용해주세요")
       				}
    			})
    		},
    		methods:{
    			openList(){
    				if(this.isOpen==false){
    					$('.write_list').show();
    					this.isOpen=true
    				}else{
    					$('.write_list').hide();
    					this.isOpen=false
    				}
    			},
    			commWrite(){
    				if(this.sessionId==''){
       					alert("로그인 후 이용해주세요")
       				}else{
	    				$('#communityWindow').show()
       				}
    			},
    			commInsertClose(){
    				$('#communityWindow').hide()
    				$('#communityWindow textarea').val('')
    			},
    			commInsert(fno){
    				axios.post('../funding/community_insert.do',null,{
    					params:{
    						fno:fno,
    						cate:this.comm_cate,
    						content:this.commContent
    					}
    				}).then(response=>{
    					if(response.data==="ok"){
    						//this.commDataRecv()
    						this.commInsertClose()
    						this.openList()
    					}else{
    						console.log(response.data)
    					}
    				}).catch(error=>{
    					console.log(error)
    				})
    			},
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
    			},
    			backingWrite(){
    				if(this.sessionId==''){
       					alert("로그인 후 이용해주세요")
       				}else{
	    				$('#backingWindow').show()
       				}
    			},
    			backingClose(){
    				$('#backingWindow').hide()
    				$('#backingWindow textarea').val('')
    			},
    			backingInsert(fno){
    				axios.post('../funding/backing_insert.do',null,{
    					params:{
    						fno:fno,
    						content:this.backingContent
    					}
    				}).then(response=>{
    					if(response.data==="ok"){
    						location.href="../gitsta/main.do"
    					}else{
    						console.log(response.data)
    					}
    				}).catch(error=>{
    					console.log(error)
    				})
    			},
    			rewardClick(fno, rno){
    				if(this.sessionId==''){
       					alert("로그인 후 이용해주세요")
       				}else{
       					location.href="../reward/reward_buy.do?fno="+fno+"&rno="+rno
       				}	
    			}
    		}
    	}).mount('#funding_detail')
    </script>
</body>