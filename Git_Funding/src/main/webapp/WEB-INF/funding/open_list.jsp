<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<head>
<link rel="stylesheet" href="../css/funding_list.css">
</head>
<body>
	<div id="funding_list" class="container">
		<div class="category">
	     <ul class="cate_list">
	         <li v-for="cate in category">
	             <a @click="cateChange(cate.second)">
	                 <p>{{cate.first}}️</p>
	                 <p>{{cate.second}}</p>
	             </a>
	         </li>
	     </ul>
	     <button class="control prev">이전</button>
	     <button class="control next">다음</button>
	 </div>
        <div class="list_wrap">
            <ul class="list">
                <li v-for="vo in list">
                    <a :href="'../funding/funding_detail.do?fno='+vo.fno+'&type=1'" class="f_list">
                        <img :src="vo.thumb" alt="vo.title">
                        <p class="percent">{{vo.alert}}명이 기다려요!</p>
                        <p class="title">{{vo.title}}</p>
                        <p class="p_admin">{{vo.p_admin}}</p>
                    </a>
                    <button class="open_alert" @click="alertUpdate(vo.fno)" v-if="vo.isAlert==0">🔔 <span>{{vo.startday}}</span> 오픈 알림 신청</button>
                    <button class="cancel_alert" @click="alertDelete(vo.fno)" v-else>🔔 알림 신청 완료</button>
                </li>
            </ul>
            <ul class="pagination">
                <li v-if="startpage>1"><a @click="prev()"><i class="fa-solid fa-angles-left"></i></a></li>
                <li v-for="i in range(startpage,endpage)" :class="i===curpage?'active':''"><a @click="pageChange(i)">{{i}}</a></li>
                <li v-if="endpage>totalpage"><a @click="next()"><i class="fa-solid fa-angles-right"></i></a></li>
            </ul>
        </div>
        <aside class="alert_msg">
        	<p v-if="alertOk==true">⏰ 알림 신청을 <span>완료</span>했어요 !</p>
       		<p v-if="alertOk==false">⏰ 알림 신청을 <span>취소</span>했어요 !</p>
        </aside>
    </div>
    <script>
   	let open_list=Vue.createApp({
   		data(){
   			return{
   				category:[{first:"✅️",second:'전체'},{first:"🖥",second:"테크·가전"},{first:"👗",second:"패션"},{first:"💄",second:"뷰티"},{first:"🏠",second:"홈·리빙"},
   					{first:"⚽",second:"스포츠·아웃도어"},{first:"🍴",second:"푸드"},{first:"📚",second:"도서·전자책"},{first:"✏️",second:"클래스"},
   					{first:"🎀",second:"디자인"},{first:"🐶",second:"반려동물"},{first:"🎨",second:"아트"},{first:"🎁",second:"캐릭터·굿즈"},
   					{first:"🎬",second:"영화·음악"},{first:"👶🏻",second:"키즈"},{first:"🕹",second:"게임"},{first:"📰",second:"만화·웹툰"},
   					{first:"📷",second:"사진"},{first:"🗺",second:"여행"},{first:"🚗",second:"자동차"},{first:"🎫",second:"멤버십"},
   					{first:"👫",second:"소셜"}],
   				list:[],
   				curpage:1,
   				totalpage:0,
   				startpage:0,
   				endpage:0,
   				sessionId:'',
   				alertOk:true
   			}	
   		},
   		mounted(){
   			this.dataRecv()	
   		},
   		methods:{
   			alertDelete(fno){
   				axios.get('../funding/alert_delete.do',{
   					params:{
   						fno:fno
   					}
   				}).then(response=>{
   					if(response.data=="ok"){
   						this.alertOk=false
   						this.dataRecv()
   						$('aside.alert_msg').addClass('show')
 						setTimeout(function(){
 							$('aside.alert_msg').removeClass('show')
 						},2000)
   					}
   				}).catch(error=>{
   					console.log(error.response)
   				})
   			},
   			alertUpdate(fno){
   				if(this.sessionId==null){
   					alert("로그인 후 이용해주세요")
   				}else{
	   				axios.get('../funding/alert_update.do',{
	   					params:{
	   						fno:fno
	   					}
	   				}).then(response=>{
	   					if(response.data==='ok'){
	   						this.alertOk=true
	   						this.dataRecv()
	   						$('aside.alert_msg').addClass('show')
	   						setTimeout(function(){
	 							$('aside.alert_msg').removeClass('show')
	 						},2000)
	   					}else{
	   						console.log(response.data)
	   					}
	   				}).catch(error=>{
	   					console.log(error.response)
	   				})   					
   				}
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
   				axios.get('../funding/open_list_vue.do',{
   					params:{
   						page:this.curpage
   					}
   				}).then(response=>{
   					console.log(response.data)
   					this.list=response.data.list
   					this.curpage=response.data.curpage
   					this.totalpage=response.data.totalpage
   					this.startpage=response.data.startpage
   					this.endpage=response.data.endpage
   					this.sessionId=response.data.sessionId
   				}).catch(error=>{
   					console.log(error.response)
   				})
   			}
   		}
   	}).mount('#funding_list')
    </script>
</body>
</html>