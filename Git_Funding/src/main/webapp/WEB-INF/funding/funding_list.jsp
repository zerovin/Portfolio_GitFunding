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
                        <img :src="vo.thumb" alt="">
                        <p class="percent">{{vo.headcount}}명이 참여했어요!</p>
                        <p class="title">{{vo.title}}</p>
                        <p class="p_admin">{{vo.p_admin}}</p>
                        <div class="progress">
                            <div class="top">
                                <p class="current"><span class="num">329%</span>3,290,000원</p>
                                <p class="remain">13일 남음</p>
                            </div>
                            <div class="progress_bar" data-rate="329"></div>
                        </div>
                    </a>
                </li>
            </ul>
            <ul class="pagination">
                <li><a href=""><i class="fa-solid fa-angles-left"></i></a></li>
                <li class="active"><a href="">1</a></li>
                <li><a href="">2</a></li>
                <li><a href="">3</a></li>
                <li><a href="">4</a></li>
                <li><a href="">5</a></li>
                <li><a href="">6</a></li>
                <li><a href="">7</a></li>
                <li><a href="">8</a></li>
                <li><a href="">9</a></li>
                <li><a href="">10</a></li>
                <li><a href=""><i class="fa-solid fa-angles-right"></i></a></li>
            </ul>
        </div>
    </div>
    <script>
    	let funding_list=Vue.createApp({
    		data(){
    			return{
    				list:[],
    				curpage:1,
    				totalpage:0,
    				startpage:0,
    				endpage:0,
    				percent:0,
    				
    			}
    		},
    		mounted(){
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
    	}).mount('#funding_list')
    </script>
</body>
</html>