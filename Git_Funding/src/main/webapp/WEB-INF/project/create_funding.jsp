<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="../css/create_funding.css">
</head>
<body>
    <section class="CreateFunding" id="CreateFunding">
    	<div class="UserNameContainer">
	        <h2>${sessionScope.userId}님 반가워요!</h2>
	        <p>성공적인 프로젝트가 될 수 있도록 깃펀딩이 함께합니다.</p>
    	</div>
        <div class="CreateBodyContainer">
        	<div class="CreateBodyContainer2">
	        	<div class="SubjectContainer">
		            <h4>프로젝트 제목</h4>
		            <p>프로젝트 제목을 작성해주세요.</p>
		            <div class="subjectContainerTextArea">
		                <textarea rows="1" cols="60" v-model="title" required></textarea>
		            </div>
	        	</div>
				<div class="SelectCategoryContainer">
		            <h4>카테고리 선택</h4>
		            <p>카테고리를 선택해주세요</p>
		            <div class="SelectCategory">
		                <select v-model="select_type" required>
		                    <option v-for="option in types" :value="option.value" :key="option.value">
		                        {{ option.label }}
		                    </option>
		                </select>
		            </div>
				</div>
				<div class="UplodaThumContainer">
		            <h4>프로젝트의 대표 이미지</h4>
		            <p>대표 이미지를 등록해주세요</p>
		            <input type="file" @change="handleFileUpload" accept="image/*" required />
				</div>
				<div class="TargetPriceContainer">
		            <h4>목표 금액 설정</h4>
		            <input class="TargetPriceContainerinput" type="number" v-model="goalAmount" placeholder="목표 금액" required />			
				</div>
				<div class="AddRewardContainer">
		            <h4>리워드 설정</h4>
		            <p>리워드를 설정해주세요</p>
		            <div>
		                <button @click="addReward()create_funding">리워드를 추가해주세요.</button>
		            </div>
				</div>
				<div class="MakerInfoContainer">
		            <h4>메이커 정보</h4>
		            <p>메이커 명</p>
		            <div class="MakerInfoTextArea">
		                <textarea rows="1" cols="60" v-model="makerName" required></textarea>
		            </div>
				</div>
				<div class="InsertMakerImageContainter">
		            <h4>메이커 프로필 이미지</h4>
		            <input type="file" @change="handleMakerProfileUpload" accept="image/*" />	
				</div>
		
	            <button class="CreateFundingBtn" @click="create_funding()">펀딩 만들기</button>
          	</div>
        </div>
    </section>

    <script>
         let CreateProject = Vue.createApp({
             data() {
                 return {
                     select_type: null,
                     types: [],
                     title: '',
                     goalAmount: 0,
                     makerName: '',
                     projectThumbnail: null,
                     makerProfile: null
                 }
             },
             mounted() {
                 this.dataRecv()
             },
             methods: {
                 dataRecv() {
                     axios.post('../project/create_funding_vue.do', null,  {
                    	
                    	 	}).then(response => {
                             this.types = response.data
                         })
                         .catch(error => {
                             console.error("Error fetching types:", error)
                         })
                 },
                 handleFileUpload(event) {
                      this.projectThumbnail = event.target.files[0]
                  },
                 handleMakerProfileUpload(event) {
                     this.makerProfile = event.target.files[0]
                 },
                 create_funding() {
                     const formData = new FormData()
                     formData.append('FundingTitle', this.title)
                     formData.append('type', this.select_type)
                     formData.append('goalAmount', this.goalAmount)
                     formData.append('makerName', this.makerName)
                     if (this.projectThumbnail) {
                         formData.append('files', this.projectThumbnail)
                     }
                     if (this.makerProfile) {
                         formData.append('makerProfile', this.makerProfile)
                     }

                     axios.post('../project/create_funding.do', formData, {
                         headers: {
                             'Content-Type': 'multipart/form-data'
                         }
                     })
                     .then(response => {
                         console.log("Project created successfully:", response.data)
                     })
                     .catch(error => {
                         console.error("Error creating project:", error)
                     })
                 },
                 addReward() {
                      리워드 추가 로직을 여기에 구현
                 }
            }
         }).mount('#CreateFunding')
    </script>
</body>
</html>