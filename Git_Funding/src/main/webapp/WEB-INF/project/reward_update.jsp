<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<link rel="stylesheet" href="../css/project_reward_insert">
<script src="https://cdn.jsdelivr.net/npm/vue@3"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
</head>
<body>
	<div id="AddReward">
		<div class="RewardContainer">
			<h2>리워드 등록</h2>
			<div class="PriceContainer">
				<label>가격을 입력하세요:</label>
				<input type="number" v-model="price" required="required">
			</div>
			<div class="NameContainer">
				<label>리워드명을 입력하세요:</label>
				<input type="text" v-model="name" required="required">
			</div>
			<div class="LabelContainer">
				<label>수량을 입력하세요:</label>
				<input type="number" v-model="limit"  required="required">
			</div>
			<div class="DescriptionContainer">
				<label>구성을 입력하세요:</label>
				<input type="text" v-model="description" required="required">
			</div>
			<div class="DeliveryContainer">
				<label>배송비 입력하세요:</label>
				<input type="number" v-model="delivery" required="required">
			</div>
			<div class="del_startContainer">
				<label>발송 시작일을 입력하세요:</label>
				<input type="date" v-model="del_start" required="required">
			</div>
			<button @click="submitReward">등록하기</button>
		</div>
	</div>

	<script>
		let addrewardApp = Vue.createApp ({
			data() {
				return {
					rno 		: ${rno},
					userId 		: '${userId}',
					price		: '',
					limit		: '',
					description	: '',
					delivery	: '',
					del_start	: '',
					name		: '',
					fno			: 0
				}
			},
			mounted() {
				this.dataRecv()
			},
			methods: {
				dataRecv() {
					rno : this.rno
					axios.post('../project/reward_update_vue.do', null, {
						params: {rno : this.rno}
					}).then(response => {
						console.log(response.data)
					 	this.price = response.data.vo.price
						this.limit = response.data.vo.limit
						this.description = response.data.vo.description
						this.delivery = response.data.vo.delivery
						this.del_start = response.data.vo.del_start
						this.name = response.data.vo.name
						this.fno = response.data.vo.fno
					}).catch(error => {
						console.error(error);
						alert("오류가 발생했습니다.")
					})
				},
				submitReward() {
					const RewardVO = {
							price		: this.price,
							limit		: this.limit,
							description	: this.description,
							delivery	: this.delivery,
							del_start	: this.del_start,
							name		: this.name,
							rno 		: this.rno
					}
					console.log(RewardVO)
					axios.post('../project/reward_update_vue_ok.do', null, {
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
