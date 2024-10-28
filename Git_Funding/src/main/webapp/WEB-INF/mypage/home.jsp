<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>마이페이지 홈</title>
<link rel="stylesheet" type="text/css" href="../css/mypage_main.css">
</head>
<body>
    <div id="mypageMainApp" class="home-container">
        <!-- 대시보드 영역 -->
        <div class="dashboard">
            <div class="dashboard-item" @click="goToAlert">
                <p>알림</p>
                <div class="value">{{ alertCount }}</div>
            </div>
            <div class="dashboard-item" @click="goToFunding">
                <p>펀딩</p>
                <div class="value">{{ fundingCount }}</div>
            </div>
            <div class="dashboard-item" @click="goToStore">
                <p>스토어</p>
                <div class="value">{{ storeCount }}</div>
            </div>
        </div>
        
        <!-- 깃스타그램 버튼 및 정보 -->
        <div class="notice-list">
            <div class="notice-list-item">
                <button class="gitsta-button" @click="goToGitsta">
                    깃스타그램
                    <img :src="userInfo.profile" alt="프로필 이미지">
                </button>
                <div class="gitsta-info">
                    <p>게시물 <span style="font-weight: bold">{{ totalPosts }}</span></p>
                    <p>팔로워 <span style="font-weight: bold">{{ followerCount }}</span></p>
                    <p>팔로잉 <span style="font-weight: bold">{{ followingCount }}</span></p>
                </div>
            </div>
        </div>
        
        <!-- 알림 항목 -->
	    <h2>최근 본 프로젝트</h2>
         <div v-if="latest_list.length" class="recent-projects">
		    <div v-for="(project, index) in latest_list.slice(0, 5)" :key="project.fno" class="project-item">
		      <a :href="'../funding/funding_detail.do?fno=' + project.fno">
		        <img :src="project.thumb" :alt="project.title" width="100">
		      </a>
		    </div>
  		</div>
  		<div v-else class="no-projects">
		  <p>최근 본 프로젝트가 없습니다!</p>
		</div>

        <!-- 활동 목록 -->
        <div class="activity-list">
            <div class="activity-list-item">
                <button @click="goToAlert">
                    <p>장바구니</p>
                    <div class="arrow-icon"></div>
                </button>
            </div>
            <div class="activity-list-item">
                <button @click="goToFollow">
                    <p>팔로잉</p>
                    <div class="arrow-icon">></div>
                </button>
            </div>
            <div class="activity-list-item">
                <button @click="goToQna">
                    <p>문의 하기</p>
                    <div class="arrow-icon">></div>
                </button>
            </div>
        </div>
    </div>

    <!-- Vue.js 및 Axios 추가 -->
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script>
        const mypageMainApp = Vue.createApp({
            data() {
                return {
                    alertCount: 0,         // 알림 수
                    fundingCount: 0,       // 펀딩 수
                    storeCount: 0,         // 스토어 수
                    totalPosts: 0,         // 게시물 수
                    followerCount: 0,      // 팔로워 수
                    followingCount: 0,     // 팔로잉 수
                    userInfo: {},          // 사용자 정보 (프로필 이미지 포함)
                    latest_list: []
                };
            },
            mounted() {
                this.fetchMypageData();
            },
            methods: {
                fetchMypageData() {
                    axios.get('../mypage/menu_vue.do')
                        .then(response => {
                            const data = response.data;
                            this.alertCount = data.alertCount;
                            this.fundingCount = data.fundingCount;
                            this.storeCount = data.storeCount;
                            this.userInfo = data.userInfo;
                            this.latest_list = data.latest_list
                        })
                        .catch(error => {
                            console.error('마이페이지 데이터를 불러오는데 실패했습니다.', error);
                        });

                    axios.get('../gitsta/stats_vue.do')
                        .then(response => {
                            const data = response.data
                            this.totalPosts = data.totalPosts
                            this.followerCount = data.followerCount
                            this.followingCount = data.followingCount
                        })
                        .catch(error => {
                            console.error('깃스타그램 정보를 불러오는데 실패했습니다.', error)
                        });
                },
                goToAlert() {
                    location.href = '../goods/cart.do'
                },
                goToFunding() {
                    location.href = '../mypage/funding_buy.do'
                },
                goToStore() {
                    location.href = '../mypage/store_ordered.do'
                },
                goToGitsta() {
                    location.href = '../gitsta/main.do'
                },
                goToQna(){
                	location.href = '../community/qna_list.do'
                },
                goToFollow(){
                	location.href = '../mypage/follow.do'
                }
            }
        }).mount('#mypageMainApp');
    </script>
</body>
</html>
