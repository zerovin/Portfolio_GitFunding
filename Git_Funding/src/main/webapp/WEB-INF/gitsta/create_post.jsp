<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>포스팅 올리기</title>
    <style type="text/css">
        .post-container {
            width: 700px;
            margin: 0 auto;
            background-color: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        .post-header {
            text-align: center;
            margin-bottom: 20px;
        }
        .post-header h2 {
            margin: 0;
        }
        .post-input {
            text-align: center;
            margin-bottom: 20px;
        }
        .post-input textarea {
            width: 90%;
            height: 100px;
            border-radius: 5px;
            border: 1px solid #e0e0e0;
            padding: 10px;
            resize: none;
        }
        .post-input input[type="file"] {
            margin: 10px 0;
        }
        .submit-btn {
            text-align: center;
            background-color: #f8c200;
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
            cursor: pointer;
            font-weight: bold;
            transition: background-color 0.3s;
        }
        .submit-btn:hover {
            background-color: #e0a800;
        }
    </style>
</head>
<body>
    <div class="post-container" id="insertApp">
        <div class="post-header">
            <h2>새 포스팅 올리기</h2>
        </div>
        <form @submit.prevent="submitForm">
            <div class="post-input">
                <textarea v-model="content" placeholder="내용을 입력하세요..." required></textarea>
            </div>
            <div class="post-input">
                <input type="file" ref="upfile" accept="image/*" required>
            </div>
            <div style="text-align: center;">
                <button type="submit" class="submit-btn">올리기</button>
                <button type="button" class="submit-btn" onclick="javascript:history.back()">취소</button>
            </div>
        </form>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/vue@3"></script>
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    <script>
        let insertApp = Vue.createApp({
            data() {
                return {
                    content: '',
                    userId:''
                }
            },
            mounted(){
            	  
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
                submitForm() {
                    if (this.content === "") {
                        alert("내용을 입력하세요.");
                        return;
                    }
                    let formData = new FormData();
                    formData.append("userId",this.userId);
                    formData.append("content", this.content);

                    const fileInput = this.$refs.upfile;
                    if (fileInput.files.length > 0) {
                        formData.append("image", fileInput.files[0]); // 단일 파일만 추가
                    }

                    axios.post('../gitsta/create_post_vue.do', formData, {
                        headers: {
                            'Content-Type': 'multipart/form-data'
                        }
                    }).then(res => {
                        if (res.data === 'yes') {
                            alert("포스팅되었습니다!!");
                            location.href = '../gitsta/main.do';
                        } else {
                            alert(res.data);
                        }
                    }).catch(error => {
                        console.log(error.response);
                    });
                }
            }
        }).mount('#insertApp');
    </script>
</body>
</html>
