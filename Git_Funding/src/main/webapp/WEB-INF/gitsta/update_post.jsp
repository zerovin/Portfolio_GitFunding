<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>포스팅 수정</title>
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
    <div class="post-container" id="updateApp">
        <div class="post-header">
            <h2>포스팅 수정</h2>
        </div>
        <form @submit.prevent="submitForm">
            <div class="post-input">
                <!-- 기존 내용을 v-model로 바인딩 -->
                <textarea v-model="content" placeholder="내용을 입력하세요..." required></textarea>
            </div>
            <div class="post-input">
                <!-- 파일 업로드 -->
                <input type="file" ref="upfile" accept="profile/*" v-model="upfiles" multiple="multiple">
                <!-- 기존 파일명이 있을 경우 표시 -->
                <div v-if="filename" style="margin-top: 10px;">
                    <p>기존 파일: {{ filename }}</p>
                </div>
            </div>
            <div style="text-align: center;">
                <button type="submit" class="submit-btn">수정하기</button>
                <button type="button" class="submit-btn" onclick="javascript:history.back()">취소</button>
            </div>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/vue@3"></script>
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    <script>
        let updateApp = Vue.createApp({
            data() {
                return {
                    content: '',  // 게시물 내용
                    filename: '', // 기존 파일명
                    no: ${no},
                    upfiles:''
                }
            },
            mounted() {
                // 게시물 데이터를 불러옴
                this.getPostData();
            },
            methods: {
                getPostData() {
                    // 게시물 번호를 이용해 데이터를 불러옴
                    axios.get('../gitsta/post_update_vue.do', {
                        params: {
                            no: this.no
                        }
                    }).then(res => {
                        let post = res.data;
                        this.content = post.content;   // 게시물 내용
                        this.filename = post.filename; // 파일명
                    }).catch(error => {
                        console.log(error.response);
                    });
                },
                submitForm() {
                    if (this.content === "") {
                        alert("내용을 입력하세요.");
                        return;
                    }

                    let formData = new FormData();
                    formData.append("no", this.no); // 게시물 번호
                    formData.append("content", this.content); // 수정된 내용

                    // 파일이 선택된 경우에만 추가
                    const fileInput = this.$refs.upfile;
                    if (fileInput.files.length > 0) {
                        formData.append("file", fileInput.files[0]);
                    }

                    axios.post('../gitsta/post_update_ok_vue.do', formData, {
                        headers: {
                            'Content-Type': 'multipart/form-data'
                        }
                    }).then(res => {
                        if (res.data === 'yes') {
                            alert("수정되었습니다!");
                            location.href = '../gitsta/main.do';  // 성공 시 메인 페이지로 이동
                        } else {
                            alert(res.data);
                        }
                    }).catch(error => {
                        console.log(error.response);
                    });
                }
            }
        }).mount('#updateApp');
    </script>
</body>
</html>
