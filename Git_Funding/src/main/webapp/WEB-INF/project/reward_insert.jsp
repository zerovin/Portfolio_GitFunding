<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<link rel="stylesheet" href="../css/main.css">
<script src="https://cdn.jsdelivr.net/npm/vue@3"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
</head>
<body>
	<div id="AddReward">
		<h2>리워드 등록</h2>
		<div>
			<label>가격을 입력하세요:</label>
			<input type="number" v-model="price" placeholder="가격" required>
		</div>
		<div>
			<label>리워드명을 입력하세요:</label>
			<input type="text" v-model="name" placeholder="리워드명" required>
		</div>
		<div>
			<label>수량을 입력하세요:</label>
			<input type="number" v-model="limit" placeholder="수량" required>
		</div>
		<div>
			<label>구성을 입력하세요:</label>
			<input type="text" v-model="description" placeholder="구성" required>
		</div>
		<div>
			<label>배송비 입력하세요:</label>
			<input type="number" v-model="delivery" placeholder="배송비" required>
		</div>
		<div>
			<label>발송 시작일을 입력하세요:</label>
			<input type="date" v-model="del_start" required>
		</div>
		<button @click="submitReward">등록하기</button>
	</div>

	<script>
		let addrewardApp = Vue.createApp ({
			data() {
				return {
					fno : ${fno},
					userId : '${userId}',
						price: '',
						limit: '',
						description: '',
						delivery: '',
						del_start: '',
						name: ''
				}
			},
			methods: {
				submitReward() {
					const RewardVO = {
							price		: this.price,
							limit		: this.limit,
							description	: this.description,
							delivery	: this.delivery,
							del_start	: this.del_start,
							name		: this.name,
							fno 		: this.fno
					}
					axios.post('../project/reward_insert_vue.do', null, {
						params: RewardVO
					}).then(response => {
						console.log(response.data);
						if (response.data === "yes") {
							alert("리워드가 등록되었습니다.")
							location.href = '../project/reward_detail.do?fno=' + this.fno
						} else {
							alert("리워드 등록에 실패했습니다: " + response.data);
						}
					}).catch(error => {
						console.error(error);
						alert("오류가 발생했습니다.")
					})
				}
			}
		}).mount('#AddReward');
	</script>
</body>
</html>
