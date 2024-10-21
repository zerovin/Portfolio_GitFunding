<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항 수정</title>
    <link rel="stylesheet" href="../css/notice_insert.css">
</head>
<body>
    <div class="NoticeInsert" id="updateApp">
        <h1>공지사항 수정</h1>
        <div class="NoticeForm">
            <table class="NoticeTable">
                <tr>
                    <th width="20%">구분</th>
                    <td width="80%">
                        <select name="type" class="NoticeSelect" v-model="type">
                            <option value="1">공지</option>
                            <option value="2">이벤트</option>
                        </select>
                    </td>
                </tr>
                <tr id="white">
                    <th width="20%">제목</th>
                    <td width="80%">
                        <input type="text" name="subject" size="50" class="notice-form-input" required
                        ref="subject" v-model="subject">
                    </td>
                </tr>
                <tr>
                    <th width="20%">내용</th>
                    <td width="80%">
                        <textarea rows="10" cols="50" name="content" class="notice-form-textarea" required
                        v-model="content"></textarea>
                    </td>
                </tr>
                <tr class="NoticeBtns">
                    <td colspan="2">
                        <button class="notice-form-button" @click="NoticeUpdate()">수정</button>
                        <input type="button" value="취소" class="notice-form-cancel-button" onclick="javascript:history.back()">
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <script>
        let updateApp = Vue.createApp({
            data() {
                return {
                	no: ${no},
                    subject: '',
                    content: '',
                    type: ''
                }
            },
            mounted() {
            	axios.get('../notice/update_vue.do',{
					params:{
						no:this.no
					}
            	}).then(response => {
            		console.log(response.data)
            		this.subject = response.data.subject
            		this.content = response.data.content
            		this.type = response.data.type
            	}).catch(error => {
            		console.log(error.response)
            	})
            },
            methods: {
            	NoticeUpdate() {
            		if (this.subject === "") {
						this.$refs.subject.focus()
						return
					}
					if (this.content === "") {
						this.$refs.content.focus()
						return
					}
            	    axios.post('../notice/update_ok_vue.do', null, {
            	        params: {
            	        	no		: this.no,
            	        	subject : this.subject,
            	        	content : this.content,
            	        	type 	: this.type
            	        }
            	    }).then(response => {
            	        console.log(response.data);
            	        if (response.data === "yes") {  
            	        	alert('공지가 수정되었습니다!')
            	            location.href = '../notice/detail.do?no=' + this.no
            	        } else {
            	            alert('공지 등록 실패: ' + response.data)
            	        }
            	    }).catch(error => {
            	        console.log(error.response)
            	        alert('등록 중 오류 발생: ' + error.message)
            	    });
            	}
            }
        }).mount('#updateApp')
    </script>
</body>
</html>