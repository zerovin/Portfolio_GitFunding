<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="../css/main.css">
	<style type="text/css">
		.ProjectHomeLayout {
            display: flex;
            height: 100vh;
        }

/* ----------------- 화면 좌측 ------------------- */
        .LeftArea {
            flex: 0 0 20%;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .LeftAreaTop {
            flex: 0 0 70%;
            position: relative;
        }

        .LeftAreaTop h2 {
            position: absolute;
            top: 15%;
            left: 60%;
            font-size: 35px;
            transform: translateX(-50%);
            margin: 0;
        }

        .ProjectProfileThumbnail {
            position: absolute;
            top: 35%;
            left: 60%;
            transform: translateX(-50%);
            width: 120px;
            height: 120px;
            background-color: #ccc;
            border-radius: 50%;
            margin-bottom: 15px;
        }

        .ProjectProfileUserId {
            position: absolute;
            top: 60%;
            left: 60%;
            transform: translateX(-50%);
            font-size: 16px;
            font-weight: bold;
        }

        .LogoutButton {
		    position: absolute;
		    top: 80%;
		    left: 60%;
		    transform: translateX(-50%);
		    font-size: 16px;
		    padding: 15px 30px;
		    background-color: white;
		    color: #f44336;
		    border: 2px solid gray;
		    border-radius: 10px;
		    cursor: pointer;
		    transition: background-color 0.3s, color 0.3s;
		}
		
		.LogoutButton:hover {
		    background-color: #f44336;
		    color: white;
		}

/* ----------------- 화면 좌측, 중앙 사이의 공간 ------------------- */
        .SpaceArea {
            flex: 0 0 5%;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
        }

        .SpaceArea::before {
            content: '';
            position: absolute;
            width: 2px;
            height: 100%;
            background-color: gray;
        }

/* ----------------- 화면 중앙 ------------------- */
        .CenterArea {
		    flex: 0 0 65%;
		    background-color: #fff;
		    padding: 20px;
		    display: flex; /* 내부 요소 배치를 위한 flex 사용 */
		    flex-direction: column; /* 수직 정렬 */
		}
/* ----------------- 화면 중앙 최상단 탭 ------------------- */
        .CenterAreaTopContainer {
            flex: 0 0 5%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 10px;
            border-bottom: 2px solid gray;
        }

        .CenterAreaTopContainerWrapper {
		    display: flex;
		    align-items: center;
		}
		
		.CenterAreaTopContainerWrapper ul {
		    list-style-type: none;
		    padding: 0;
		    margin: 0;
		    display: flex;
		}
		
		.CenterAreaTopContainerWrapper li {
		    margin-right: 20px;
		}

        .Tabsbutton {
		    display: flex;
		    justify-content: center;
		    background: none;
		    border: none;
		    cursor: pointer;
		    padding: 10px;
		}

		.Tabsicon {
		    width: 24px;
		    height: 24px;
		    margin-right: 5px;
		}
		
		.Tabsbutton-text {
		    font-size: 24px;
		    font-weight: bold;
		}
/* ----------------- 화면 중앙 상단 ------------------- */
        .CenterAreaCenterContainer {
		    flex: 0 0 1; /* 최대 100% 차지 */
		    background-color: #f0f0f0;
		    border: 1px solid gray;
		    border-radius: 15px;
		    padding: 20px;
		    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
		    margin-top: 10px;
		    display: flex; /* 플렉스 레이아웃 사용 */
		    flex-direction: column; /* 수직 정렬 */
		    height: 100%; /* 높이 설정 */
		}
		
		.CenterAreaCenter1st, .CenterAreaCenter2nd {
		    display: flex; /* 플렉스 레이아웃 사용 */
		    justify-content: center; /* 수평 정렬 */
		    align-items: center; /* 수직 정렬 */
		    padding: 10px; /* 내부 여백 추가 */
		    min-height: 100px; /* 최소 높이 설정 */
		}
		
		.CenterAreaCenter1st {
			flex: 1;
			position: relative; /* 상대 위치 지정 */
		    background-color: #ccffcc; /* 두 번째 영역 배경색 */
		    padding: 20px; /* 내부 여백 추가 */
		    overflow: hidden; /* 자식 요소가 영역을 넘지 않도록 */
		}
		
		.CenterAreaCenter1st ul {
		    position: absolute; /* 절대 위치 지정 */
		    bottom: 10px; /* 하단으로부터의 거리 */
		    right: 10px; /* 우측으로부터의 거리 */
		    list-style-type: none; /* 리스트 스타일 제거 */
		    padding: 0; /* 패딩 제거 */
		    margin: 0; /* 마진 제거 */
		}
		
		.ViewTodaysDataButton {
		    position: absolute; /* 절대 위치 지정 */
		    top: 0; /* 상단에 위치 */
		    left: 0; /* 좌측에 위치 */
		    margin: 5%; /* 공백을 퍼센트로 조절 (5%는 예시) */
		}
		
		.ViewTodayDataContainer {
	        display: flex;
	        justify-content: center;
	        margin-top: 20px;
	    }
	
	    .ViewTodayData { 
	        display: flex;
	        justify-content: space-between;
	        border: 1px solid #ccc; /* 전체 테두리 */
	        padding: 10px;
	        width: 50%; /* 가로 전체를 사용 */
	    }
	
	    .ViewTodayData li { 
	        flex: 1;
	        text-align: center;
	        border-right: 1px solid #ccc; /* 항목 사이의 경계선 */
	        padding: 0 10px;
	    }
	
	    .ViewTodayData li:last-child { 
	        border-right: none; /* 마지막 항목은 경계선 제거 */
	    }
	
	    .ViewTodayData dt { 
	        font-weight: bold;
	        color: #868e96;
	        margin-bottom: 5px;
	    }
	
	    .ViewTodayData dd { 
	        margin-top: 5px;
	        font-size: 16px;
	        color: #333;
	    }
		
/* ----------------- 화면 중앙 중단 ------------------- */
		.CenterAreaCenter2nd {
			flex: 1;
		    background-color: #ccccff; /* 세 번째 영역 배경색 */
		}
        
        .CenterAreaCenter1st button {
            font-size: 14px;
            padding: 5px 10px;
            background: #f0f0f0;
            border: 1px solid gray;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .CenterAreaCenter1st button:hover {
            background-color: #e0e0e0;
        }

/* ----------------- 화면 중앙 하단 ------------------- */
        .CenterAreaBottomContainer {
		    flex: 0 1 auto%; /* 하단 영역 비율 설정 (원하는 비율로 조정 가능) */
		    background-color: pink;
		    margin-bottom: 10px; /* footer의 높이보다 크게 설정 */
		    padding: 20px; /* 필요에 따라 조정 */
		}
        
/* ----------------- 화면 우측 ------------------- */
        .RightArea {
    	    flex: 0 0 10%;
            background-color: #fff;
            padding: 20px;
        }
        
	</style>
</head>
<body>
	<div id="ProjectHome">
		<section class="ProjectHomeLayout">
			<div class="LeftArea">
				<div class="LeftAreaTop">
					<h2>메이커 홈</h2>
					<div class="ProjectProfileThumbnail">
						<img src="../project/ProjectProvisionalProfileThumbnail.jpg" alt="프로필 이미지 출력 오류">
					</div>
					<div class="ProjectProfileUserId">사용자 아이디를 출력합니다.</div>
					
					<!-- 로그아웃 버튼 -->
					<button class="LogoutButton" @click="logout">로그아웃</button>
				</div>
				<div class="BottomHalf"></div>
			</div>

			<div class="SpaceArea"></div>

			<div class="CenterArea">
				<section>
					<div class="CenterAreaTopContainer">
					    <nav class="CenterAreaTopContainerWrapper">
					        <button type="button" class="Tabsbutton" @click="navigateTo('Home')">
					            <img src="../project/MakerHomeIcon.jpg" alt="메이커 홈 아이콘" class="Tabsicon" />
					            <span class="Tabsbutton-text">메이커 홈</span>
					        </button>
					        <button type="button" class="Tabsbutton" @click="navigateTo('settlementDate')">
					            <img src="../project/SettlementDateIcon.png" alt="정산일 아이콘" class="Tabsicon" />
					            <span class="Tabsbutton-text">정산일</span>
					        </button>
					    </nav>
					</div>

					<div class="CenterAreaCenterContainer"> 
					    <div class="CenterAreaCenter1st">
					        <div class="ViewTodaysDataButton" style="display: flex; align-items: center;">
					            <button type="button">
					                오늘 데이터 한번에 보기
					                <span style="font-weight: bold;">새로 고침</span>
					            </button>
					            <span style="margin-left: 800px; font-size: larger;">-건</span>
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
			<div class="RightArea"></div>
		</section>
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
