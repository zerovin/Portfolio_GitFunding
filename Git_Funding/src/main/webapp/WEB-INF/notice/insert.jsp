<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항 작성</title>
    <link rel="stylesheet" href="../css/notice_insert.css">
</head>
<body>
    <div class="NoticeInsert" id="insertApp">
        <h1>공지사항 작성</h1>
        <div class="NoticeForm">
            <table class="NoticeTable">
                <tr>
                    <th width="20%">구분</th>
                    <td width="80%">
                        <select name="type" class="NoticeSelect" v-model="selectCate">
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
                        <button class="notice-form-button" @click="NoticeInsert()">등록</button>
                        <input type="button" value="취소" class="notice-form-cancel-button" onclick="javascript:history.back()">
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <script>
        let insertApp = Vue.createApp({
            data() {
                return {
                    subject: '',
                    content: '',
                    selectCate: '',
                    userId: '${sessionScope.userId}',
                    nickname: '${sessionScope.nickname}'
                }
            },
            methods: {
            	NoticeInsert() {
            		if (!this.subject || !this.content) {
			            alert('제목과 내용을 입력해 주세요.')
			        }
            		const NoticeVO = {
			                subject: this.subject,
			                content: this.content,
			                type: this.selectCate,
			                id: this.userId,
			                nickname: this.nickname, 
			            }
            	    axios.post('../notice/insert_vue.do', null, {
            	        params: NoticeVO
            	    }).then(response => {
            	        console.log(response.data);
            	        if (response.data === "yes") {  
            	        	alert('공지가 성공적으로 등록되었습니다!')
            	            location.href = '../notice/list.do'
            	        } else {
            	            alert('공지 등록 실패: ' + response.data)
            	        }
            	    }).catch(error => {
            	        console.log(error.response)
            	        alert('등록 중 오류 발생: ' + error.message)
            	    });
            	}
            }
        }).mount('#insertApp')
    </script>
</body>
</html>