<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팔로잉 및 팔로워 목록</title>
</head>
<style>
/* 팔로잉/팔로워 목록 페이지 전체 레이아웃 */
.follow-page {
    font-family: 'NEXON Lv2 Gothic';
    width: 800px; 
    margin: 0 auto;
    background-color: #ffffff;
    border-radius: 10px;
}

/* 팔로잉/팔로워 목록을 나란히 배치 */
.follow-container {
    display: flex;
    gap: 20px;
}

/* 팔로잉/팔로워 리스트 영역 */
.follow-section {
    flex: 1;
    background-color: #fafafa;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

/* 페이지 상단 헤더 스타일 */
.follow-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding-bottom: 10px;
    border-bottom: 1px solid #e0e0e0;
    margin-bottom: 20px;
}

.follow-header h2 {
    font-size: 22px;
    color: #333;
    margin: 0;
}

/* 팔로잉/팔로워 리스트 스타일 */
.follow-list {
    list-style: none;
    padding: 0;
    margin: 0;
}

.follow-list-item {
    display: flex;
    align-items: center;
    padding: 15px 0;
    border-bottom: 1px solid #e0e0e0;
}

.follow-list-item:last-child {
    border-bottom: none;
}

.follow-list-item img {
    width: 70px;
    height: 70px;
    border-radius: 50%;
    margin-right: 20px;
    object-fit: cover;
    border: 2px solid #ddd;
}

/* 프로필 정보 영역 */
.profile-info {
    flex-grow: 1;
}

.profile-info h3 {
    margin: 0;
    font-size: 18px;
    color: #333;
}

.profile-info p {
    margin: 5px 0 0 0;
    font-size: 14px;
    color: #666;
}

/* 팔로우/팔로잉 버튼 */
.follow-button {
    background-color: #f8c200;
    border: none;
    border-radius: 5px;
    padding: 10px 20px;
    cursor: pointer;
    font-weight: bold;
    color: white;
    transition: background-color 0.3s;
}

.follow-button:hover {
    background-color: #e0a700;
}

.feed-friend {
    text-align: center;
    font-size: xx-large;
    padding: 10px;
    background-color: gold;
    border-radius: 10px;
    margin-bottom: 20px;
}
</style>
</head>
<body>

<!-- 팔로잉/팔로워 페이지 -->
<div id="followApp" class="follow-page">
    <h1 class="feed-friend">나의 친구 목록</h1>
    <div class="follow-container">
        <!-- 팔로워 섹션 -->
        <div class="follow-section">
            <div class="follow-header">
                <h2>팔로워 목록 ({{ followerCount }})</h2>
            </div>
            <ul class="follow-list">
                <li class="follow-list-item" v-for="follower in followerList" :key="follower.userId">
                    <img :src="follower.profile" alt="프로필 이미지">
                    <div class="profile-info">
                        <h3>{{ follower.userName }}</h3>
                        <p>@{{ follower.userId }}</p>
                    </div>
                    <button class="follow-button" @click="viewProfile(follower.userId)">피드 보기</button>
                </li>
            </ul>
        </div>

        <!-- 팔로잉 섹션 -->
        <div class="follow-section">
            <div class="follow-header">
                <h2>팔로잉 목록 ({{ followingCount }})</h2>
            </div>
            <ul class="follow-list">
                <li class="follow-list-item" v-for="following in followingList" :key="following.userId">
                    <img :src="following.profile" alt="프로필 이미지">
                    <div class="profile-info">
                        <h3>{{ following.userName }}</h3>
                        <p>@{{ following.userId }}</p>
                    </div>
                    <button class="follow-button" @click="viewProfile(following.userId)">피드 보기</button>
                </li>
            </ul>
        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
<script>
const followApp = Vue.createApp({
    data() {
        return {
            followerList: [],
            followingList: [],
            followerCount: 0,
            followingCount: 0,
            sessionId: ''
        };
    },
    mounted() {
        this.loadFollowData()
        this.getSessionId();
    },
    methods: {
    	getSessionId() {
            axios.get('../gitsta/getSessionId.do')
                .then(response => {
                    this.sessionId = response.data; // 가져온 sessionId 저장
                    this.loadFollowData()
                })
                .catch(error => {
                    console.error('세션 ID 가져오기 오류:', error.response);
                });
        },
        loadFollowData() {
            axios.get('../gitsta/follow_total_vue.do', {
                params: { userId: this.sessionId }
            })
            .then(response => {
                this.followerList = response.data.followerList;
                this.followingList = response.data.followingList;
                this.followerCount = response.data.followerCount;
                this.followingCount = response.data.followingCount;
            })
            .catch(error => {
                console.error('팔로워 및 팔로잉 목록을 불러오는데 실패했습니다.', error);
            });
        },
        viewProfile(userId) {
            // 해당 프로필로 이동
            window.location.href = "../gitsta/feed.do?userId="+userId
        }
    }
}).mount('#followApp');
</script>

</body>
</html>
