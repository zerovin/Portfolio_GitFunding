<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<head>
    <link rel="stylesheet" href="../css/funding_list.css">
</head>
<body>
	<div id="funding_list" class="container">
		<jsp:include page="../funding/category.jsp"></jsp:include>
        <div class="list_wrap">
            <ul class="list">
                <li v-for="vo in list">
                    <a href="" class="f_list">
                        <img :src="vo.thumb" alt="vo.title">
                        <p class="percent">{{vo.alert}}명이 기다려요!</p>
                        <p class="title">{{vo.title}}</p>
                        <p class="p_admin">{{vo.p_admin}}</p>
                    </a>
                    <button class="open_alert" @click="alertUpdate(vo.fno)" v-if="!isAlert">🔔 <span>{{vo.startday}}</span> 오픈 알림 신청</button>
                    <button class="cancel_alert" v-else>🔔 알림 신청 완료</button>
                </li>
            </ul>
            <ul class="pagination">
                <li v-if="startpage>1"><a @click="prev()"><i class="fa-solid fa-angles-left"></i></a></li>
                <li v-for="i in range(startpage,endpage)" :class="i===curpage?'active':''"><a @click="pageChange(i)">{{i}}</a></li>
                <li v-if="endpage>totalpage"><a @click="next()"><i class="fa-solid fa-angles-right"></i></a></li>
            </ul>
        </div>
    </div>
    <script>
   	let open_list=Vue.createApp({
   		data(){
   			return{
   				list:[],
   				curpage:1,
   				totalpage:0,
   				startpage:0,
   				endpage:0,
   				isAlert:false
   			}	
   		},
   		mounted(){
   			this.dataRecv()	
   		},
   		methods:{
   			alertUpdate(fno){
   				if(${sessionScope.id==null}){
   					alert("로그인 후 이용해주세요")
   				}else{
	   				axios.get('../funding/alert_update.do',{
	   					params:{
	   						fno:fno
	   					}
	   				}).then(response=>{
	   					if(response.data==='ok'){
	   						isAlert=true
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