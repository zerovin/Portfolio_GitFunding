<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../css/create_project.css">
</head>
<body>
    <section id="CreateProject">
        <div class="FundingProjectContainer">
            <h2 class="FundingProjectH2">펀딩 프로젝트 생성</h2>
            <button class="GoToFundingProjectBtn" @click="GoToFundingProjectPage()">펀딩 프로젝트 만들러 가기</button>
	            <p><i class="fa-solid fa-circle"></i> 어디에도 판매된 적 없는 제품·서비스·콘텐츠를 </p>
	            <p><i class="fa-solid fa-circle"></i> 깃펀딩에서 처음 공개합니다.</p>
				<p><i class="fa-solid fa-circle"></i> 자사몰이나 다른 채널에서 한 번도 판매된 적 없는 리워드예요.</p>
				<p><i class="fa-solid fa-circle"></i> 이것만은 챙겨가세요!</p>
				<p><i class="fa-solid fa-circle"></i> 10대여도, 유명하지 않은 로컬 브랜드여도 와디즈에서</p>
				<p><i class="fa-solid fa-circle"></i> 펀딩으로 성공한 사례도 많아요.</p>
				<p><i class="fa-solid fa-circle"></i> 내가 정말 와디즈에 도전해도 될까? 성공할 수 있을까?</p>
				<p><i class="fa-solid fa-circle"></i> 망설이지 말고 도전해 보세요.</p>
        </div>
        
        <div class="StoreProjectContainer">
            <h2 class="StoreProjectH2">스토어 프로젝트 생성</h2>
            <button class="GoToStoreProjectBtn" @click="GoToStoreProjectPage()">스토어 프로젝트 만들러 가기</button>
	            <p><i class="fa-solid fa-circle"></i> 기존에 출시된 제품·서비스·콘텐츠를 와디즈에서 </p>
	            <p><i class="fa-solid fa-circle"></i> 특별한 혜택으로 공개해요.</p>
				<p><i class="fa-solid fa-circle"></i> 특별구성, 국내단독, 한정판 중 한 가지 혜택을 포함하고,</P>
				<p><i class="fa-solid fa-circle"></i> 서포터에게 와디즈만의 혜택을 제공해야 해요.</p>
				<p><i class="fa-solid fa-circle"></i> 국내단독은 프로젝트 성공 후 일부 금액을 선정산 받을 수 있고,</p>
				<p><i class="fa-solid fa-circle"></i> 특별구성·한정판은 배송 및 환불 완료 후 정산받을 수 있어요.</p>
				<p><i class="fa-solid fa-circle"></i> 아래 3가지 혜택 중 1가지 이상의 혜택을 반드시 포함해야 해요.</p>
				<p><i class="fa-solid fa-circle"></i> 국내 단독 / 특별 구성 / 한정판</p> 
        </div>
    </section>
    <script>
        let CreateProjectApp = Vue.createApp({
            data() {
                return {}
            },
            mounted() {},
            methods: {
                GoToFundingProjectPage() {
                    location.href = '../project/create_funding.do'
                },
                GoToStoreProjectPage() {
                    location.href = '../project/create_store.do'
                }
            }
        }).mount('#CreateProject')
    </script>
</body>
</html>