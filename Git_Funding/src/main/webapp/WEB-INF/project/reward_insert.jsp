<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="AddReward">
		<h2>리워드 등록</h2>
		<div class="">
			<textarea rows="1" cols="1">가격을 입력하세요 : </textarea>
		</div>
		<div class="">
			<textarea rows="1" cols="1">수량을 입력하세요 : </textarea>
		</div>
		<div class="">
			<textarea rows="1" cols="1">구성을 입력하세요 : </textarea>
		</div>
		<div class="">
			<textarea rows="1" cols="1">배송비 입력하세요 : </textarea>
		</div>
		<div class="">
			<textarea rows="1" cols="1">발송 시작일을 입력하세요 : </textarea>
		</div>
	</div>
	<script>
		let addrewardApp = Vue.createApp ({
			data() {
				return {
					fno : '',
				}
			},
			mounted() {
				
			},
			methods: {
				
			}
		}).mount('#AddReward')
	</script>
</body>
</html>