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
	            	<h2>커뮤니티</h2>
	            	<div>
		            	<button @click="openList()"><i class="fa-solid fa-pencil"></i> 글쓰기 <i class="fa-solid fa-chevron-down"></i></button>
		            	<ul class="write_list">
		            		<li @click="commWrite()">응원·의견·리뷰</li>
		            		<li @click="backingWrite()">지지서명</li>
		            	</ul>
	            	</div>
           		</div>
            	<h3>응원·의견·리뷰<span>{{comm_list.length}}</span></h3>
            	<ul class="comm_list">
            		<li v-for="comm in comm_list">
            			<div v-if="comm.group_tab===0">
	            			<div class="member_info">
	            				<div class="info">
	            					<img :src="comm.mvo.profile" alt="comm.mvo.nickname">
	            					<div class="text">
	            						<p class="nick">{{comm.mvo.nickname}}</p>
	            						<p class="date">{{comm.dbday}}</p>
	            					</div>
	            				</div>
	            				<div class="follow_edit">
	            					<button><i class="fa-solid fa-plus"></i> 팔로우</button>
	            					<button v-if="sessionId==comm.userId" @click="updateOpen(comm.dcno)"><i class="fa-regular fa-pen-to-square"></i> 수정</button>
	            					<button v-if="sessionId==comm.userId" @click="deleteOpen(comm.dcno)"><i class="fa-solid fa-trash"></i> 삭제</button>
	            				</div>
	            			</div>
	            			<div class="content_box">
	            				<span class="cate cheer" v-if="comm.cate=='응원'">{{comm.cate}}</span>
	            				<span class="cate opinion" v-if="comm.cate=='의견'">{{comm.cate}}</span>
	            				<span class="cate review" v-if="comm.cate=='리뷰'">{{comm.cate}}</span>
	            				<pre>{{comm.content}}</pre>
	            			</div>
	            			<div class="comment">
	            				<button class="show" @click="commentOpen(comm.group_id)"><i class="fa-regular fa-comment-dots"></i> 댓글</button>
	            				<div class="wrap" :id="'commentWrap'+comm.group_id">
		            				<div class="form">
		            					<img src="../images/profile.png" alt="">
		            					<input type="text" placeholder="댓글을 작성해주세요" :id="'reply'+comm.dcno" @keydown.enter="replyInsert(comm.dcno)">
		            					<button @click="replyInsert(comm.dcno)">입력</button>
		            				</div>
		            			</div>
		            		</div>
	            		</div>
           				<ul class="comment_list" :id="'commentList'+comm.group_id">
           					<li v-if="comm.group_tab===1">
           						<img :src="comm.mvo.profile" alt="comm.mvo.nickname">
           						<div class="comm_content">
           							<div>
            							<p>{{comm.mvo.nickname}} <span>{{comm.dbday}}</span></p>
            							<button class="edit">수정</button>
           							</div>
           							<pre>{{comm.content}}</pre>
           						</div>
           					</li>
           				</ul>
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
        	<textarea placeholder="소통의 글을 남겨주세요 :)" ref="commContent" v-model="commContent"></textarea>
        	<button class="insert" @click="commInsert(funding_vo.fno)">등록하기</button>
        	<span class="close" @click="commInsertClose"><i class="fa-solid fa-xmark"></i></span>
        </aside>
        <aside id="updateWindow" ref="updateWindow">
        	<h2>응원·의견·리뷰 📣</h2>
        	<p>응원·의견·리뷰를 자유롭게 수정해주세요!</p>
       		<div class="radio_box">
	        	<div>
	        		<input type="radio" name="cate" id="cheer" value="응원" v-model="update_cate">
	        		<label for="cheer">응원</label>
	        	</div>
	        	<div>
	        		<input type="radio" name="cate" id="opinion" value="의견" v-model="update_cate">
	        		<label for="opinion">의견</label>
	        	</div>
	        	<div>
	        		<input type="radio" name="cate" id="review" value="리뷰" v-model="update_cate">
	        		<label for="review">리뷰</label>
	        	</div>
        	</div>
        	<textarea ref="updateContent" v-model="updateContent">{{updateData.content}}</textarea>
        	<button class="insert" @click="commUpdate()">수정하기</button>
        	<span class="close" @click="updateClose"><i class="fa-solid fa-xmark"></i></span>
        </aside>
        <aside id="backingWindow" ref="backingWindow">
        	<h2>친구에게 소개해 보세요 📣</h2>
        	<p>지지서명으로 프로젝트 관리자에게 힘이 되어주세요!</p>
        	<textarea placeholder="응원의 글을 남겨주세요 :)" v-model="backingContent"></textarea>
        	<button class="insert" @click="backingInsert(funding_vo.fno)"><i class="fa-regular fa-handshake"></i> 지지서명하기</button>
        	<button class="close" @click="backingClose"><i class="fa-solid fa-xmark"></i></button>
        </aside>
        <aside id="commDeleteWindow">
        	<p>삭제하시겠습니까?</p>
        	<div class="delete_btns">
        		<button class="delete" @click="commDelete()">삭제</button>
        		<button class="cancel" @click="deleteClose()">취소</button>
        	</div>
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
    				comm_list:[],
    				comm_cate:'',
    				commContent:'',
    				isCommentOpen:false,
    				updateData:{},
    				update_dcno:0,
    				update_cate:'',
    				updateContent:'',
    				delete_dcno:0
    			}
    		},
    		mounted(){
    			this.commListRecv()
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
    			commListRecv(){
    				axios.get('../funding/comm_list_vue.do',{
    					params:{
    						fno:this.fno
    					}	
    				}).then(response=>{
    					this.comm_list=response.data
    				}).catch(error=>{
    					console.log(error.response)
    				})
    			},
    			commWrite(){
    				if(this.sessionId==''){
       					alert("로그인 후 이용해주세요")
       				}else{
	    				$('#communityWindow').show()
	    				$('body').css({overflowY:'hidden'})
       				}
    			},
    			commInsertClose(){
    				$('#communityWindow').hide()
    				$('#communityWindow textarea').val('')
    				$('body').css({overflowY:'auto'})
    				this.isUpdate=false
    			},
    			commInsert(fno){
    				if(this.comm_cate==='' || this.commContent===''){
    					this.$refs.commContent.focus()
    				}else{
	    				axios.post('../funding/community_insert.do',null,{
	    					params:{
	    						fno:fno,
	    						cate:this.comm_cate,
	    						content:this.commContent
	    					}
	    				}).then(response=>{
	    					if(response.data==="ok"){
	    						this.commListRecv()
	    						this.commInsertClose()
	    						this.openList()
	    					}else{
	    						console.log(response.data)
	    					}
	    				}).catch(error=>{
	    					console.log(error)
	    				})
    				}
    			},
    			updateOpen(dcno){
	    			$('#updateWindow').show()
	    			$('body').css({overflowY:'hidden'})
	    			this.update_dcno=dcno
    				axios.get('../funding/comm_update_data.do',{
    					params:{
    						dcno:dcno
    					}
    				}).then(response=>{
    					this.update_cate=response.data.cate
    					this.updateContent=response.data.content
    				}).catch(error=>{
    					console.log(error.response)
    				})
    			},
    			commUpdate(){
    				if(this.update_cate==='' || this.updateContent===''){
    					this.$refs.updateContent.focus()
    				}else{
    					axios.post('../funding/comm_update.do',null,{
    						params:{
    							dcno:this.update_dcno,
    							cate:this.update_cate,
    							content:this.updateContent
    						}
    					}).then(response=>{
    						if(response.data=='ok'){
    							this.commListRecv()
    							this.updateClose()
    							this.openList()
    						}else{
    							console.log(response.data)
    						}
    					}).catch(error=>{
    						console.log(error.response)
    					})
    				}
    			},
    			updateClose(){
    				$('#updateWindow').hide()
	    			$('body').css({overflowY:'auto'})
	    			this.$refs.updateContent.val('')
    			},
    			deleteOpen(dcno){
    				this.delete_dcno=dcno
    				$('#commDeleteWindow').show()
    				$('body').css({overflowY:'hidden'})
    			},
    			commDelete(){
    				axios.get('../funding/comm_delete.do',{
    					params:{
    						dcno:this.delete_dcno
    					}
    				}).then(response=>{
    					if(response.data==='ok'){
    						this.commListRecv()
    						this.deleteClose()
    						this.openList()
    					}else{
    						console.log(response.data)
    					}
    				}).catch(error=>{
    					console.log(error.response)
    				})
    			},
    			deleteClose(){
    				$('#commDeleteWindow').hide()
    				$('body').css({overflowY:'auto'})
    			},
    			commentOpen(group_id){
    				if(this.isCommentOpen==false){
	    				$('#commentWrap'+group_id).find('input').val('')
    					$('.comment .wrap').hide()
	    				$('#commentWrap'+group_id).show()
	    				$('#commentList'+group_id).show()
	    				this.isCommentOpen=true
    				}else{
    					$('#commentWrap'+group_id).hide()
    					$('#commentList'+group_id).hide()
    					this.isCommentOpen=false
    				}
    			},
    			replyInsert(dcno){
    				let content=$('#reply'+dcno).val()
    				if(this.sessionId==''){
    					alert("로그인 후 이용해주세요")
    				}else if(this.content==''){
    					$('#reply'+dcno).focus()
    				}else{
    					axios.post('../funding/reply_insert.do',null,{
    						params:{
    							dcno:dcno,
    							fno:this.fno,
    							content:content
    						}
    					}).then(response=>{
    						console.log(response.data)
    						if(response.data==='ok'){
    							this.commListRecv()
    							$('#commentWrap'+dcno).find('input').val('')
    						}else{
    							console.log(response.data)
    						}
    					}).catch(error=>{
    						console.log(error.response)
    					})
    				}
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