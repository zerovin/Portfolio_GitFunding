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
            align-items: flex-start;
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
        .activity-list input, .activity-list select {
            margin-left: 10px;
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
            width: calc(100% - 20px);
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
    
    <script src="https://cdn.jsdelivr.net/npm/vue@3"></script>
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
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
                <span class="info-label">이메일:</span>
                <input type="email" v-model="userInfo.email" placeholder="이메일을 입력하세요" required>
            </div>
            <div class="info-section">
                <span class="info-label">성별:</span>
                <select v-model="userInfo.gender" required>
                    <option value="남자">남자</option>
                    <option value="여자">여자</option>
                </select>
            </div>
            <div class="info-section">
                <span class="info-label">주소:</span>
                <input type="text" v-model="userInfo.addr1" placeholder="주소 1" required>
                <input type="text" v-model="userInfo.addr2" placeholder="주소 2">
            </div>
            <div class="info-section">
                <span class="info-label">우편번호:</span>
                <input type="text" v-model="userInfo.post" placeholder="우편번호" required>
            </div>
            <div class="info-section">
                <span class="info-label">전화번호:</span>
                <input type="text" v-model="userInfo.phone" placeholder="전화번호" required>
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
                        email: '',
                        gender: '남자',
                        addr1: '',
                        addr2: '',
                        post: '',
                        phone: ''
                    },
                    email:'',
                    gender:'',
                    addr1:'',
                    addr2:'',
                    post:'',
                    phone:'',
                    userId:''
                    
                }
            },
            mounted() {
                this.getUserInfo();
            },
            methods: {
                getUserInfo() {
                    axios.get('../mypage/menu_vue.do')
                        .then(res => {
                            this.userInfo = res.data 
                        })
                        .catch(error => {
                            console.log(error.response)
                            alert('정보를 가져오는 데 실패했습니다.')
                        })
                },
                updateUserInfo() {
                    if (this.userInfo.email === "") {
                        this.$refs.email.focus()
                        return
                    }
                    if (this.userInfo.gender === "") {
                        this.$refs.gender.focus()
                        return
                    }
                    if (this.userInfo.addr1 === "") {
                        this.$refs.addr1.focus()
                        return
                    }
                    if (this.userInfo.addr2 === "") {
                        this.$refs.addr2.focus()
                        return
                    }
                    if (this.userInfo.post === "") {
                        this.$refs.post.focus()
                        return
                    }
                    if (this.userInfo.phone=== "") {
                        this.$refs.phone.focus()
                        return
                    }

                    axios.post('../mypage/update_user_info.do', null, {
                        params: {
                            email: this.userInfo.email,
                            gender: this.userInfo.gender,
                            addr1: this.userInfo.addr1,
                            addr2: this.userInfo.addr2,
                            post: this.userInfo.post,
                            phone: this.userInfo.phone,
                            userId: this.userInfo.userId  // userId 추가
                        }
                    }).then(res => {
                        console.log(res.data);
                        if (res.data === "yes") {
                            alert("정보가 수정되었습니다");
                            location.href = "../mypage/info.do";
                        } else {
                            alert(res.data);
                        }
                    }).catch(error => {
                        console.log(error.response);
                    });
                }
            }
        }).mount('#myinfoApp');
    </script>
</body>
</html>
