<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
   .mymenu-div {
        font-family: 'NEXON Lv2 Gothic';
        display: flex;
        flex-direction: column;
        align-items: center;
        width: 250px;
        background-color: #ffffff;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        margin: 20px;
    }
    .profile-div {
        position: relative;
        text-align: center;
    }
    .profile-div img {
        width: 100px;
        height: 100px;
        border-radius: 50%;
        border: 2px solid #e0e0e0;
    }
    .profile-div .edit-icon {
        position: absolute;
        bottom: 5px;
        right: 5px;
        background-color: #ffffff;
        border-radius: 50%;
        padding: 5px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }
    .mymenu-div p {
        font-size: 18px;
        font-weight: bold;
        margin-top: 10px;
        margin-bottom: 20px;
    }
    .mymenu {
        width: 100%;
    }
    .mymenu_p {
        font-weight: bold;
        border-bottom: 1px solid #e0e0e0;
        padding-bottom: 10px;
    }
    .mymenu_p:hover {
        cursor: pointer;
    }
    .mymenu-detail {
        margin-bottom: 10px;
        margin-top: 10px;
    }
    .mymenu button {
        width: 100%;
        background: none;
        border: none;
        padding: 10px;
        text-align: left;
        border-radius: 5px;
        transition: background-color 0.3s;
        cursor: pointer;
        font-size: 16px;
    }
    .mymenu button:hover {
        background-color: #f0f0f0;
    }
    .rgitsta-button {
        display: block;
        width: 90%;
        padding: 10px;
        border: 1px solid #e0e0e0;
        background-color: #ffffff;
        border-radius: 5px;
        text-align: center;
        margin-top: 20px;
        cursor: pointer;
        transition: background-color 0.3s;
        margin-bottom: 30px;
    }
    .rgitsta-button:hover {
        background-color: #f0f0f0;
    }
    .edit-icon {
        width: 20px;
    }
</style>
</head>
<body>
    <div class="mymenu-div" id="mypageApp">
        <div class="profile-div">
            <img src="${sessionScope.profile }">
            <div class="edit-icon">
                <img src="../images/edit.png" style="width: 20px;height: 20px">
            </div>
        </div>
        <p v-if="userInfo.nickname==null">{{ userInfo.userName }} 님</p>
        <p v-else>{{ userInfo.nickname }} 님</p>
        <div class="mymenu">
            <a href="../project/home.do" class="rgitsta-button">프로젝트 관리자</a>
            <div class="mymenu-detail">
                <p class="mymenu_p">나의 활동</p>
                <ul>
                    <li><button @click="main">메인</button></li>
                    <li><button @click="jjimAlert">찜·알림신청</button></li>
                    <li><button @click="fundingBuy">펀딩</button></li>
                    <li><button @click="storeBuy">스토어</button></li>
                </ul>
            </div>
            <div class="mymenu-detail">
                <p class="mymenu_p" style="margin-top: 25px;">정보 관리</p>
                <ul>
                    <li><button>커뮤니티 관리</button></li>
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
        			console.log(res.data)
        			this.userInfo=res.data.userInfo
        		}).catch(error=>{
        			console.log(error.response)
        		})
        	},
        	fundingBuy() {
        		location.href="../mypage/funding_buy.do"
            },
            infoUpdate() {
            	location.href="../mypage/info.do"
            },
            qnaInfo(){
            	location.href="../mypage/qna.do"
            },
            jjimAlert(){
            	location.href="../mypage/jjim_alert.do"
            },
            main(){
            	location.href="../mypage/main.do"
            },
            storeBuy(){
            	location.href="../mypage/store_ordered.do"
            }
        }
    }).mount('#mypageApp');
	</script>
</body>
</html>
