<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
body {
	font-family: 'NexonLv2Gothic';
}
.qna-input {
	width: 600px;
	margin: 0 auto;
	font-family: 'NexonLv2Gothic';
}
.qna-input>h1{
	text-align: center;
	font-size: 30px;
	font-family: 'NexonLv2Gothic';
    margin-bottom: 20px;
    color: #333;
    border-bottom: 5px solid #f8c200;
    padding-bottom: 10px;
    text-align: center;
}
.qna-form {
	height : 500px;
	text-align: center;
}
.qna-table {
	width: 100%;
    border-collapse: collapse;
}
.qna-table th, .qna-table td {
    padding: 15px;
    text-align: left;
    border-bottom: 1px solid #ddd;
}
.qna-table th {
    vertical-align: middle;
}
.qna-tablee th {
    background-color: rgb(78, 107, 63);
    color: white;
    font-weight: bold;
}
.qna-form input, .qna-form textarea, .qna-form select {
    width: 100%;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 5px;
    box-sizing: border-box;
    font-size: 14px;
}
.qna-form button {
    border: none;
    background-color: #f8c200;
    color: white;
    padding: 10px 20px;
    cursor: pointer;
    border-radius: 5px;
    font-size: 14px;
    margin: 5px;
    width: 80px;
}
.qna-form input[type="button"]{
    border: none;
    background-color: gray;
    color: white;
    padding: 10px 20px;
    cursor: pointer;
    border-radius: 5px;
    font-size: 14px;
    margin: 5px;
    width: 80px;
}
.qnaBtns>td{
	text-align: center;
}
.qna-checkbox-container {
    display: inline-flex;
    align-items: center;
    gap: 5px;
}
.qna-checkbox-container input[type="checkbox"] {
    margin: 0;
}
</style>
</head>
<body>
	<div class="qna-input" id="updateApp">
		<h1>문의 수정</h1>
		<div class="qna-form">
			<table class="qna-table">
				<tr>
					<th width="20%">구분</th>
					<td width="80%">
					<select name="type" class="qna-select" v-model="type">
					    <option value="1">사이트</option>
					    <option value="2">펀딩</option>
					    <option value="3">상품</option>
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
					<th width="20%">내용</th>
					<td width="80%">
						<textarea rows="10" cols="50" name="content" class="notice-form-textarea" required
						v-model="content"></textarea>
					</td>
				</tr>
				<tr>
				    <th width="20%" style="vertical-align: middle;">비밀글</th>
				    <td width="80%" style="text-align: left;">
				        <div class="qna-checkbox-container">
				            <input type="checkbox" v-model="secret" :true-value="1" :false-value="0">
				        </div>
				        <label style="color: gray">&nbsp;[체크 시 문의가 비밀글로 작성됩니다]</label>
				    </td>
				</tr>
				<tr class="qnaBtns">
					<td colspan="2">
						<button class="notice-form-button" @click="qnaUpdate()">수정</button> 
						<input type="button" value="취소" class="notice-form-cancel-button" onclick="javascript:history.back()">
					</td>
				</tr>
			</table>
		</div>
	</div>
	<script>
		let updateApp=Vue.createApp({
			data(){
				return {
					qno:${qno},
					subject:'',
					content:'',
					type:0,
					secret:0
				}
			},
			mounted(){
				axios.get('../community/qna_update_vue.do',{
					params:{
						qno:this.qno
					}
				}).then(res=>{
					console.log(res.data)
					this.subject=res.data.subject
					this.content=res.data.content
					this.type=res.data.type
					this.secret=res.data.secret
				}).catch(error=>{
					console.log(error.response)
				})
			},
			methods:{
				qnaUpdate(){
					if(this.subject===""){
						this.$refs.subject.focus()
						return
					}
					if(this.content===""){
						this.$refs.content.focus()
						return
					}
					
					axios.post('../community/qna_update_ok_vue.do',null,{
						params:{
							qno:this.qno,
							subject:this.subject,
							content:this.content,
							type:this.type,
							secret:this.secret
						}
					}).then(res=>{
						console.log(res.data)
						if(res.data==="yes"){
							alert("글이 수정되었습니다!")
							location.href="../community/qna_detail.do?qno="+this.qno
						}else{
							alert(res.data)
						}
					}).catch(error=>{
						console.log(error.response)
					})
				}
			}
		}).mount('#updateApp')
	</script>
</body>
</html>