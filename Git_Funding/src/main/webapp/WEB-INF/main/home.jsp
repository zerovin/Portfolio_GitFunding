<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<link rel="stylesheet" href="../css/main.css">
</head>
<body>
	<main id="main">
	    <div class="container">
	        <section id="search_cate">
	            <div class="search">
	                <form>
	                    <label for="search">검색</label>
	                    <input type="search" name="search" id="search">
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
	            <div class="category">
				    <ul class="cate_list">
				        <li v-for="(cate, idx) in category">
						    <a :href="'../funding/funding_list.do?cate='+idx">
						        <p>{{cate.first}}️</p>
						        <p>{{cate.second}}</p>
						    </a>
						</li>
				    </ul>
				    <button class="control prev">이전</button>
				    <button class="control next">다음</button>
				</div>
	        </section>
	        <section id="banner">
	            <div class="main_slide">
	                <div class="slides">
	                    <a href="">
	                        <img src="../images/banner01.jpg" alt="공간을 바꾸는 힘 베러 아트 위크">
	                        <p>공간을 바꾸는 힘<br> 베러 아트 위크</p>
	                    </a>
	                </div>
	                <div class="slides">
	                    <a href="">
	                        <img src="../images/banner02.jpg" alt="1초만에 펴지는 캠핑폴대 편안한 캠핑 생활의 시작!">
	                        <p>1초만에 펴지는 캠핑폴대<br> 편안한 캠핑 생활의 시작!</p>
	                    </a>
	                </div>
	                <div class="slides">
	                    <a href="">
	                        <img src="../images/banner03.jpg" alt="그토록 기다려오던 캠핑용 TV 4.8평점 받고 돌아왔어요">
	                        <p>그토록 기다려오던 캠핑용 TV<br> 4.8평점 받고 돌아왔어요</p>
	                    </a>
	                </div>
	                <div class="slides">
	                    <a href="">
	                        <img src="../images/banner04.jpg" alt="4억 프로젝트 개발 세상에서 가장 편안한 트립트랩쿠션">
	                        <p>4억 프로젝트 개발<br> 세상에서 가장 편안한 트립트랩쿠션</p>
	                    </a>
	                </div>
	                <div class="slides">
	                    <a href="">
	                        <img src="../images/banner05.jpg" alt="깃펀딩 후원자가 사랑한 올해 마지막 슈퍼리브 프로젝트">
	                        <p>깃펀딩 후원자가 사랑한 <br> 올해 마지막 슈퍼리브 프로젝트</p>
	                    </a>
	                </div>
	                <div class="slides">
	                    <a href="">
	                        <img src="../images/banner06.jpg" alt="조금 다른 패션 트렌드 베러 패션 위크">
	                        <p>조금 다른 패션 트렌드 <br> 베러 패션 위크</p>
	                    </a>
	                </div>
	                <div class="slides">
	                    <a href="">
	                        <img src="../images/banner07.jpg" alt="더 좋은 혜택으로 탐험가의 필수품을 마련하세요">
	                        <p>더 좋은 혜택으로 <br> 탐험가의 필수품을 마련하세요</p>
	                    </a>
	                </div>
	                <div class="slides">
	                    <a href="">
	                        <img src="../images/banner08.jpg" alt="달라지고 싶은 계절, 가을 나만의 취향 찾기">
	                        <p>달라지고 싶은 계절, 가을<br> 나만의 취향 찾기</p>
	                    </a>
	                </div>
	            </div>
	            <div class="adv">
	                <embed src="http://youtube.com/embed/${key}"></embed>
	            </div>
	        </section>
	        <section id="trend_rank">
	            <div class="trend">
	                <h2>트렌드</h2>
	                <div class="best_wish">
	                    <p class="desc">가장 많은 사람들의 <span>위시를</span> 받은 프로젝트</p>
	                    <ul class="wish_list">
	                        <li v-for="wish in wish_list">
	                            <a :href="'../funding/funding_detail.do?fno='+wish.fno" class="f_list">
	                                <img :src="wish.thumb" :alt="wish.title">
	                                <p class="percent">2,177% 달성</p>
	                                <p class="title">{{wish.title}}</p>
	                            </a>
	                        </li>
	                    </ul>
	                </div>
	                <div class="best_support">
	                    <p class="desc">가장 많은 사람들의 <span>지지를</span> 받은 프로젝트</p>
	                    <ul class="support_list">
	                        <li v-for="back in backing_list">
	                            <a :href="'../funding/funding_detail.do?fno='+back.fno" class="f_list">
	                                <img :src="back.thumb" :alt="back.title">
	                                <p class="percent">2,177% 달성</p>
	                                <p class="title">{{back.title}}</p>
	                            </a>
	                        </li>
	                    </ul>
	                </div>
	            </div>
	            <div class="rank">
	                <h2>실시간 랭킹</h2>
	                <ul class="rank_tab">
	                    <li class="active"><a href="#">펀딩</a></li>
	                    <li><a href="#">스토어</a></li>
	                </ul>
	                <ol class="rank_list">
	                    <li>
	                        <a href="#">
	                            <p class="number">1</p>
	                            <div class="rank_content">
	                                <div class="text">
	                                    <p class="title">지퍼백 한번 쓰고 버리세요? 열탕소독으로 평생 쓰는 &lt;플래티넘 실리콘백&gt;</p>
	                                    <p class="headcount">4,660명 참여</p>
	                                </div>
	                                <img src="../images/rank.jpeg" alt="">
	                            </div>
	                        </a>
	                    </li>
	                    <li>
	                        <a href="#">
	                            <p class="number">2</p>
	                            <div class="rank_content">
	                                <div class="text">
	                                    <p class="title">지퍼백 한번 쓰고 버리세요? 열탕소독으로 평생 쓰는 &lt;플래티넘 실리콘백&gt;</p>
	                                    <p class="headcount">4,660명 참여</p>
	                                </div>
	                                <img src="../images/rank.jpeg" alt="">
	                            </div>
	                        </a>
	                    </li>
	                    <li>
	                        <a href="#">
	                            <p class="number">3</p>
	                            <div class="rank_content">
	                                <div class="text">
	                                    <p class="title">지퍼백 한번 쓰고 버리세요? 열탕소독으로 평생 쓰는 &lt;플래티넘 실리콘백&gt;</p>
	                                    <p class="headcount">4,660명 참여</p>
	                                </div>
	                                <img src="../images/rank.jpeg" alt="">
	                            </div>
	                        </a>
	                    </li>
	                    <li>
	                        <a href="#">
	                            <p class="number">4</p>
	                            <div class="rank_content">
	                                <div class="text">
	                                    <p class="title">지퍼백 한번 쓰고 버리세요? 열탕소독으로 평생 쓰는 &lt;플래티넘 실리콘백&gt;</p>
	                                    <p class="headcount">4,660명 참여</p>
	                                </div>
	                                <img src="../images/rank.jpeg" alt="">
	                            </div>
	                        </a>
	                    </li>
	                    <li>
	                        <a href="#">
	                            <p class="number">5</p>
	                            <div class="rank_content">
	                                <div class="text">
	                                    <p class="title">지퍼백 한번 쓰고 버리세요? 열탕소독으로 평생 쓰는 &lt;플래티넘 실리콘백&gt;</p>
	                                    <p class="headcount">4,660명 참여</p>
	                                </div>
	                                <img src="../images/rank.jpeg" alt="">
	                            </div>
	                        </a>
	                    </li>
	                </ol>
	            </div>
	        </section>
	        <section id="open">
	            <h2>오늘 오픈한 프로젝트</h2>
	            <div class="slide_wrap">
                    <div class="multiple_slide_wrapper">
                        <ul class="multiple_slide">
			                <li class="slides" v-for="today in today_list">
			                    <a :href="'../funding/funding_detail.do?fno='+today.fno" class="f_list">
			                        <img :src="today.thumb" :alt="today.title">
			                        <p class="percent">14% 달성</p>
			                        <p class="title">{{today.title}}</p>
			                    </a>
			                </li>
			            </ul>
			         </div>
			         <div class="arrows">
                        <button class="prev" ref="o_prev">이전</button>
                        <button class="next" ref="o_prev">다음</button>
                    </div>
	            </div>
	        </section>
	        <section id="deadline">
	            <h2>마감임박! 마지막 프로젝트</h2>
	            <div class="time">
	                <p><span class="clock"></span> 남았어요</p>
	            </div>
	            <div class="slide_wrap">
                    <div class="multiple_slide_wrapper">
                        <ul class="multiple_slide">
			                <li class="slides" v-for="dead in deadline_list">
			                    <a :href="'../funding/funding_detail.do?fno='+dead.fno" class="f_list">
			                        <img :src="dead.thumb" :alt="dead.title">
			                        <p class="percent">14% 달성</p>
			                        <p class="title">{{dead.title}}</p>
			                    </a>
			                </li>
			             </ul>
			        </div>
			        <div class="arrows">
                        <button class="prev" ref="d_prev">이전</button>
                        <button class="next" ref="d_next">다음</button>
                    </div>
	            </div>
	        </section>
	        <section id="latest">
	            <h2>최근 본 프로젝트</h2>
	            <div class="slide_wrap">
                    <div class="multiple_slide_wrapper">
                        <ul class="multiple_slide">
			                <li class="slides">
			                    <a href="#" class="f_list">
			                        <img src="../images/latest.jpeg" alt="">
			                        <p class="percent">14% 달성</p>
			                        <p class="title">정품보장 | 조말론 런던 카 방향제, 카디퓨저 & 센트 투 고</p>
			                    </a>
			                </li>
			                 <li class="slides">
			                    <a href="#" class="f_list">
			                        <img src="../images/latest.jpeg" alt="">
			                        <p class="percent">14% 달성</p>
			                        <p class="title">정품보장 | 조말론 런던 카 방향제, 카디퓨저 & 센트 투 고</p>
			                    </a>
			                </li>
			                 <li class="slides">
			                    <a href="#" class="f_list">
			                        <img src="../images/latest.jpeg" alt="">
			                        <p class="percent">14% 달성</p>
			                        <p class="title">정품보장 | 조말론 런던 카 방향제, 카디퓨저 & 센트 투 고</p>
			                    </a>
			                </li>
			                 <li class="slides">
			                    <a href="#" class="f_list">
			                        <img src="../images/latest.jpeg" alt="">
			                        <p class="percent">14% 달성</p>
			                        <p class="title">정품보장 | 조말론 런던 카 방향제, 카디퓨저 & 센트 투 고</p>
			                    </a>
			                </li>
			                 <li class="slides">
			                    <a href="#" class="f_list">
			                        <img src="../images/latest.jpeg" alt="">
			                        <p class="percent">14% 달성</p>
			                        <p class="title">정품보장 | 조말론 런던 카 방향제, 카디퓨저 & 센트 투 고</p>
			                    </a>
			                </li>
			                 <li class="slides">
			                    <a href="#" class="f_list">
			                        <img src="../images/latest.jpeg" alt="">
			                        <p class="percent">14% 달성</p>
			                        <p class="title">정품보장 | 조말론 런던 카 방향제, 카디퓨저 & 센트 투 고</p>
			                    </a>
			                </li>
			                 <li class="slides">
			                    <a href="#" class="f_list">
			                        <img src="../images/latest.jpeg" alt="">
			                        <p class="percent">14% 달성</p>
			                        <p class="title">정품보장 | 조말론 런던 카 방향제, 카디퓨저 & 센트 투 고</p>
			                    </a>
			                </li>
			            </ul>
	                </div>
	                 <div class="arrows">
                        <button class="prev" ref="l_prev">이전</button>
                        <button class="next" ref="l_next">다음</button>
                    </div>
	            </div>
	        </section>
	        <seciton id="bottom_ad">
	        	<a :href="bottom_ad.link" target="_blank">
	        		<img :src="'../images/ad'+bottom_ad.no+'.png'" alt="">
	        	</a>
	        </seciton>
	    </div>
	</main>
	<script>
	let slideCount,
		d_slideCount,
		l_slideCount
	let main_list=Vue.createApp({
		data(){
			return{
				category:[{first:"✅️",second:'전체'},{first:"🖥",second:"테크·가전"},{first:"👗",second:"패션"},{first:"💄",second:"뷰티"},{first:"🏠",second:"홈·리빙"},
   					{first:"⚽",second:"스포츠·아웃도어"},{first:"🍴",second:"푸드"},{first:"📚",second:"도서·전자책"},{first:"✏️",second:"클래스"},
   					{first:"🎀",second:"디자인"},{first:"🐶",second:"반려동물"},{first:"🎨",second:"아트"},{first:"🎁",second:"캐릭터·굿즈"},
   					{first:"🎬",second:"영화·음악"},{first:"👶🏻",second:"키즈"},{first:"🕹",second:"게임"},{first:"📰",second:"만화·웹툰"},
   					{first:"📷",second:"사진"},{first:"🗺",second:"여행"},{first:"🚗",second:"자동차"},{first:"🎫",second:"멤버십"},
   					{first:"👫",second:"소셜"}],
				wish_list:[],
				backing_list:[],
				today_list:[],
				deadline_list:[],
				bottom_ad:{}
			}
		},
		mounted(){
			axios.get('../funding/main_vue.do')
			.then(response=>{
				console.log(response.data)
				this.wish_list=response.data.wish_list
				this.backing_list=response.data.backing_list
				this.today_list=response.data.today_list
				this.deadline_list=response.data.deadline_list
				this.bottom_ad=response.data.bottom_ad
				slideCount=this.today_list.length
				d_slideCount=this.deadline_list.length
				//l_slideCount=this.latest_list.length
			}).catch(error=>{
				console.log(error.response)
			})
		}
	}).mount('#main')
		
	</script>
</body>
</html>