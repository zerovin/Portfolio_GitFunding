<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>마이페이지 홈</title>

    <style>
        .home-container {
            margin: 20px auto;
            width: 900px;
            font-family: 'NEXON Lv2 Gothic';
            background-color: #f9f9f9;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }

        .activity-list {
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            padding: 20px;
            display: flex;
            flex-direction: column;
            align-items: flex-start; /* 왼쪽 정렬 */
        }

        .info-section {
            margin: 15px 0;
            width: 100%;
            border-bottom: 1px solid #e0e0e0;
            padding-bottom: 10px;
        }

        .info-section:last-child {
            border-bottom: none;
        }

        .info-label {
            font-weight: bold;
            color: #555;
        }

        .info-value {
            margin-left: 10px;
            color: #333;
        }

        .activity-list input {
            margin-left: 10px;
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
            width: calc(100% - 20px); /* 너비 조정 */
        }

        .activity-list button {
            margin-top: 10px;
            padding: 8px 12px;
            background-color: #f8c200;
            color: #ffffff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .activity-list button:hover {
            background-color: orange;
        }
    </style>
</head>
<body>
    <div class="home-container" id="myinfoApp">
        <div class="activity-list">
            <h1 style="margin: 10px; font-weight: bold; text-align: center;">{{ userInfo.userName }} 님의 정보 수정</h1>
            <div class="info-section">
                <span class="info-label">아이디:</span>
                <span class="info-value">{{ userInfo.userId }}</span>
            </div>
            <div class="info-section">
                <span class="info-label">닉네임:</span>
                <input type="text" v-model="userInfo.nickname" placeholder="닉네임을 입력하세요">
            </div>
            <div class="info-section">
                <span class="info-label">비밀번호:</span>
                <input type="password" v-model="userInfo.password" placeholder="비밀번호를 입력하세요">
            </div>
            <div class="info-section">
                <span class="info-label">이메일:</span>
                <input type="email" v-model="userInfo.email" placeholder="이메일을 입력하세요">
            </div>
            <div class="info-section">
                <span class="info-label">성별:</span>
                <select v-model="userInfo.gender">
                    <option value="남">남</option>
                    <option value="여">여</option>
                </select>
            </div>
            <div class="info-section">
                <span class="info-label">주소:</span>
                <input type="text" v-model="userInfo.addr1" placeholder="주소 1">
                <input type="text" v-model="userInfo.addr2" placeholder="주소 2">
            </div>
            <div class="info-section">
                <span class="info-label">우편번호:</span>
                <input type="text" v-model="userInfo.post" placeholder="우편번호">
            </div>
            <div class="info-section">
                <span class="info-label">전화번호:</span>
                <input type="text" v-model="userInfo.phone" placeholder="전화번호">
            </div>
            <button @click="updateUserInfo">정보 수정하기</button>
        </div>
    </div>

    <script>
        let infoApp = Vue.createApp({
            data() {
                return {
                    userInfo: {
                        userId: '',
                        userName: '',
                        nickname: '',
                        password: '',
                        email: '',
                        gender: '남', // 기본값 설정
                        addr1: '',
                        addr2: '',
                        post: '',
                        phone: ''
                    }
                };
            },
            mounted() {
                this.getUserInfo();
            },
            methods: {
                getUserInfo() {
                    axios.get('../mypage/menu_vue.do')
                        .then(res => {
                            this.userInfo = res.data;
                        })
                        .catch(error => {
                            console.log(error.response);
                        });
                },
                updateUserInfo() {
                    axios.post('../mypage/update_user_info.do', this.userInfo)
                        .then(response => {
                            if (response.data === 'yes') {
                                alert('정보가 성공적으로 수정되었습니다.');
                            } else {
                                alert('정보 수정에 실패했습니다.');
                            }
                        })
                        .catch(error => {
                            console.log(error);
                            alert('서버와의 연결에 문제가 발생했습니다.');
                        });
                }
            }
        }).mount('#myinfoApp');
    </script>
</body>
</html>
