<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<head>
<link rel="stylesheet" href="../css/funding_detail.css">
</head>
<body>
	<div id="funding_detail">
        <ul class="detail_tab">
            <li><a :href="'../funding/detail_before.do?fno='+fno+'&type='+this.type">상세설명</a></li>
            <li><a :href="'../funding/detail_notice.do?fno='+fno+'&type='+this.type" class="active">새소식</a></li>
            <li><a :href="'../funding/detail_community.do?fno='+fno+'&type='+this.type">커뮤니티</a></li>
        </ul>
        <section class="container">
            <div class="left notice">
            	<h2>새소식 <span>{{count}}</span></h2>
            	<ul class="notice_list">
            		<li class="notice_li" v-for="notice in notice_list">
            			<a :href="'../funding/detail_notice_detail.do?fno='+fno+'&dnno='+notice.dnno">
            				<span class="cate">{{notice.cate}}</span>
            				<p class="notice_title">{{notice.title}}</p>
            				<span class="date">{{notice.dbday}}</span>
            			</a>
            		</li>
            	</ul>
            	<ul class="pagination">
	                <li v-if="startpage>1"><a @click="prev()"><i class="fa-solid fa-angles-left"></i></a></li>
	                <li v-for="i in range(startpage,endpage)" :class="i===curpage?'active':''"><a @click="pageChange(i)">{{i}}</a></li>
	                <li v-if="endpage<totalpage"><a @click="next()"><i class="fa-solid fa-angles-right"></i></a></li>
	            </ul>
            </div>
            <div class="right">
                <jsp:include page="funding_detail_right.jsp"></jsp:include>
            </div>
        </section>
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
    				notice_list:[],
    				curpage:1,
    				totalpage:0,
    				startpage:0,
    				endpage:0,
    				count:0
    			}
    		},
    		mounted(){
    			this.noticeRecv()
    			this.dataRecv()
    			$('.reward_click').click(function(e){
    				if(this.sessionId==''){
    					e.prventDefault()
       					alert("로그인 후 이용해주세요")
       				}
    			})
    		},
    		methods:{
    			noticeRecv(){
    				axios.get('../funding/notice_list_vue.do',{
    					params:{
    						fno:this.fno,
    						page:this.curpage
    					}
    				}).then(response=>{
    					this.notice_list=response.data.list
    					this.curpage=response.data.curpage
    					this.totalpage=response.data.totalpage
    					this.startpage=response.data.startpage
    					this.endpage=response.data.endpage
    					this.count=response.data.list.length
    				}).catch(error=>{
    					console.log(error.response)
    				})
    			},
    			range(start,end){
       				let arr=[]
       				let length=end-start
       				for(let i=0;i<=length;i++){
       					arr[i]=start
       					start++
       				}
       				return arr
       			},
       			prev(){
       				this.curpage=this.startpage-1
       				this.dataRecv()
       			},
       			next(){
       				this.curpage=this.endpage+1
       				this.dataRecv()
       			},
       			pageChange(page){
       				this.curpage=page
       				this.dataRecv()
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