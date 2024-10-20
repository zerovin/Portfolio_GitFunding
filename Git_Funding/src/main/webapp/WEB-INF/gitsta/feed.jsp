<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Feed</title>
<style type="text/css">
/* ----------------- 인스타그램 스타일 내 피드 페이지 ------------------- */
body {
    font-family: Arial, sans-serif;
    background-color: #fafafa;
    margin: 0;
    padding: 0;
}

.instagram-page {
    max-width: 800px;
    margin: 0 auto;
    padding: 20px;
}

.header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 10px 20px;
    background-color: #ffffff;
    border-bottom: 1px solid #e0e0e0;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.header img {
    width: 30px;
    height: 30px;
    border-radius: 50%;
    object-fit: cover;
}

.profile-info {
    text-align: center;
    margin-top: 20px;
}

.profile-info img {
    width: 100px;
    height: 100px;
    border-radius: 50%;
    object-fit: cover;
}

.profile-info h2 {
    font-size: 20px;
    margin: 10px 0;
}

.profile-info p {
    font-size: 14px;
    color: #666;
}

.profile-stats {
    display: flex;
    justify-content: space-around;
    margin-top: 20px;
    padding: 10px 0;
    background-color: #ffffff;
    border-top: 1px solid #e0e0e0;
    border-bottom: 1px solid #e0e0e0;
}

.profile-stats div {
    text-align: center;
}

.profile-stats span {
    display: block;
    font-weight: bold;
    font-size: 16px;
}

.buttons {
    display: flex;
    justify-content: space-around;
    margin: 20px 0;
}

.buttons button {
    background-color: #ffffff;
    border: 1px solid #e0e0e0;
    padding: 10px 20px;
    border-radius: 5px;
    cursor: pointer;
    font-weight: 500;
    transition: background-color 0.3s;
}

.buttons button:hover {
    background-color: #e0e0e0;
}

.grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 10px;
    margin-top: 20px;
}
.grid img:hover{
	cursor: pointer;
}

.grid img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    border-radius: 5px;
}

.pagination {
    display: flex;
    justify-content: space-between;
    margin-top: 20px;
}
.pagination button {
    padding: 10px 20px;
    background-color: #f8c200;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    color: #fff;
    font-weight: bold;
    transition: background-color 0.3s;
}
.pagination button:hover {
    background-color: #e0a700;
}
.pagination button:disabled {
    background-color: #e0e0e0;
    cursor: not-allowed;
}
</style>
</head>
<body>
<div id="myfeedApp" class="instagram-page">
	<div class="header">
	    <a href="../gitsta/main.do"><img src="../images/back.png" alt="뒤로가기"></a>
	    <div v-if="myInfo.userId === sessionId">
	        <button @click="createPost" style="background-color: #f8c200; border: none; border-radius: 5px; padding: 10px 20px; cursor: pointer;">새 글</button>
	    </div>
	</div>

    <div class="profile-info">
	    <img :src="myInfo.profile" alt="내 프로필">
	    <h2 v-if="myInfo.nickname == null">{{myInfo.userName}}님</h2>
	    <h2 v-else>{{myInfo.nickname}}</h2>
	    <p>{{myInfo.msg}}</p>
    </div>

    <div class="profile-stats">
        <div>
            <span>{{ totalPostCount }}</span>
            게시물
        </div>
        <div>
            <span>{{ followerCount }}</span> <!-- 팔로워 수 출력 -->
            팔로워
        </div>
        <div>
            <span>{{ followingCount }}</span> <!-- 팔로잉 수 출력 -->
            팔로잉
        </div>
    </div>

    <div class="buttons">
        <button>지지</button>
        <button>포스팅</button>
    </div>

    <div class="grid">
        <div v-for="vo in feedList" :key="vo.id">
            <img v-if="vo.type===1" :src="'../profile/'+vo.filename">
            <img v-else :src="vo.filename">
        </div>
    </div>

    <div class="pagination">
        <button @click="prevPage" :disabled="page === 1">이전</button>
        <button @click="nextPage" :disabled="!hasMore">다음</button>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
<script>
const myfeedApp = Vue.createApp({
    data() {
        return {
            feedList: [],
            totalPostCount: 0,
            hasMore: true,
            page: 1,
            nickname: '',
            userInfo: {},
            userId: '',
            myInfo: {},
            sessionId: '',
            followerCount: 0,
            followingCount: 0
        }
    },
    mounted() {
        const urlParams = new URLSearchParams(window.location.search)
        this.userId = urlParams.get('userId') 
        this.myFeed()
        this.myinfoData()
        this.getSessionId()
        this.loadFollowCount() // 팔로우 및 팔로워 수 불러오기
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
        myinfoData() {
            axios.get('../gitsta/info_vue.do', {
                params: { userId: this.userId }
            }).then(res => {
                console.log(res.data);
                this.myInfo = res.data;
            }).catch(error => {
                console.log(error.response);
            })
        },
        loadFollowCount() {
            axios.get('../gitsta/follower_count_vue.do', {
                params: {
                    userId: this.userId
                }
            })
            .then(response => {
                console.log(response.data);
                this.followerCount = response.data.followerCount; // 팔로워 수 저장
                this.followingCount = response.data.followingCount; // 팔로잉 수 저장
            })
            .catch(error => {
                console.error('팔로워 및 팔로잉 수 가져오기 오류:', error);
            });
        },
        myFeed() {
            axios.get('../gitsta/myfeed_vue.do', {
                params: { page: this.page, userId: this.userId }
            }).then(res => {
                this.feedList = res.data.list;
                this.totalPostCount = res.data.totalPostCount;
                this.hasMore = res.data.hasMore;
                if (res.data.nickname) {
                    this.nickname = res.data.nickname;
                }
            }).catch(error => {
                console.error(error.response);
            })
        },
        createPost() {
            window.location.href = '../gitsta/create_post.do';
        },
        nextPage() {
            this.page += 1;
            this.myFeed();
        },
        prevPage() {
            if (this.page > 1) {
                this.page -= 1;
                this.myFeed();
            }
        }
    }
}).mount('#myfeedApp');
</script>
</body>
</html>
