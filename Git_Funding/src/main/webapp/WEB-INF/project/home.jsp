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
				<img src="../images/profile.png" alt="프로필이미지">		
				<a href="#" class="profile_edit"><i class="fa-regular fa-pen-to-square"></i></a>	
			</div>
			<a href="#" class="user_name">서원진님 <i class="fa-solid fa-chevron-right"></i></a>
			<button class=GoToMyPageBtn @click="GoToMyPage()">마이페이지로 이동</button>
		</div>
		<div class="CenterArea">
<!-- 				<section> -->
				<div class="CenterAreaTopContainer">
				    <nav class="CenterAreaTopContainerWrapper">
				        <button type="button" class="Tabsbutton1" @click="navigateTo('Home')">
				            <i class="fa-solid fa-chart-line"> </i>
				            <span class="Tabsbutton-text"> 메이커 홈</span>
				        </button>
				        <button type="button" class="Tabsbutton2" @click="navigateTo('settlementDate')">
				            <i class="fa-solid fa-sack-dollar"> </i>
				            <span class="Tabsbutton-text"> 정산일</span>
				        </button>
				    </nav>
				</div>

				<div class="CenterAreaCenterContainer"> 
				    <div class="CenterAreaCenter1st">
				        <div class="RefreshTodaysDataContainer">
				            <button type="button">
								<span>오늘 데이터 한번에 보기<i class="fa-solid fa-rotate-right" style="margin-left: 20px; font-size: 20px"></i></span>
				            </button>
				            <span>10건</span>
				        </div>
				        
				        <!-- 우측 하단 부분을 2행으로 나눔 -->
				        <div class="ViewTodayDataContainer">
				            <ul class="ViewTodayData"> 
				                <li> 
				                    <dl>
				                        <dt>찜・알림신청</dt>
				                        <dd>- 0 <br>(구현 예정)</dd>
				                    </dl>
				                </li>
				                <li> 
				                    <dl>
				                        <dt>결제(예약)</dt> 
				                        <dd>+ 0￦ <br>(구현 예정)</dd> 
				                    </dl>
				                </li>
				                <li>
				                    <dl>
				                        <dt>지지서명</dt> 
				                        <dd>- 0 <br>(구현 예정)</dd> 
				                    </dl>
				                </li>
				                <li> 
				                    <dl>
				                        <dt>앵콜 요청</dt>
				                        <dd>- <br>(보류)</dd>
				                    </dl>
				                </li>
				            </ul>
				        </div>
				    </div>
				    <div class="CenterAreaCenter2nd">		    	 
				    	<ul>
				            <li :class="{ active: selectedTab === 'funding' }" @click="selectTab('funding')">
				                <dl>펀딩・프리오더</dl>
				            </li>
				            <li :class="{ active: selectedTab === 'store' }" @click="selectTab('store')">
				                <dl>스토어</dl>
				            </li>
				        </ul>
				        <div class="FundingStoreViewContainer" id=FundingStoreView>
		        			<i class="fa-solid fa-gift" style="text-align:center; font-size: 50px"></i>
			        		<div class="FundingStoreView">
			        			<p class="FundingStoreViewText">새로운 도전을</p>
			        			<p><br>시작해보세요.</p>
			        		</div>
			        			<p><br>제품・콘텐츠・서비스 출시, 성장까지 깃펀딩이 함께합니다.</p>
			        			<div>
			        				<button class="CreateProjectBtn" @click="CreateProject">프로젝트 만들기</button>
			        			</div>
				    	</div>
				    </div>
				</div>
				<div class="CenterAreaBottomContainer">
					<div class="ProjectManagementContainer">
						<div class="ProjectManagementContainerText">
							<h4>프로젝트 문의</h4>
						</div>
						<div class="ProjectQnABtn" @click="ProjectQnA">
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
						<div class="OneByOneChatBtn" @click="OneByOneChat">
							<button>
								<i class="fa-regular fa-comment-dots"> 1:1 채팅 상담</i>
								<i class="fa-solid fa-chevron-right"></i>
							</button>
						</div>
						<div class="NoticeBtn" @click="Notice">
							<button>
								<i class="fa-solid fa-bullhorn"> 공지 사항</i>
								<i class="fa-solid fa-chevron-right"></i>
							</button>
						</div>
						<div class="AcountSettingsBtn" @click="AcountSettings">
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
	                // 데이터가 필요할 경우 추가
	            	selectedTab: 'funding'
	            }
	        },
	        methods: {
	            GoToMyPage() {
	                window.location.href = '../mypage/main.do';
	            },
	            CreateProject() {
	            	window.location.href = '../main/main.do';
	            },
	            ProjectInquiries() {
	            	window.location.hef = '../main/main.do';
	            },
	            navigateTo(page) {
	                axios.get(`/project/${page}.jsp`)
	                    .then(response => {
	                        document.getElementById('CenterAreaContent').innerHTML = response.data;
	                    })
	                    .catch(error => {
	                        console.log(error.response);
	                    });
	            },
	            selectTab(tab) {
	                this.selectedTab = tab; // 탭 선택 상태 업데이트
	                this.navigateTo(tab); // 선택한 탭의 페이지로 이동
	            }
	        }
	    }).mount('#ProjectHome');
	</script>
</body>
</html>
