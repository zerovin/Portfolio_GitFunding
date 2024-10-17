<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/notice_insert.css">
</head>
<body>
	<div class="qna-input" id="insertApp">
		<h1>공지사항 작성</h1>
		<div class="qna-form">
			<table class="qna-table">
				<tr>
					<th width="20%">구분</th>
					<td width="80%">
						<select name="type" class="qna-select" v-model="selectCate">
							<option value="1">공지</option>
							<option value="2">이벤트</option>
							<option value="3">알려드립니다</option>
						</select>
					</td>
				</tr>
				<tr id=white>
					<th width="20%">제목</th>
					<td width="80%">
						<input type="text" name="subject" class="notice-form-input" size="50" required
						ref="subject" v-model="subject">
					</td>
				</tr>
				<tr>
				    <th width="20%" style="vertical-align:middle;">파일 첨부</th>
				    <td width="80%" style="text-align:left;">
				        <div class="qna-checkbox-container">
				            <input type="checkbox" v-model="secret" :true-value="1" :false-value="0">
				        </div>
				        <label style="color: gray">&nbsp;기능 구현 예정</label>
				    </td>
				</tr>
				<tr>
					<th width="20%">내용</th>
					<td width="80%">
						<textarea rows="10" cols="50" name="content" class="notice-form-textarea" required
						v-model="content"></textarea>
					</td>
				</tr>
				<tr class="qnaBtns">
					<td colspan="2">
						<button class="notice-form-button" @click="boardInsert()">등록</button> 
						<input type="button" value="취소" class="notice-form-cancel-button" onclick="javascript:history.back()">
					</td>
				</tr>
			</table>
		</div>
	</div>
	<script>
		let insertApp=Vue.createApp({
			data() {
				return {
					subject: '',
					content: ''
				}
			},
			methods: {
				boardInsert() {
					axios.post('../notice/insert_vue.do', null, {
						params: {
							subject: this.subject,
							content: this.content
						}
					}).then(response => {
						console.log(response.data)
						location.href = '../notice/list.do'
					}).catch(error => {
						console.log(error.response)
					})
				}
			}
		}).mount('#insertApp')
	</script>
</body>
</html>