<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/funding_detail.css">
<style type="text/css">
#funding_detail > section .right .thumb{
    width:100%;
    object-fit: cover;
    margin-bottom:50px;
}
.thumbList li {
	display: inline;
	height: 65px;
}
.thumbList li img{
	width: 60px;
	height: 60px;
	object-fit: cover;
	margin-right: 5px;
}
.thumb {
    transition: opacity 0.5s ease; /* 부드러운 전환 효과 */
    opacity: 1; /* 초기 불투명도 */
}

.thumb.fade-out {
    opacity: 0; /* 불투명도를 0으로 설정 */
}
#category a:hover{
	color: #999;
}
.space:hover{
	cursor: default;
}
#goodsInfo th{
	text-align: left;
	height: 35px;
}
#goodsInfo {
	margin-top: 20px;
}
#goodsInfo td{
	padding-left: 20px;
}
.goodsOption{
    height:80px;
}
.imgMini:hover{
	border: 2px solid;
}
p:hover,h1:hover,h3:hover {
	cursor: default;
}
#buyBtn:hover,#cartBtn:hover{
	filter: brightness(0.9);
}
</style>
<script type="text/javascript">

$(function(){
	let readmore=$('.readmore');
	readmore.click(function(){
	    if(!readmore.hasClass('active')){
	        $(this).siblings('.imgs').css({
	            height:'auto',
	            overflow:'auto'
	        })
	        $(this).html('상세내용 접기 <i class="fa-solid fa-chevron-up"></i>')
	        $(this).css({
	            boxShadow:'none'
	        })
	        readmore.addClass('active');
	    }else{
	        $(this).siblings('.imgs').css({
	            height:'2000px',
	            overflow:'hidden'
	        })
	        $(this).html('상세내용 더보기 <i class="fa-solid fa-chevron-down"></i>')
	        $(this).css({
	            boxShadow:'0 -30px 20px#fff'
	        })
	        readmore.removeClass('active')
	    }
	})
	
})
function imgChange(){
	let img = $(this).attr("src");
	let thumbNail = document.querySelector(".thumb");
	
	 thumbNail.classList.add("fade-out");
	
	 setTimeout(() => {
	        thumbNail.src = img; // src 변경
	        thumbNail.classList.remove("fade-out"); // 불투명도 원래대로 복원
	 }, 100); // 0.5초 후에 src를 변경
}
function goSubmit() {
    $("#buyForm").submit();
}
</script>
</head>
<body>
	<div id="funding_detail">
        <section class="container" style="display:block;">
            <div style="margin-top:20px;margin-bottom: 20px;" id="category">
              <a href="../main/main.do">Home</a><span class="space">&nbsp;&nbsp;&gt;&nbsp;&nbsp;</span>
              <a :href="'../goods/list.do?cate='+vo.cate1+'&cateInfo=1'">{{vo.cate1 }}</a><span class="space">&nbsp;&nbsp;&gt;&nbsp;&nbsp;</span>
              <a :href="'../goods/list.do?cate='+vo.cate2+'&cateInfo=2'">{{vo.cate2 }}</a><span class="space">&nbsp;&nbsp;&gt;&nbsp;&nbsp;</span>
              <a :href="'../goods/list.do?cate='+vo.cate3+'&cateInfo=3'">{{vo.cate3 }}</a>  
	          <span class="space" v-if="vo.cate4!=null">&nbsp;&nbsp;&gt;&nbsp;&nbsp;</span>
	          <span class="space" v-if="vo.cate4!=null">{{vo.cate4 }}</span>
            </div>
            <form id="butForm" method="post" action="../goods/orderDic.do">
            
            <div class="right" style="display: flex; width: 100%">
               	<div style="width: 55%">
               		<img :src="thumb" alt="" class="thumb" style="margin-bottom: 0px;height: 500px;object-fit: cover;">
				</div>
				<div style="width: 3%"></div>
                <div class="content" style="width: 42%; margin-bottom: 0px;">
                	<div class="top">
	                    <p class="cate">{{vo.cate3 }}</p>
	                    <button class="share"><i class="fa-solid fa-share-nodes"></i>공유</button>
                	</div>
                	<p class="p_admin" style="margin-bottom: 5px">{{vo.brand }}</p>
                    <p class="title">{{vo.title }}</p>
                    <!-- <p class="desc">세계적인 품질 ! 이태리 스웨이드로 완성한 합리적인 럭셔리 100만원짜리 퀄리티를 합리적인 가격대에 경험해보세요! 8억 구두장인 메이커 마리오미나르디가 컴포트 로퍼로 돌아왔습니다.</p> -->
                    
                    <div class="num_icon">
                        <div class="nums">
                            <table style="width: 100%" id="goodsInfo">
                            	<tr>
                            	  <th>
                            	    <P>판매가</P>
                            	  </th>
                            	  <td>
                            	    <P>{{vo.price }}</P>
                            	  </td>
                            	</tr>
                            	<tr>
                            	  <th>
                            	   <p>할인판매가</p>
                            	  </th>
                            	  <td>
                            	    <P>{{vo.realprice }}&nbsp;[{{vo.discount }}]</P>
                            	  </td>
                            	</tr>
                            	<tr>
                            	  <th>
                            	    <p>배달구분</p>
                            	  </th>
                            	  <td>
                            	    <P>{{vo.delivery }}</P>
                            	  </td>
                            	</tr>
                            	<tr>
                            	  <th>
                            	    <p>주문수량</p>
                            	  </th>
                            	  <td>
                            	    <input type="number" style="border: 1px solid #f1f1f1; width: 80px;" min="1" :max="max" v-model="account" name="account">
                            	  </td>
                            	</tr>
                            </table>
                        </div>
                        <div class="icons">
                            <button><i class="fa-regular fa-heart"></i>720</button>
                            <button><i class="fa-regular fa-handshake"></i></i>46</button>
                        </div>
                    </div>
                    
					 
                        <h3 style="margin-bottom: 5px;" v-if="option!='default'">상품옵션</h3>
	                    <div class="goodsOption" v-if="option!='default'">
	                      <select name="optionSelect" v-model="option" style="display: block;" @change="changeSelect()">
	                            <option v-for="opt in optionList" :value="opt.ops" selected>
	                            {{opt.ops}}
	                            </option> 
	                     </select>
	                     
	                    </div>
					   
                    
                      <div style="height: 100px;" v-if="option=='default'"></div>

                    <div style="display:flex;justify-content: center;gap:10px;" >
                    	<input type="hidden" name="fg_no" :value="fg_no">
                    	<div><button style="margin:10px 0px;padding: 15px 80px;background-color: #d50c0c;color: white;" id="buyBtn" onclick="goSubmit()">바로구매</button></div>
                    	<div><input type="button" value="장바구니" style="margin:10px 0px;padding: 15px 80px;border: 1px solid #d50c0c;color: #d50c0c;" id="cartBtn" @click="cartBuy()"></div>
                    </div>
                </div>
            </div>
            </form>
            <div style="height: 5px"></div>
            <div style="width: 100%;display:grid; grid-template-column: 1fr 1fr">
              <div>
              	<ul class="thumbList" style="height: 65px;">
              	  <li v-for="imgs in imgList">
              	    <img alt="" :src="imgs" class="imgMini" onmouseover="imgChange.call(this)">
              	  </li>
              	</ul>
              </div>
              <div></div>
            </div>
            <div class="left">
				<h2>상세설명</h2>
                <div class="img_scroll" style="width: 100%">
                    <div class="imgs">
                        <img v-for="detail in detailList" :src="detail" alt="" >
                    </div>
                    <button class="readmore">상세내용 더보기 <i class="fa-solid fa-chevron-down"></i></button>
                </div>
            </div>
        </section>
    </div>
    <script>
      let detail=Vue.createApp({
    	  data(){
    		  return{
    			  fg_no:'${fg_no}',
    			  account:1,
    			  optionList:[],
    			  imgList:[],
    			  detailList:[],
    			  vo:{},
    			  option:'',
    			  thumb:'',
    			  max:1,
    			  sessionId:'${sessionScope.userId}'
    		  }
    	  },
    	  mounted(){
    		 this.dataRecv()
    		 console.log(this.fg_no)
    	  },
    	  methods:{
    		  dataRecv(){
    			  axios.get('../goods/detail_vue.do',{
    				  params:{
    					  fg_no:this.fg_no
    				  }
    			  }).then(response=>{
    				  console.log(response)
    				  this.fg_no=response.data.fg_no
    				  this.vo=response.data.vo
    				  this.optionList=response.data.gvo
    				  this.imgList=response.data.imgs
    				  this.detailList=response.data.detail
    				  this.thumb=response.data.thumb
    				  this.option=response.data.ops
    				  this.max=this.optionList[0].ea
    			  })
    		  },
    		  cartBuy(){
    			  if(this.sessionId==''){
     					alert("로그인 후 이용해주세요")
     					
     			  }else{
    			  
	    			  axios.post('../goods/cart_insert_vue.do',null,{
	    				  params:{
	    					  fg_no:this.fg_no,
	    					  ea:this.account,
	    					  price:this.vo.realprice,
	    					  ops:this.option
	    				  }
	    			  }).then(response=>{
	    				  console.log(response)
	    				  if(response.data==="ok"){
	    					alert("장바구니로 이동합니다")
	    				  	location.href="../goods/cart.do"
	    				  }else{
	    					  alert("장바구니담기에 실패했습니다...")
	    				  }
	    			  })
     			  }
    		  },
    		  changeSelect(){

    			  for(let i=0;i<this.optionList.length;i++){
    				  if(this.optionList[i].ops===this.option){
    					  this.max=this.optionList[i].ea
    					  break;
    				  }
    			  }
    			  
    		  }
    	  }
      }).mount('#funding_detail')
    </script>
</body>
</html>