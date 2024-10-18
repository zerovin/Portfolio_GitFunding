<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Instagram Style Page</title>
<style type="text/css">
/* ----------------- 인스타그램 스타일 페이지 ------------------- */
.instagram-page {
    max-width: 800px;
    margin: 0 auto;
    padding: 20px;
}

.user-info {
    display: flex;
    align-items: center;
    justify-content: flex-start;
    margin-bottom: 20px;
}

.user-info div {
    text-align: center;
    margin-right: 20px;
}

.profile-pic {
    width: 70px;
    height: 70px;
    border-radius: 50%;
    margin-bottom: 5px;
    object-fit: cover;
}

.post {
    border: 1px solid #e0e0e0;
    border-radius: 10px;
    margin-bottom: 20px;
    background-color: #ffffff;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.post-header {
    display: flex;
    align-items: center;
    padding: 15px;
    border-bottom: 1px solid #e0e0e0;
}

.post-profile-pic {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    margin-right: 7px;
    object-fit: cover;
}

.post-user-info {
    display: flex;
    align-items: center;
    justify-content: space-between;
    width: 100%;
}

.username {
    font-weight: 600;
    font-size: 16px;
}

.follow-btn {
    background-color: #f8c200;
    border: none;
    padding: 5px 10px;
    border-radius: 5px;
    cursor: pointer;
    font-weight: 500;
    transition: background-color 0.3s;
}

.follow-btn:hover {
    background-color: #e0a800;
}

.post-image {
    width: 100%;
    max-height: 400px;
    overflow: hidden;
}

.post-image img {
    width: 100%;
    height: auto;
    object-fit: cover;
}

.post-content {
    padding: 15px;
}

.post-content p {
    margin-bottom: 10px;
    font-size: 15px;
    color: #333;
}

.tag {
    display: inline-block;
    background-color: #f0f0f0;
    padding: 5px 10px;
    border-radius: 15px;
    font-size: 14px;
    color: #666;
}

.readmore {
    display: block;
    width: 100%;
    padding: 15px 0;
    margin: 20px 0;
    text-align: center;
    background-color: #f8c200;
    color: #ffffff;
    font-weight: 600;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s;
    text-decoration: none;
}
.readmore:hover {
    background-color: #e0a800;
}
</style>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
</head>
<body>
<div id="totalFeedApp" class="instagram-page">
    <div class="user-info">
        <div>
            <a :href="'../gitsta/feed.do?userId='+sessionId"><img src="../images/cute.png" alt="사용자 프로필" class="profile-pic"></a>
            <p><span style="font-weight: bold;">나</span></p>
        </div>
        <div>
            <a href="../gitsta/feed.do?userId=zero"><img src="../images/favicon.png" alt="사용자 프로필" class="profile-pic"></a>
            <p>이영빈</p>
        </div>
        <div>
            <img src="../images/favicon.png" alt="사용자 프로필" class="profile-pic">
            <p>김다영</p>
        </div>
        <div>
            <img src="../images/favicon.png" alt="사용자 프로필" class="profile-pic">
            <p>민다진</p>
        </div>
        <div>
            <img src="../images/favicon.png" alt="사용자 프로필" class="profile-pic">
            <p>정지나</p>
        </div>
    </div>

    <!-- 포스트 목록 -->
    <div v-for="post in visibleFeed" :key="post.no" class="post">
        <div class="post-header">
            <img :src="post.profile" alt="사용자 프로필" class="post-profile-pic">
            <div class="post-user-info">
                <div><span class="username">{{ post.nickname }}</span> </div>
                <button class="follow-btn" v-if="sessionId!==post.userId">+ 팔로우</button>
            </div>
        </div>
        <div class="post-image">
            <img :src="'../profile/' + post.filename" alt="포스팅 이미지">
        </div>
        <div class="post-content">
            <p>{{ post.content }}</p>
            <span class="tag" v-if="post.dbday===post.mday">{{post.dbday}}</span>
            <span class="tag" v-else>[수정됨]&nbsp;{{post.mday}}</span>
        </div>
    </div>

    <!-- 더보기 버튼 -->
    <button class="readmore" v-if="feedList.length > postsToShow" @click="loadMore">피드 더보기</button>
</div>

<script>
let totalFeedApp = Vue.createApp({
    data() {
        return {
            feedList: [],
            postsToShow: 3,
            sessionId: ''
        }
    },
    mounted() {
        this.loadFeed()
        this.getSessionId()
    },
    methods: {
    	getSessionId() {
            axios.get('../gitsta/getSessionId.do')
                .then(response => {
                    this.sessionId = response.data; // 가져온 sessionId 저장
                })
                .catch(error => {
                    console.error('세션 ID 가져오기 오류:', error.response);
                });
        },
        loadFeed() {
            axios.get('../gitsta/total_feed_vue.do')
            .then(response => {
                console.log(response.data)
                this.feedList = response.data.list;
            }).catch(error => {
                console.error('피드 가져오기 오류:', error);
            });
        },
        loadMore() {
            this.postsToShow += 3;
        }
    },
    computed: {
        visibleFeed() {
            return this.feedList.slice(0, this.postsToShow);
        }
    }
}).mount('#totalFeedApp');
</script>

</body>
</html>
