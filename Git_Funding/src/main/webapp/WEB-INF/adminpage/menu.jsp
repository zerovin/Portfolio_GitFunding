<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
   	<link rel="stylesheet" href="../css/adminpage_menu.css">
</style>
</head>
<body>
    <div class="mymenu-div" id="adminpageApp">
        <div class="profile-div">
            <img src="../images/profile.png">
            <div class="edit-icon">
                <img src="../images/edit.png" style="width: 20px;height: 20px">
            </div>
        </div>
        <p v-if="userInfo.nickname==null">{{ userInfo.userName }} 님</p>
        <p v-else>{{ userInfo.nickname }} 님</p>
        <div class="mymenu">
            <a href="../project/home.do" class="gitsta-button">프로젝트 관리자</a>
            <div class="mymenu-detail">
                <p class="mymenu_p">나의 활동</p>
                <ul>
                    <li><button>최근 본</button></li>
                    <li><button>찜·알림신청</button></li>
                    <li><button>지지 프로젝트</button></li>
                    <li><button>펀딩</button></li>
                    <li><button @click="buyInfo()">스토어</button></li>
                </ul>
            </div>
            <div class="mymenu-detail">
                <p class="mymenu_p" style="margin-top: 25px;">커뮤니티</p>
                <ul>
                    <li><button>나의 리뷰</button></li>
                    <li><button @click="qnaInfo()">문의 내역</button></li>
                    <li><button @click="infoUpdate()">정보 수정</button></li>
                    <li><button>회원 탈퇴</button></li>
                </ul>
            </div>
        </div>
    </div>
    <script>
    let mypageApp = Vue.createApp({
        data() {
            return {
            	userInfo:{}
            }
        },
        mounted() {
        	this.getUserInfo()
        },
        methods: {
        	getUserInfo(){
        		axios.get('../mypage/menu_vue.do',{
        			
        		}).then(res=>{
        			this.userInfo=res.data
        		}).catch(error=>{
        			console.log(error.response)
        		})
        	},
            buyInfo() {
                location.href="../mypage/buy.do"
            },
            infoUpdate() {
            	location.href="../mypage/info.do"
            },
            qnaInfo(){
            	location.href="../mypage/qna.do"
            }
        }
    }).mount('#adminpageApp');
	</script>
</body>
</html>
