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
					<img src="../images/ProfileThumbnail.jpg" alt="프로필이미지">		
					<a href="#" class="profile_edit"><i class="fa-regular fa-pen-to-square"></i></a>	
				</div>
				<a href="#" class="user_name">서원진님 <i class="fa-solid fa-chevron-right"></i></a>
				<button class="logout_btn">로그아웃</button>
			</div>
			<div class="CenterArea">
				<section>
					<div class="CenterAreaTopContainer">
					    <nav class="CenterAreaTopContainerWrapper">
					        <button type="button" class="Tabsbutton" @click="navigateTo('Home')">
					            <img src="../images/MakerHomeIcon.jpg" alt="메이커 홈 아이콘" class="Tabsicon" />
					            <span class="Tabsbutton-text">메이커 홈</span>
					        </button>
					        <button type="button" class="Tabsbutton" @click="navigateTo('settlementDate')">
					            <img src="../images/SettlementDateIcon.png" alt="정산일 아이콘" class="Tabsicon" />
					            <span class="Tabsbutton-text">정산일</span>
					        </button>
					    </nav>
					</div>

					<div class="CenterAreaCenterContainer"> 
					    <div class="CenterAreaCenter1st">
					        <div class="RefreshTodaysDataContainer">
					            <button type="button">
									<span>오늘 데이터 한번에 보기<i class="fa-solid fa-arrows-rotate"></i></span>
					            </button>
					            <span>10건</span>
					        </div>
					        
					        <!-- 우측 하단 부분을 2행으로 나눔 -->
					        <div class="ViewTodayDataContainer">
					            <ul class="ViewTodayData"> 
					                <li> 
					                    <dl>
					                        <dt>찜 ・ 알림신청</dt>
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
					        <!-- 세 번째 부분 내용 -->
					        <h3>두 번째 부분 내용</h3>
					    </div>
					</div>
					
					<div class="CenterAreaBottomContainer">
						<h4>프로젝트 계정</h4>
						<div>
							<ul>
								<li class="ProjectQnaMenu">
									<a href="#">
										<span class="ProjectQnaIcon">
											<svg>
												<path></path>
												<path></path>
											</svg>
										</span>
										<span>
											프로젝트 문의
										</span>
										<span class="ProjectQnaArrowIcon">
											<svg>
												<path></path>
											</svg>
										</span>
									</a>
								</li>
							</ul>
						</div>
						<div>
							<h4>고객 센터</h4>
							<div>
								<ul>
									<li class="1:1Chat">
										<button>
											<span class="Project1:1ChatIcon">
												<svg>
													<path></path>
													<path></path>
													<path></path>
												</svg>
											</span>
											<span>
												1:1채팅 상담
											</span>
											<span>
												<svg>
													<path></path>
												</svg>
											</span>
										</button>
									</li>
									
									<li class="GitFundingNotice">
										<a href="#">공지사항 페이지로 이동하는 a태그
											<span class="GitFundingNoticeIcon">
												<i></i>
											</span>
											<span>
												공지사항
											</span>
											<span class="GitFundingNoticeArrowIcon">
												<svg>
													<path></path>
												</svg>
											</span>
										</a>
									</li>
									<li class="MemberSetting">
										<a href="#">
											<span>
												<svg>
													<path></path>
												</svg>
											</span>
											<span>
												계정 설정
											</span>
											<span>
												<svg>
													<path></path>
												</svg>
											</span>
										</a>
									</li>
								</ul>
							</div>
						</div>
					</div>
				</section>
			</div>

	</div>
	<script>
	    let ProjectHomeApp = Vue.createApp({
	        data() {
	            return {
	                // 데이터가 필요할 경우 추가
	            }
	        },
	        methods: {
	            logout() {
	                window.location.href = '../main/main.do';
	            },
	            navigateTo(page) {
	                axios.get(`/project/${page}.jsp`)
	                    .then(response => {
	                        document.getElementById('CenterAreaContent').innerHTML = response.data;
	                    })
	                    .catch(error => {
	                        console.log(error.response);
	                    });
	            }
	        }
	    }).mount('#ProjectHome');
	</script>
</body>
</html>
