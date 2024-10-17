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
                    <a :href="'../funding/funding_detail.do?fno='+vo.fno" class="f_list">
                        <img :src="vo.thumb" alt="">
                        <p class="percent">{{vo.fm_headcount}}명이 참여했어요!</p>
                        <p class="title">{{vo.title}}</p>
                        <p class="p_admin">{{vo.p_admin}}</p>
                        <div class="progress">
                            <div class="top">
                                <p class="current"><span class="num">{{vo.fm_percent}}%</span>{{vo.fm_totalprice}}원</p>
                                <p class="remain">{{vo.dday}}일 남음</p>
                            </div>
                            <div class="progress_bar" :style="'width:'+vo.percent+'%'"></div>
                        </div>
                    </a>
                </li>
            </ul>
            <ul class="pagination">
                <li v-if="startpage>1"><a @click="prev()"><i class="fa-solid fa-angles-left"></i></a></li>
                <li v-for="i in range(startpage,endpage)" :class="i===curpage?'active':''"><a @click="pageChange(i)">{{i}}</a></li>
                <li v-if="endpage<totalpage"><a @click="next()"><i class="fa-solid fa-angles-right"></i></a></li>
            </ul>
        </div>
    </div>
    <script>
   	let funding_list=Vue.createApp({
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
   			}
   		},
   		mounted(){
   			this.dataRecv()
   			
   		},
   		methods:{
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
    			axios.get('../funding/funding_list_vue.do',{
    				params:{
    					page:this.curpage
    				}
    			}).then(response=>{
    				this.list=response.data.list
    				this.curpage=response.data.curpage
    				this.totalpage=response.data.totalpage
    				this.startpage=response.data.startpage
    				this.endpage=response.data.endpage
    			}).catch(error=>{
    				console.log(error.response)		
    			})
   			}
   		}
   	}).mount('#funding_list')
    </script>
</body>
</html>