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
}
.thumbList li img{
	width: 60px;
	height: 60px;
	object-fit: cover;
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
</script>
</head>
<body>
	<div id="funding_detail">
        <section class="container" style="display:block;">
            <div class="right" style="display: flex; width: 100%">
               	<div style="width: 55%">
               		<img src="../images/detail_thumb.jpeg" alt="" class="thumb" style="margin-bottom: 0px;">
				</div>
				<div style="width: 3%"></div>
                <div class="content" style="width: 42%; margin-bottom: 0px;">
                	<div class="top">
	                    <p class="cate">패션</p>
	                    <button class="share"><i class="fa-solid fa-share-nodes"></i>공유</button>
                	</div>
                    <p class="title">8억 메이커 야심작 | 이태리 스웨티드로 완성한 합리적인 럭셔리 커포트 로퍼</p>
                    <p class="desc">세계적인 품질 ! 이태리 스웨이드로 완성한 합리적인 럭셔리 100만원짜리 퀄리티를 합리적인 가격대에 경험해보세요! 8억 구두장인 메이커 마리오미나르디가 컴포트 로퍼로 돌아왔습니다.</p>
                    <p class="p_admin">(주)슈즈나인</p>
                    <div class="num_icon">
                        <div class="nums">
                            <div>
                                <p class="big"><span class="num">505</span> % 달성</p>
                                <p class="small">7일 남음</p>
                            </div>
                            <div>
                                <p class="big"><span class="num">2,529,000</span> 원 달성</p>
                                <p class="small">57명 참여</p>
                            </div>
                            <p><span class="num">10.15~10.22</span> 진행</p>
                        </div>
                        <div class="icons">
                            <button><i class="fa-regular fa-heart"></i>720</button>
                            <button><i class="fa-regular fa-handshake"></i></i>46</button>
                        </div>
                    </div>
                </div>
            </div>
            <div style="height: 5px"></div>
            <div style="width: 100%;display:grid; grid-template-column: 1fr 1fr">
              <div>
              	<ul class="thumbList">
              	  <li>
              	    <img alt="" src="../images/detail_thumb.jpeg">
              	  </li>
              	</ul>
              </div>
              <div></div>
            </div>
            <div class="left">
				<h2>상세설명</h2>
                <div class="img_scroll" style="width: 80%">
                    <div class="imgs">
                        <img src="../images/detail_img.jpeg" alt="">
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
    			  
    		  }
    	  },
    	  mounted(){
    		  this.dataRecv()
    	  },
    	  methods:{
    		  dataRecv(){
    			  
    		  }
    	  }
      }).mount('.funding_detail')
    </script>
</body>
</html>