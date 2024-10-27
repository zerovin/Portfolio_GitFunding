<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<link rel="stylesheet" href="../css/project_reward_insert">
<script src="https://cdn.jsdelivr.net/npm/vue@3"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<style>
		.RewardContainer {
			width: 500px;
			margin: 50px auto;
			padding: 30px;
			border: 1px solid #e0e0e0;
			border-radius: 10px;
			box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
			background-color: #ffffff;
			font-family: 'NEXON Lv2 Gothic';
			text-align: center;
		}

		.RewardContainer h2 {
			font-size: 24px;
			font-weight: bold;
			color: #333;
			margin-bottom: 20px;
		}

		.PriceContainer, .NameContainer, .LabelContainer, .DescriptionContainer, .DeliveryContainer, .del_startContainer {
			margin-bottom: 20px;
			text-align: left;
		}

		.RewardContainer label {
			font-size: 16px;
			font-weight: bold;
			color: #555;
			display: block;
			margin-bottom: 5px;
		}

		.RewardContainer input {
			width: 100%;
			padding: 10px;
			border: 1px solid #ccc;
			border-radius: 5px;
			box-sizing: border-box;
			font-size: 16px;
			background-color: #f9f9f9;
			transition: border-color 0.3s;
		}

		.RewardContainer input:focus {
			border-color: #f8c200;
			outline: none;
		}

		.ButtonContainer {
			display: flex;
			gap: 10px;
			margin-top: 20px;
		}

		.SubmitButton {
			flex: 1;
			padding: 12px;
			font-size: 18px;
			font-weight: bold;
			color: #fff;
			background-color: #f8c200;
			border: none;
			border-radius: 5px;
			cursor: pointer;
			transition: background-color 0.3s;
		}

		.SubmitButton:hover {
			background-color: #e0a800;
		}

		.CancelButton {
			flex: 1;
			padding: 12px;
			font-size: 18px;
			font-weight: bold;
			color: #fff;
			background-color: #e57373; /* 연한 붉은 계열 */
			border: none;
			border-radius: 5px;
			cursor: pointer;
			transition: background-color 0.3s;
		}

		.CancelButton:hover {
			background-color: #d32f2f;
		}

		@media (max-width: 600px) {
			.RewardContainer {
				width: 90%;
				padding: 20px;
			}

			.RewardContainer h2 {
				font-size: 20px;
			}

			.RewardContainer button {
				font-size: 16px;
			}
		}
	</style>
</head>
<body>
	<div id="AddReward">
		<div class="RewardContainer">
			<h2>리워드 등록</h2>
			<div class="PriceContainer">
				<label>가격을 입력하세요:</label>
				<input type="number" v-model="price" placeholder="가격" required>
			</div>
			<div class="NameContainer">
				<label>리워드명을 입력하세요:</label>
				<input type="text" v-model="name" placeholder="리워드명" required>
			</div>
			<div class="LabelContainer">
				<label>수량을 입력하세요:</label>
				<input type="number" v-model="limit" placeholder="수량" required>
			</div>
			<div class="DescriptionContainer">
				<label>구성을 입력하세요:</label>
				<input type="text" v-model="description" placeholder="구성" required>
			</div>
			<div class="DeliveryContainer">
				<label>배송비 입력하세요:</label>
				<input type="number" v-model="delivery" placeholder="배송비" required>
			</div>
			<div class="del_startContainer">
				<label>발송 시작일을 입력하세요:</label>
				<input type="date" v-model="del_start" required>
			</div>
			<div class="ButtonContainer">
				<button class="SubmitButton" @click="submitReward">등록하기</button>
				<button class="CancelButton" onclick="window.history.back()">취소</button>
			</div>
		</div>
	</div>

	<script>
		let addrewardApp = Vue.createApp({
			data() {
				return {
					fno: ${fno},
					userId: '${userId}',
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
						price: this.price,
						limit: this.limit,
						description: this.description,
						delivery: this.delivery,
						del_start: this.del_start,
						name: this.name,
						fno: this.fno
					}
					axios.post('../project/reward_insert_vue.do', null, {
						params: RewardVO
					}).then(response => {
						console.log(response.data);
						if (response.data === "yes") {
							alert("리워드가 등록되었습니다.");
							location.href = '../project/reward_detail.do?fno=' + this.fno;
						} else {
							alert("리워드 등록에 실패했습니다: " + response.data);
						}
					}).catch(error => {
						console.error(error);
						alert("오류가 발생했습니다.");
					})
				}
			}
		}).mount('#AddReward');
	</script>
</body>
</html>