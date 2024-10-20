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
    <!-- 로그인한 사용자 정보 -->
    <div class="user-info">
        <div>
            <a :href="'../gitsta/feed.do?userId=' + sessionId"><img src="${sessionScope.profile }" class="profile-pic"></a>
            <p><span style="font-weight: bold;">나</span></p>
        </div>
        
        <!-- 팔로잉한 사용자 목록 -->
		<div v-for="user in followingList" :key="user.userId">
		    <a :href="'../gitsta/feed.do?userId=' + user.userId">
		        <img :src="user.profile" alt="사용자 프로필" class="profile-pic">
		    </a>
		    <p v-if="user.nickname!==null">{{ user.nickname }}</p>
		    <p v-else>{{ user.userName }}</p>
		</div>
    </div>

	<!-- 포스트 목록 -->
	<div v-for="post in visibleFeed" :key="post.no" class="post">
	    <div class="post-header">
	        <img :src="post.profile" alt="사용자 프로필" class="post-profile-pic">
	        <div class="post-user-info">
	            <div v-if="post.nickname !== null">
	                <span class="username">{{ post.nickname }}</span>
	                <span class="tag">{{ post.dbday }}</span> <!-- 경과 시간 표시 -->
	            </div>
	            <div v-else>
	                <span class="username">{{ post.userName }}</span>
	                <span class="tag">{{ post.dbday }}</span> <!-- 경과 시간 표시 -->
	            </div>
	            <button class="follow-btn" v-if="sessionId !== post.userId && !post.isFollowing" @click="followUser(post.userId)">+ 팔로우</button>
	            <button class="follow-btn" v-if="sessionId !== post.userId && post.isFollowing" @click="unfollowUser(post.userId)">- 언팔로우</button>
	        </div>
	    </div>
	    <div class="post-image">
	        <img :src="'../profile/' + post.filename" alt="포스팅 이미지">
	    </div>
	    <div class="post-content">
	        <p>{{ post.content }}</p>
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
            followingList: [], // 전체 팔로잉한 사용자들의 정보를 저장합니다.
            randomFollowingList: [], // 랜덤으로 선택한 8명의 팔로잉 목록
            postsToShow: 3,
            sessionId: '',
            profile: ''
        }
    },
    mounted() {
        this.getSessionId();
    },
    methods: {
        getSessionId() {
            axios.get('../gitsta/getSessionId.do')
                .then(response => {
                    this.sessionId = response.data; // 가져온 sessionId 저장
                    this.loadFollowingList(); // 세션 ID를 가져온 후 팔로잉 목록 로드
                    this.loadFeed(); // 피드 로드
                })
                .catch(error => {
                    console.error('세션 ID 가져오기 오류:', error.response);
                });
        },
        loadFollowingList() {
            axios.get('../gitsta/following_list_vue.do', {
                params: {
                    userId: this.sessionId
                }
            })
            .then(response => {
                console.log(response.data);
                this.followingList = response.data.list; // 팔로잉 목록 저장 (모든 사용자 정보 포함)
                this.selectRandomFollowing(); // 무작위로 8명 선택
            })
            .catch(error => {
                console.error('팔로잉 목록 가져오기 오류:', error);
            });
        },
        selectRandomFollowing() {
            // 팔로잉 목록에서 랜덤으로 최대 8명 선택
            let shuffled = this.followingList.sort(() => 0.5 - Math.random()); // 목록을 무작위로 섞기
            this.randomFollowingList = shuffled.slice(0, 7); // 최대 8명 선택
        },
        loadFeed() {
            axios.get('../gitsta/total_feed_vue.do')
            .then(response => {
                console.log(response.data);
                // 피드 정보를 로드할 때 사용자가 팔로우 중인지 여부를 포함하여 처리
                this.feedList = response.data.list.map(post => {
                    post.isFollowing = this.followingList.some(user => user.userId === post.userId);
                    return post;
                });
            }).catch(error => {
                console.error('피드 가져오기 오류:', error);
            });
        },
        followUser(userId) {
            axios.post('../gitsta/follow.do', null, {
                params: {
                    followerId: this.sessionId,
                    followingId: userId
                }
            })
            .then(response => {
                if (response.data === 'success') {
                    alert('팔로우 성공!');
                    this.updateFollowStatus(userId, true);
                    this.loadFollowingList(); // 팔로잉 목록 다시 로드
                } else {
                    alert('팔로우 실패. 다시 시도해 주세요.');
                }
            })
            .catch(error => {
                console.error('팔로우 오류:', error);
                alert('팔로우 오류가 발생했습니다.');
            });
        },
        unfollowUser(userId) {
            axios.post('../gitsta/unfollow.do', null, {
                params: {
                    followerId: this.sessionId,
                    followingId: userId
                }
            })
            .then(response => {
                if (response.data === 'success') {
                    alert('언팔로우 성공!');
                    this.updateFollowStatus(userId, false);
                    this.loadFollowingList(); // 팔로잉 목록 다시 로드
                } else {
                    alert('언팔로우 실패. 다시 시도해 주세요.');
                }
            })
            .catch(error => {
                console.error('언팔로우 오류:', error);
                alert('언팔로우 오류가 발생했습니다.');
            });
        },
        updateFollowStatus(userId, isFollowing) {
            this.feedList = this.feedList.map(post => {
                if (post.userId === userId) {
                    post.isFollowing = isFollowing;
                }
                return post;
            });
            if (isFollowing) {
                const user = this.feedList.find(post => post.userId === userId);
                if (user) {
                    this.followingList.push(user);
                }
            } else {
                this.followingList = this.followingList.filter(user => user.userId !== userId);
            }
            this.selectRandomFollowing(); // 팔로우 상태 변경 후 무작위 목록 갱신
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
