<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="../css/wonjin_reward_detail.css">
</head>
<body>
	<div class="PageWrapper">
		<section class="LeftContainer">
		</section>
		<section class="RightContainer">
			<section class="RightTop">
			</section>
			<section class="RightBottom">
				<div class="RightBottomTopContainer">
					<h2>리워드 목록</h2>
					<button>리워드 추가</button>
				</div>
				<div class="RewardPrintContainer" v-for="vo in reward_detail_list">
					<div class="Reward1st">
						<span>{{vo.price}}</span>
						<span>{{vo.amount}}어마운트</span>
						<span>{{vo.name}}네임</span>
					</div>
					<div class="Reward2nd">
						<span>리워드 구성 : {{vo.discription}}디스크립션</span>
					</div>
					<div class="Reward3rd">
						<span>배송비 {{vo.delivery}}딜리버리</span>
					</div>
					<div class="Reward4th">
						<span>발송 시작일 {{vo.del_start}}딜_스타트</span>
					</div>
					<div class="Reward5th">
						<span>제한 수량 {{vo.limit}}리미트</span>
					</div>
				</div>
			</section>
		</section>
	</div>
	<script>
		let detail_listApp = Vue.createApp({
			data() {
				return {
					fno : '${fno}',
					reward_detail_list : []
				}
			},
			mounted() {
				this.dataRecv()
			},
			methods: {
				dataRecv() {
					axios.get('../project/reward_detail_vue.do', {
						params : {
							fno : this.fno
						}
					}).then(response => {
						console.log(response.data)
						
						this.reward_detail_list = response.data
					}).catch(error => {
						console.log(error.response)
					})
				}
			}
		}).mount('.PageWrapper')
	</script>
</body>
</html>