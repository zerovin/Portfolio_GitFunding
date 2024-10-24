<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<head>
<link rel="stylesheet" href="../css/find.css">
</head>
<body>
	<div id="funding_find" class="container">
		<div class="search"> 
		    <form method="GET" action="../funding/find.do" @submit.prevent="search()">
		        <label for="search">검색</label>
		        <input type="search" name="keyword" id="search" ref="search" v-model="keyword">
		        <button>검색</button>
		    </form>
		    <div class="best_search">
		        <div class="rolling">
		            <ol>
		                <li><a href=""><span>1</span><p>캠핑</p></a></li>
		                <li><a href=""><span>2</span><p>키보드</p></a></li>
		                <li><a href=""><span>3</span><p>가방</p></a></li>
		                <li><a href=""><span>4</span><p>캐리어</p></a></li>
		                <li><a href=""><span>5</span><p>텀블러</p></a></li>
		                <li><a href=""><span>6</span><p>애사비</p></a></li>
		                <li><a href=""><span>7</span><p>텐트</p></a></li>
		                <li><a href=""><span>8</span><p>우산</p></a></li>
		                <li><a href=""><span>9</span><p>백팩</p></a></li>
		                <li><a href=""><span>10</span><p>보조배터리</p></a></li>
		            </ol>
		            <img src="../images/more.png" alt="더 보기" class="search_more">
		        </div>
		        <div class="search_list">
		            <div class="top">
		                <h3>실시간 인기 검색어</h3>
		                <button>닫기</button>
		            </div>
		            <ol>
		                <li><a href=""><span>1</span><p>캠핑</p></a></li>
		                <li><a href=""><span>2</span><p>키보드</p></a></li>
		                <li><a href=""><span>3</span><p>가방</p></a></li>
		                <li><a href=""><span>4</span><p>캐리어</p></a></li>
		                <li><a href=""><span>5</span><p>텀블러</p></a></li>
		                <li><a href=""><span>6</span><p>애사비</p></a></li>
		                <li><a href=""><span>7</span><p>텐트</p></a></li>
		                <li><a href=""><span>8</span><p>우산</p></a></li>
		                <li><a href=""><span>9</span><p>백팩</p></a></li>
		                <li><a href=""><span>10</span><p>보조배터리</p></a></li>
		            </ol>
		        </div>
		    </div>
		</div>
		<div class="list_wrap">
			<h2>키워드 <span>검색결과</span></h2>
		    <ul class="list">
		        <li v-for="vo in find_list">
		            <a :href="'../funding/detail_before.do?fno='+vo._source.fno" class="f_list">
		                <img :src="vo._source.thumb" alt="">
		                <p class="percent">{{vo._source.headcount}}명이 참여했어요!</p>
		                <p class="title">{{vo._source.title}}</p>
		                <p class="p_admin">{{vo._source.p_admin}}</p>
		                <div class="progress">
		                    <div class="top">
		                        <p class="current"><span class="num">{{vo._source.fm_percent}}%</span>{{vo._source.totalprice}}원</p>
		                        <p class="remain">{{vo._source.dday}}일 남음</p>
		                    </div>
		                    <div class="progress_bar" :style="'width:'+vo._source.percent+'%'"></div>
		                </div>
		            </a>
		        </li>
		    </ul>
		    <!-- 
		    <ul class="pagination">
		        <li v-if="startpage>1"><a @click="prev()"><i class="fa-solid fa-angles-left"></i></a></li>
		        <li v-for="i in range(startpage,endpage)" :class="i===curpage?'active':''"><a @click="pageChange(i)">{{i}}</a></li>
		        <li v-if="endpage<totalpage"><a @click="next()"><i class="fa-solid fa-angles-right"></i></a></li>
		    </ul>
		    -->
		</div>
	</div>
	<script>
		let funding_find=Vue.createApp({
			data(){
				return{
					keyword:'${keyword}',
					find_list:[],
					curpage:1,
					totalpage:0,
					startpage:0,
					endpage:0
				}
			},
			mounted(){
				this.search()
			},
			methods:{
				search(){
					if(this.keyword==''){
						this.$refs.search.focus()
					}else{	
		   				axios.get('../funding/find_vue.do',{
		   					params:{
		   						keyword:this.keyword
		   					}
						}).then(response=>{
							console.log(response.data.hits.hits)
							this.find_list=response.data.hits.hits
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
	   			}
			}
		}).mount('#funding_find')
	</script>
</body>