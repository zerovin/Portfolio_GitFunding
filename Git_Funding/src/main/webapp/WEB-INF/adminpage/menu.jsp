<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
   	<link rel="stylesheet" href="../css/adminpage_menu.css">
</head>
<body>
    <div class="AdminMenuDiv" id="admin_page_App">
        <div class="ProfileDiv">
            <img src="${sessionScope.profile}">
            <div class="ProfileEditIcon">
                <img src="../images/edit.png" style="width: 20px;height: 20px">
            </div>
        </div>
        <p v-if="userInfo.nickname==null">관리자 {{ userInfo.userName }} 님</p>
        <p v-else>관리자 {{ userInfo.nickname }} 님</p>
        <div class="AdminMenu">
            <a href="../project/home.do" class="gitsta-button">프로젝트 관리자</a>
            <div class="AdminMenuDetail">
                <p class="mymenu_p">나의 활동</p>
                <ul> 
                    <li><button @click="cookie()">최근 본</button></li>
                    <li><button @click="jjimAlert()">찜·알림신청</button></li>
                    <li><button @click="fundingBuy()">펀딩</button></li>
                    <li><button @click="storeBuy()">스토어</button></li>
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
    let admin_page_App = Vue.createApp({
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
            }
        }
    }).mount('#admin_page_App');
	</script>
</body>
</html>
