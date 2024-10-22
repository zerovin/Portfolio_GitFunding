<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="../css/adminpage_home.css">
</head>
<body>
    <div id="AdminHomeApp" class="home-container">
        <!-- 대시보드 영역 -->
        <div class="dashboard">
            <div class="dashboard-item" id="click">
                <p>포인트</p>
                <div class="value">0P</div>
            </div>
            <div class="dashboard-item" id="click">
                <p>펀딩+</p>
                <div class="value">0</div>
            </div>
            <div class="dashboard-item" id="click">
                <p>스토어</p>
                <div class="value">0</div>
            </div>
        </div>
        <div class="notice-list">
            <div class="notice-list-item">
                <a href="../gitsta/main.do" id="gitsta">깃스타그램</a>
                <div class="gitsta-info">
                    <p>게시물 <span style="font-weight: bold">30</span></p>
                    <p>팔로워 <span style="font-weight: bold">100</span></p>
                    <p>팔로잉 <span style="font-weight: bold">3</span></p>
                </div>
            </div>
        </div>
        <div class="notice-list">
            <div class="notice-list-item">
                <img src="../images/info_icon.png" alt="icon">
                <p>첫 탑 0원으로 배송비 할인과 쿠폰팩 지급</p>
            </div>
            <div class="notice-list-item">
                <img src="../images/info_icon.png" alt="icon">
                <p>지지서명으로 최대 50,000P 받는 방법</p>
            </div>
            <div class="notice-list-item">
                <img src="../images/info_icon.png" alt="icon">
                <p>${sessionScope.userId}님, 나만의 브랜드 콘을 해 보실래요?</p>
            </div>
        </div>
        <div class="activity-list">
            <div class="activity-list-item">
                <button>
                    <p>최근 본</p>
                    <div class="arrow-icon">></div>
                </button>
            </div>
            <div class="activity-list-item">
                <button>
                    <p>찜·알림신청</p>
                    <div class="arrow-icon">></div>
                </button>
            </div>
            <div class="activity-list-item">
                <button>
                    <p>팔로잉</p>
                    <div class="arrow-icon">></div>
                </button>
            </div>
            <div class="activity-list-item" @click="AnswerToQnA()">
                <button>
                    <p>문의 답변하기</p>
                    <div class="arrow-icon">></div>
                </button>
            </div>
        </div>
    </div>
<script>
	let AdminHomeApp = Vue.createApp ({
		data() {
			return {
				
			}
		},
		mounted() {
			
		},
		methods: {
			AnswerToQnA() {
				location.href = '../community/qna_list.do'
			}
		}
	}).mount('#AdminHomeApp')
</script>
</body>
</html>
