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
                <p>회원 목록</p>
                <div class="value">이동 버튼</div>
            </div>
            <div class="dashboard-item" id="click">
                <p>미정</p>
                <div class="value"></div>
            </div>
            <div class="dashboard-item" id="click">
                <p>공지사항 작성</p>
                <div class="value">이동 버튼</div>
            </div>
        </div>
        <div class="notice-list">
            <div class="notice-list-item">
                <a href="../gitsta/main.do" id="gitsta">미정</a>
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
                <p>회원 + - 몇명인지</p>
            </div>
            <div class="notice-list-item">
                <img src="../images/info_icon.png" alt="icon">
                <p>펀딩 + - 몇개인지</p>
            </div>
            <div class="notice-list-item">
                <img src="../images/info_icon.png" alt="icon">
                <p>${sessionScope.userId}관리자님! (삭제 예정)</p>
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
