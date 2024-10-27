<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<style>
		.PageWrapper {
			width: 1000px;
			margin: 0 auto;
			padding: 30px;
			font-family: 'NEXON Lv2 Gothic';
			background-color: #f9f9f9;
			border-radius: 10px;
			box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
		}

		.RewardHeader {
			display: flex;
			justify-content: space-between;
			align-items: center;
			margin-bottom: 20px;
		}

		.RewardHeader h2 {
			font-size: 24px;
			font-weight: bold;
			color: #333;
		}

		.AddRewardBtn {
			background-color: #4CAF50;
			color: #fff;
			padding: 10px 20px;
			border-radius: 5px;
			border: none;
			cursor: pointer;
			font-size: 14px;
			transition: background-color 0.3s;
		}

		.AddRewardBtn:hover {
			background-color: #45a049;
		}

		.RewardPrintContainer {
	display: inline-block;
    width: 800px;
    padding: 15px;
    margin: 15px;
    border: 1px solid #e0e0e0;
    border-radius: 10px;
    background-color: #ffffff;
    vertical-align: top;
		}

		.Reward1st {
			display: flex;
			justify-content: space-between;
			align-items: center;
			margin-bottom: 10px;
		}

		.RewardName {
			font-size: 18px;
			font-weight: bold;
			color: #333;
		}

		.RewardPrice, .RewardAmount {
			font-size: 16px;
			color: #666;
			margin-top: 5px;
		}

		.Reward1stTopBtnBox {
			display: flex;
			gap: 10px;
		}

		.RewardUpBtn, .RewardDelBtn {
			background-color: #f0f0f0;
			color: #333;
			padding: 6px 12px;
			border-radius: 5px;
			border: 1px solid #ccc;
			cursor: pointer;
			font-size: 14px;
			transition: background-color 0.3s;
		}

		.RewardUpBtn:hover {
			background-color: #f8c200;
			color: #fff;
		}

		.RewardDelBtn:hover {
			background-color: #ff6666;
			color: #fff;
		}

		/* 리워드 세부 정보 스타일 */
		.Reward2nd, .Reward3rd, .Reward4th, .Reward5th {
			padding: 6px 0;
			border-top: 1px solid #e0e0e0;
			color: #555;
		}

		.Reward2nd span, .Reward3rd span, .Reward4th span, .Reward5th span {
			display: inline-block;
			font-weight: 500;
			color: #444;
		}
	</style>
</head>
<body>
	<div class="PageWrapper">
		<div class="RewardHeader">
			<h2>리워드 목록</h2>
			<button class="AddRewardBtn" @click="NavToRewardInsert()">리워드 추가</button>
		</div>

		<div class="RewardPrintContainer" v-for="vo in reward_detail_list">
			<div class="Reward1st">
				<div>
					<p class="RewardName">{{vo.name}}</p>
					<p class="RewardPrice">가격 : {{vo.price}} 원</p>
					<p class="RewardAmount">남은 개수 : {{vo.amount}}</p>
				</div>
				<div class="Reward1stTopBtnBox">
					<button class="RewardUpBtn" @click="RewardUp(vo.rno)">수정</button>
					<button class="RewardDelBtn" @click="RewardDel(vo.rno)">삭제</button>
				</div>
			</div>
			<div class="Reward2nd">
				<span>리워드 구성 : {{vo.description}}</span>
			</div>
			<div class="Reward3rd">
				<span>배송비 : {{vo.delivery}} 원</span>
			</div>
			<div class="Reward4th">
				<span>발송 시작일 : {{vo.del_start}}</span>
			</div>
			<div class="Reward5th">
				<span>총 개수 : {{vo.limit}}</span>
			</div>
		</div>
	</div>

	<script>
		let detail_listApp = Vue.createApp({
			data() {
				return {
					fno: ${fno},
					reward_detail_list: []
				};
			},
			mounted() {
				this.dataRecv();
			},
			methods: {
				dataRecv() {
					axios
						.get("../project/reward_detail_vue.do", {
							params: {
								fno: this.fno,
							},
						})
						.then((response) => {
							this.reward_detail_list = response.data.list;
						})
						.catch((error) => {
							console.log(error.response);
						});
				},
				NavToRewardInsert() {
					location.href = "../project/reward_insert.do?fno=" + this.fno;
				},
				RewardUp(UpRno) {
					location.href = "../project/reward_update.do?rno=" + UpRno;
				},
				RewardDel(Rno) {
					if (confirm("정말로 삭제하시겠습니까?")) {
						axios
							.get("../project/reward_delete_vue.do", {
								params: { rno: Rno },
							})
							.then((response) => {
								if (response.data === "yes") {
									this.dataRecv();
								} else {
									alert("삭제 실패");
								}
							})
							.catch((error) => {
								console.log(error.response);
							});
					} else {
						alert("삭제를 취소합니다.");
					}
				},
			},
		}).mount(".PageWrapper");
	</script>
</body>
</html>