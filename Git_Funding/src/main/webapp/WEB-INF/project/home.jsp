<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="../css/project_home.css">
</head>
<body>
	<div id="ProjectHome" class="container">
		<div class="LeftArea">
			<div class="profile_wrap">
				<img src="${sessionScope.profile }" alt="프로필이미지">		
				<a href="../mypage/info.do" class="profile_edit"><i class="fa-regular fa-pen-to-square"></i></a>	
			</div>
			<a href="#" class="user_name" v-if="nickname === null">{{userName}}님 <i class="fa-solid fa-chevron-right"></i></a>
			<a href="#" class="user_name" v-else>{{nickname}}님 <i class="fa-solid fa-chevron-right"></i></a>
			<button class=GoToMyPageBtn @click="GoToMyPage()">마이페이지로 이동</button>
		</div>
		<div class="CenterArea">
<!-- 				<section> -->
				<div class="CenterAreaTopContainer">
				    <nav class="CenterAreaTopContainerWrapper">
				        <button type="button" class="Tabsbutton1" :class="{ active: TopSelectedTab === 'Home' }" @click="navigateTo('Home')">
						    <i class="fa-solid fa-chart-line"> </i>
						    <span class="Tabsbutton-text"> 메이커 홈</span>
						</button>
<!-- 정산일 버튼 주석처리 했습니다. -->
<!-- 						<button type="button" class="Tabsbutton2" :class="{ active: TopSelectedTab === 'settlementDate' }" @click="navigateTo('settlementDate')"> -->
<!-- 						    <i class="fa-solid fa-sack-dollar"> </i> -->
<!-- 						    <span class="Tabsbutton-text"> 정산일</span> -->
<!-- 						</button> -->
				    </nav>
				</div>

				<div class="CenterAreaCenterContainer"> 
				    <div class="CenterAreaCenter1st">
				        <div class="RefreshTodaysDataContainer">
							<p>데이터 한번에 보기<i class="fa-solid fa-check" style="margin-left:10px;"></i></p>
				            <p>{{count}}건</p>
				        </div>
				        <div>
				        	<img src="../images/funding_totalprice.png" style="width: 100%">
				        </div>
				        <!-- 우측 하단 부분을 2행으로 나눔 -->
				        <div class="ViewTodayDataContainer">
				            <ul class="ViewTodayData">
				            	<li> 
				                 	<dl>
				                        <dt>알림신청</dt>
				                        <dd>{{allalert}}</dd>
				                    </dl>
				                </li>
				                <li> 
				                    <dl>
				                        <dt>위시리스트</dt>
				                        <dd>{{allwish}}</dd>
				                    </dl>
				                </li>
				                <li>
				                    <dl>
				                        <dt>지지서명</dt> 
				                        <dd>{{allbacking}}</dd> 
				                    </dl>
				                </li>
				                <li>				                     
				                    <dl>
				                        <dt>결제(예약)</dt> 
				                        <dd>{{allprice}}</dd> 
				                    </dl>
				                </li>
				            </ul>
				        </div>
				    </div>
				    <div class="CenterAreaCenter2nd">		    	 
				    	<ul>
				            <li :class="{ active: CenterSelectedTab === 'funding' }" @click="CenterSelectTab('funding')">
				                <dl>{{count}}개의 프로젝트 목록</dl>
				            </li>
				        </ul>
				        <div v-if="CenterSelectedTab === 'funding'" class="FundingView">
						    <div v-if="CenterSelectedTab === 'funding'" class="FundingView">
					    <!-- 프로젝트 리스트 출력 -->
					    <div v-if="projectList.length > 0">
					        <ul class="project-list">
					            <li v-for="project in projectList" :key="project.fno" class="project-item" @click="rewardDetail(project.fno)">
					                <img :src="project.thumb" alt="프로젝트 이미지" class="project-image">
					                <div class="project-info">
					                    <h3>{{ project.title }}</h3>
					                    <p>달성률: {{ project.fm_percent }}%</p>
					                    <p>달성 금액: {{ project.fm_totalprice }}원</p>
					                    <p>D-Day: {{ project.dday }}일 남음</p>
					                </div>
					            </li>
					        </ul>
					
					        <!-- 페이징 버튼 -->
								<div class="pagination">
									<button v-if="startPage > 1" @click="prev"
										:class="{'inactive-btn': curpage !== startPage}">이전</button>

									<button v-for="i in range(startPage, endPage)"
										:class="{ 'active-btn': i === curpage, 'inactive-btn': i !== curpage }"
										@click="pageChange(i)">{{ i }}</button>

									<button v-if="endPage < totalpage" @click="next"
										:class="{'inactive-btn': curpage !== endPage}">다음</button>
								</div>
							</div>
					    
					    <!-- 프로젝트가 없는 경우 -->
					    <div v-else>
					        <p>프로젝트가 없습니다.</p>
					        <div>
					            <button class="CreateProjectBtn" @click="CreateProject">프로젝트 만들기</button>
					        </div>
					    </div>
					</div>

						</div>
				    </div>
				</div>
				<div class="CenterAreaBottomContainer">
					<div class="ProjectManagementContainer">
						<div class="ProjectManagementContainerText">
							<h4>프로젝트 문의</h4>
						</div>
						<div class="ProjectQnABtn" @click="ProjectQnA()">
							<button>								
								<i class="fa-regular fa-envelope"> 서포터 문의</i>
								<i class="fa-solid fa-chevron-right"></i>
							</button>
						</div>
					</div>
					<div class="CustomerCenterContainer">
						<div class="CustomerCenterContainerText">
							<h4>고객 센터</h4>
						</div>
<!-- 	1:1 채팅 상담 기능 비활성화 주석 -->
<!-- 						<div class="OneByOneChatBtn" @click="OneByOneChat"> -->
<!-- 							<button> -->
<!-- 								<i class="fa-regular fa-comment-dots"> 1:1 채팅 상담</i> -->
<!-- 								<i class="fa-solid fa-chevron-right"></i> -->
<!-- 							</button> -->
<!-- 						</div> -->
						<div class="NoticeBtn" @click="Notice()">
							<button>
								<i class="fa-solid fa-bullhorn"> 공지 사항</i>
								<i class="fa-solid fa-chevron-right"></i>
							</button>
						</div>
						<div class="AcountSettingsBtn" @click="AcountSettings()">
							<button>
								<i class="fa-solid fa-user-gear"> 계정 설정</i>
								<i class="fa-solid fa-chevron-right"></i>
							</button>
						</div>
					</div>
				</div>
<!-- 			</section> -->
		</div>
	</div>
	<script>
	let ProjectHomeApp = Vue.createApp({
	    data() {
	        return {
	            userName: '',
	            nickname: null,
	            TopSelectedTab: 'Home',
	            CenterSelectedTab: 'funding',
	            projectList: [],  // 프로젝트 리스트 데이터를 저장할 배열
	            curpage: 1,  // 현재 페이지
	            totalpage: 0,  // 총 페이지 수
	            startPage: 1,  // 시작 페이지
	            endPage: 0,    // 끝 페이지
	            count: 0,       // 총 프로젝트 개수
	            allalert:0,
	            allwish:0,
	            allbacking:0,
	            allprice:0
	        };
	    },
	    mounted() {
	        this.dataRecv();  // 사용자 이름 받아오기
	        this.getProjectList();  // 프로젝트 리스트 데이터 가져오기
	    },
	    methods: {
	        dataRecv() {
	            axios.get('../project/home_vue.do')
	            .then(response => {
	            	 this.userName = response.data.userName;  // 서버에서 받은 사용자 이름
	                 this.nickname = response.data.nickname;   // 사용자 이름 설정
	            }).catch(error => {
	                console.log(error.response);
	            });
	        },
	        getProjectList() {
	            axios.get('../funding/my_funding_list_vue.do', {
	                params: {
	                    page: this.curpage  // 현재 페이지 번호 전송
	                }
	            })
	            .then(response => {
	                this.projectList = response.data.list;
	                this.curpage = response.data.curpage;
	                this.totalpage = response.data.totalpage;
	                this.endPage = response.data.endpage;
	                this.startPage = response.data.startpage;
	                this.count = response.data.count;
	                this.allalert=response.data.allalert.toLocaleString();
	                this.allwish=response.data.allwish.toLocaleString();
	                this.allbacking=response.data.allbacking.toLocaleString();
	                this.allprice=response.data.allprice.toLocaleString();
	            }).catch(error => {
	                console.log(error.response);
	            });
	        },
	        range(start, end) {
	            let arr = [];
	            for (let i = start; i <= end; i++) {
	                arr.push(i);
	            }
	            return arr;
	        },
	        pageChange(page) {
	            this.curpage = page;
	            this.getProjectList();
	        },
	        prev() {
	            if (this.startPage > 1) {
	                this.curpage = this.startPage - 1;
	                this.getProjectList();
	            }
	        },
	        next() {
	            if (this.endPage < this.totalpage) {
	                this.curpage = this.endPage + 1;
	                this.getProjectList();
	            }
	        },
	        ProjectQnA() {
	        	location.href = '../community/faq_list.do';
	        },
	        GoToMyPage() {
	            window.location.href = '../mypage/main.do';
	        },
	        navigateTo(tab) {
	            this.TopSelectedTab = tab;
	        },
	        CenterSelectTab(tab) {
	            this.CenterSelectedTab = tab;
	        },
	        Notice() {
	            location.href = '../notice/list.do';
	        },
	        AcountSettings() {
	            location.href = '../mypage/info.do';
	        },
	        rewardDetail(fno) {
	        	location.href = '../project/reward_detail.do?fno='+fno;
	        }
	    }
	}).mount('#ProjectHome');


	</script>
</body>
</html>
