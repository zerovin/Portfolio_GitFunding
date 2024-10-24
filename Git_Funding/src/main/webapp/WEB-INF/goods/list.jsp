<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/funding_list.css">
<style type="text/css">
a{
	cursor: pointer;
}
.faq-tabs {
    display: flex;
    justify-content: center;
    flex-wrap: wrap;
    gap: 15px;
    margin-bottom: 30px;
}
.faq-tabs div {
    background-color: #f1f1f1;
    border: none;
    border-radius: 20px;
    padding: 10px 20px;
    font-size: 16px;
    cursor: pointer;
}
.faq-tabs div.active {
    background-color: #f8c200;
    color: white;
    font-weight: bold;
}
#search{
	width: 550px;
    height: 50px;
    border: 2px solid #F8C200;
    border-radius: 27px;
   
}
#searchBtn{
	width: 24px;
    height: 23px;
    background: url(../images/search.png) no-repeat;
    text-indent: -9999em;
    position: absolute;
    right: 20px;
    top: 50%;
    transform: translateY(-50%);
   
}
</style>
</head>
<body>
  <div class="container" id="funding_list">
	<div class="list_wrap">
			<div class="faq-tabs">
				   <div :class="{active: cate===''}" @click="changeCategory('')">
				   전체
				   </div>
				   <div v-for="category in cate_list" :class="{ active: cate === category }" @click="changeCategory(category)">
				  	{{category}}
				   </div>
			</div>
			<div style="display: flex;justify-content: center;">
				<div style=" position: relative;">
					<label for="search" style="display: none;">검색</label>
		            <input type="search" name="search" id="search" v-model="search" @keydown="handleKeyDown">
		            <button id="searchBtn" @click="searchInfo()">검색</button>
	            </div>
			</div>
            <ul class="list">
                <li v-for="vo in goods_list">
                    <a :href="'../goods/detail.do?fgno='+vo.fg_no" class="f_list">
                        <img :src="vo.img" alt="">
                        <p class="percent"></p>
                        <p class="title">{{vo.title}}</p>
                        <p class="p_admin">{{vo.brand}}</p>
                        <div class="progress">
                            <div class="top">
                            	<p style="text-decoration-line: line-through;color: #899c8f;">{{vo.price}}</p>
                            </div>
                            <div class="top">
                            	<p>{{vo.realprice}}</p><p class="current"><span class="num">[{{vo.discount}}]</span></p>
                            </div>
                        </div>
                    </a>
                </li>
            </ul>
            <ul class="pagination">
                <li>
                   <a class="page-link" @click="prev()">&lt;</a>
                 </li>
                <li :class="i===curpage?'page-item active':'page-item'" v-for="i in range(startpage,endpage)">
                   <a class="page-link" @click="pageChange(i)">{{i}}</a>
                </li>
                <li>
                   <a class="page-link" @click="next()">&gt;</a>
                </li>
            </ul>
    </div>
  </div>
	<script>
		let goods=Vue.createApp({
			data(){
				return{
					search:'',
					goods_list:[],
					cateInfo:'${cateInfo}',
					cate:'${cate}',
					curpage:1,
					totalpage:0,
					startpage:0,
					endpage:0,
					cate_list:['디자인문구',
						 '패션잡화',
						 '토이/취미',
						 '데코/조명',
						 '키친',
						 '가구/수납',
						 '패브릭/생활',
						 '디자인가전',
						 '디지털/핸드폰',
						 'Cat & Dog',
						 '패션의류',
						 '푸드',
						 '주얼리/시계',
						 '캠핑',
						 '뷰티']
				}
			},
			mounted(){
				this.dataRecv()
			},
			methods:{
				 handleKeyDown(event){
					 if (event.key === 'Enter') {
					       this.searchInfo()
					 } 
				 },
				 searchInfo(){
					 this.cateInfo = '4'
					 this.dataRecv()
				 },
				 changeCategory(category) {
						this.curpage=1
		            	this.cate = category
		            	this.cateInfo = 1
		            	this.search = ''
		            	this.dataRecv()
		           
		         },
				 prev(){
					 if(this.startpage>1){
	    			 	this.curpage=this.startpage-1
	    			 	this.dataRecv()
					 }
	    		 },
	    		 next(){
	    			 if(this.endpage<this.totalpage){
	    			 	this.curpage=this.endpage+1
	    			 	this.dataRecv()
	    			 }
	    		 },
	    		 pageChange(page){
	    			 this.curpage=page
	    			 this.dataRecv()
	    		 },
	    		 range(start,end){
	    			 let arr=[]
	    			 let len=end-start
	    			 for(let i=0;i<=len;i++)
	    			 {
	    				 arr[i]=start
	    				 start++;
	    			 }
	    			 return arr
	    		 },
				dataRecv(){
					axios.get("../goods/list_vue.do",{
						params:{
							page:this.curpage,
							cate:this.cate,
							cateInfo:this.cateInfo,
							fd:this.search
						}
					}).then(response=>{
						console.log(response)
						this.goods_list=response.data.list
						this.curpage=response.data.curpage
	    				this.totalpage=response.data.totalpage
	    				this.startpage=response.data.startpage
	    				this.endpage=response.data.endpage
						
					})
				}
			}
		}).mount('.list_wrap')
	</script>
</body>
</html>