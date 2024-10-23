<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>마이페이지 홈</title>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.14.0/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script src="https://code.jquery.com/ui/1.14.0/jquery-ui.js"></script>
    <script type="text/javascript">
        let $j371 = jQuery.noConflict();
    </script>
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
            align-items: center;
            text-align: left;
        }

        .activity-list img {
            border-radius: 50%;
            margin-bottom: 15px;
            width: 100px;
            height: 100px;
        }

        .activity-list h1 {
            font-size: 24px;
            margin: 10px 0;
            color: #333;
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
        #nickUp {
            border: none;
            background-color: #f8c200;
            color: white;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 5px;
            font-size: 14px;
            margin-right: 20px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="home-container" id="myinfoApp">
        <div class="activity-list">
            <img :src="userInfo.profile" alt="Profile Picture">
            <h1>{{ userInfo.userName }} 님</h1>
            <div class="info-section">
                <span class="info-label">아이디:</span>
                <span class="info-value">{{ userInfo.userId }}</span>
            </div>
            <div class="info-section">
                <span class="info-label">닉네임:</span>
	                <span class="info-value" v-if="userInfo.nickname">{{ userInfo.nickname }}
	                <button @click="showNicknameDialog">수정하기</button></span>
	                <span class="info-value" v-else>닉네임이 설정되지 않았습니다.
	                <button @click="showNicknameDialog">설정하기</button></span>
            </div>
            <div class="info-section">
                <span class="info-label">비밀번호:</span>
                <span class="info-value"><button>변경하기</button></span>
            </div>
            <div class="info-section">
                <span class="info-label">이메일:</span>
                <span class="info-value">{{ userInfo.email }}</span>
            </div>
            <div class="info-section">
                <span class="info-label">성별:</span>
                <span class="info-value">{{ userInfo.gender }}</span>
            </div>
            <div class="info-section">
                <span class="info-label">주소:</span>
                <span class="info-value">{{ userInfo.addr1 }} {{ userInfo.addr2 }}</span>
            </div>
            <div class="info-section">
                <span class="info-label">우편번호:</span>
                <span class="info-value">{{ userInfo.post }}</span>
            </div>
            <div class="info-section">
                <span class="info-label">전화번호:</span>
                <span class="info-value">{{ userInfo.phone }}</span>
            </div>
            <button @click="goToEditPage">정보 수정하기</button>
        </div>

        <!-- 닉네임 설정 다이얼로그 -->
        <nickname-dialog
            v-if="isNicknameDialogVisible"
            :key="isNicknameDialogVisible"
            @close="closeNicknameDialog"
            @save="saveNickname">
        </nickname-dialog>
    </div>

    <script>
        // 닉네임 설정 컴포넌트
        const NicknameDialog = {
            template: `
                <div id="nickname-dialog">
                    <div class="dialog-form">
                        <label for="nickname">새 닉네임:</label>
                        <input type="text" id="nickname" v-model="newNickname" placeholder="닉네임을 입력하세요">
                        <button id="nickUp" @click="save">저장</button>
                    </div>
                </div>
            `,
            data() {
                return {
                    newNickname: ''
                };
            },
            methods: {
                save() {
                    this.$emit('save', this.newNickname);
                }
            },
            mounted() {
                const $dialog = $j371('#nickname-dialog').dialog({
                    autoOpen: true,
                    modal: true,
                    width: 400,
                    height: 'auto',
                    close: () => {
                        this.newNickname = '' // 입력값 초기화
                        this.$emit('close')
                    }
                });

                this.dialogInstance = $dialog;
            },
            beforeUnmount() {
                if (this.dialogInstance) {
                    this.dialogInstance.dialog('destroy') // 메모리에서 제거
                }
            }
        };

        let infoApp = Vue.createApp({
            components: {
                'nickname-dialog': NicknameDialog
            },
            data() {
                return {
                    userInfo: {},
                    isNicknameDialogVisible: false
                };
            },
            mounted() {
                this.getUserInfo();
            },
            methods: {
                getUserInfo() {
                    axios.get('../mypage/menu_vue.do')
                        .then(res => {
                            this.userInfo = res.data.userInfo;
                        })
                        .catch(error => {
                            console.log(error.response)
                        })
                },
                showNicknameDialog() {
                    this.isNicknameDialogVisible = true
                },
                closeNicknameDialog() {
                    this.isNicknameDialogVisible = false
                },
                saveNickname(newNickname) {
                    axios.post('../mypage/set_nick_vue.do', null, {
                        params: { nickname: newNickname }
                    }).then(response => {
                        if (response.data === 'yes') {
                            alert('닉네임이 "' + newNickname + '"로 설정되었습니다.');
                            this.userInfo.nickname = newNickname
                            this.closeNicknameDialog()
                        } else {
                            alert('닉네임 설정에 실패했습니다.');
                        }
                    })
                    .catch(error => {
                        console.log(error)
                        alert('서버와의 연결에 문제가 발생했습니다.')
                    })
                },
                goToEditPage() {
                    location.href = '../mypage/info_update.do'; // 정보 수정 페이지로 이동
                }
            }
        }).mount('#myinfoApp')
    </script>
</body>
</html>
