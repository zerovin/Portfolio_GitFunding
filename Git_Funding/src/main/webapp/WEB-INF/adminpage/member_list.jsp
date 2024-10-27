<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 목록</title>
<script src="https://cdn.jsdelivr.net/npm/vue@3"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
</head>
<body>
	<div class="page_wrapper" id="listApp">
		<section class="top_area">
			<h1>회원 목록</h1>
		</section>
		<section class="bottom_area">
			<table border="1">
				<thead>
					<tr>
						<th>아이디</th>
						<th>이름</th>
						<th>이메일</th>
						<th>연락처</th>
						<th>성별</th>
						<th>주소</th>
						<th>닉네임</th>
					</tr>
				</thead>
				<tbody>
					<tr v-for="member in memberList" :key="member.userId">
						<td>{{ member.userId }}</td>
						<td>{{ member.userName }}</td>
						<td>{{ member.email }}</td>
						<td>{{ member.phone }}</td>
						<td>{{ member.gender }}</td>
						<td>{{ member.addr1 }} {{ member.addr2 }}</td>
						<td>{{ member.nickname }}</td>
					</tr>
				</tbody>
			</table>
		</section>
	</div>
	<script>
		Vue.createApp({
			data() {
				return {
					memberList: []
				}
			},
			mounted() {
				this.dataRecv();
			},
			methods: {
				dataRecv() {
					axios.get('../adminpage/member_list_vue.do')
					.then(response => {
						console.log(response.data);
						this.memberList = response.data;
					}).catch(error => {
						console.error(error);
					});
				}
			}
		}).mount('#listApp')
	</script>
</body>
</html>
