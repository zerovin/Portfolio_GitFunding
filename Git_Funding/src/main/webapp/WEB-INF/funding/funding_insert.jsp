<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<section class="CreateFunding" id="CreateFunding">
		<h2>${sesionScope.userId}님 반가워요!</h2>
		<p>성공적인 프로젝트가 될 수 있도록 깃펀딩이 함께합니다.</p>
		<div class="SelectTypeContaoiner">
			<h4>프로젝트 제목</h4>
				<p>프로젝트 제목을 작성해주세요. 눈에 띄고 강한 인상을 남길 수록 이용자들의 시선을 끌 수 있습니다!</p>
				<div>
					<textarea rows="50" cols="10" name="FundingTitle" class="FundingTitleTA" 
								requiredv-model="title"></textarea>
				</div>
			<h4>카테고리 선택</h4>
				<p>카테고리를 선택해주세요</p>
				<div>
					<select name="type" class="SelectType" v-model="select_type">
						<option v-for="option in types" :value="option.value" :key="option.value">
				            {{ option.label }}
				        </option>
					</select>
				</div>
			<h4>대표 이미지</h4>
				<p>대표 이미지를 등록해주세요</p>
				<div>
				</div>
			<h4>리워드 설정</h4>
				<p>리워드를 설정해주세요</p>
				<div>
					<p>정렬 순서</p>
					<p>혜택이 좋은 순서대로 등록해 주세요.</p>
					<p>제한 수량이 모두 소진된 리워드는 설정한 순서와 상관없이 리워드 목록 최하단에 노출돼요.</p>
					<p>제한 수량</p>
					<p>각 리워드별 제공할 수 있는 수량을 입력해 주세요.</p>
					<p>제한된 수량이 모두 소진되면 이 리워드를 선택할 수 없어요.</p>
					<p>옵션 조건</p>
					<p>사이즈, 색상 등의 옵션 설정이 필요하면 추가해 주세요.</p>
					<p>주의 사항</p>
					<p>펀딩 프로젝트의 경우 판매된 적 있는 제품∙서비스∙콘텐츠는 반드시 첫 출시 리워드와 세트로 구성해 주세요.</p>
					<p>자사몰 및 다른 채널에서 판매된 적 있는 리워드는 단독 리워드로 제공할 수 없어요.</p>
				</div>
				<div>
					<button>리워드를 추가해주세요.</button>
				</div>
			<h4>메이커 정보</h4>
				<p>메이커 명</p>
				<div>
					<textarea rows="50" cols="10" name="FundingTitle" class="FundingTitleTA" 
								requiredv-model="title"></textarea>
				</div>
			<h4>메이커 프로필 이미지</h4>
				<div>
					<button>등록하기</button>
				</div>
		</div>
		<button class="GoToFundingOptionBtn" @click="GoToFundingOption()">펀딩 만들기</button>
	</section>
	<script>
		let CreateProject = Vue.createApp({
			data() {
				return {
					select_type: null,
                    types: []
				}
			},
			mounted() {
				this.dataRecv()
			},
			methods: {
				dataRecv() {
                    axios.post('../project/create_project_vue.do', null, {
                    	
                    }).then(response => {
                    	this.types = response.data
                    }).catch(error => {
                        console.error("Error fetching types:", error)
                    })
				},
				
			}
		}).mount('#CreateProject');
	</script>
</body>
</html>