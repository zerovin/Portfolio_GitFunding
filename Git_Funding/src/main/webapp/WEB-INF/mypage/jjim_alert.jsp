<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 - 펀딩 목록</title>
</head>
<style>
.funding-list-wrapper {
	width:800px;
    margin: 20px auto;
    padding: 20px;
    background-color: #fff;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    border-radius: 8px;
    font-family: 'NEXON Lv2 Gothic';
}

.tabs {
    display: flex;
    justify-content: space-around;
    margin-bottom: 30px;
    border-bottom: 2px solid #ccc;
}

.tab {
    flex-grow: 1;
    text-align: center;
    padding: 15px;
    font-size: 18px;
    cursor: pointer;
    background-color: #f5f5f5;
    color: #333;
}

.tab.active {
    background-color: #F8C200;
    color: #fff;
}

.funding-item {
    display: flex;
    align-items: center;
    background-color: #fafafa;
    border: 1px solid #e0e0e0;
    padding: 15px;
    margin-bottom: 20px;
    border-radius: 8px;
}
.funding-item:hover {
	cursor: pointer;
	background-color: #e6e6e6; 
	
}

.funding-item img {
    width: 100px;
    height: 100px;
    border-radius: 8px;
    margin-right: 20px;
}

.funding-item-content {
    flex-grow: 1;
}

.funding-item h3 {
    margin: 0;
    font-size: 20px;
    color: #333;
}

.funding-item p {
    margin: 5px 0 0;
    color: #777;
    font-size: 14px;
}

.funding-item .meta-info {
    margin-top: 10px;
    font-size: 12px;
    color: #999;
}

.funding-item .btn {
    display: inline-block;
    padding: 10px 20px;
    background-color: #F8C200;
    color: #fff;
    text-decoration: none;
    border-radius: 4px;
    margin-left: 10px;
    cursor: pointer;
}

.funding-item .btn-cancel {
    background-color: #ff4d4d;
}
.title {
    white-space: pre-wrap;
    overflow: hidden;
    text-overflow: ellipsis;
}
.load-more {
    text-align: center;
    margin: 20px 0;
}

.load-more button {
    padding: 10px 20px;
    font-size: 16px;
    background-color: #F8C200;
    color: #fff;
    border: none;
    cursor: pointer;
    border-radius: 4px;
}
</style>
<body>
    <div id="listApp" class="funding-list-wrapper">
        <!-- 탭 UI -->
        <div class="tabs">
            <div :class="['tab', activeTab === '찜' ? 'active' : '']" @click="activeTab = '찜'; fetchData()">
                찜
            </div>
            <div :class="['tab', activeTab === '알림신청' ? 'active' : '']" @click="activeTab = '알림신청'; fetchData()">
                알림신청
            </div>
        </div>

        <!-- 찜 목록 -->
        <div v-if="activeTab === '찜'" class="funding-list">
        	<div style="text-align: center; margin-bottom: 20px">
			    <p style="font-size: 20px;">내가 찜한 
			        <span style="font-weight: bold; font-size: 24px; color: #FF5722;">${jjimCount}</span> 
			        개의 프로젝트
			    </p>
			</div>
            <div v-if="list.length > 0">
                <div v-for="item in visibleList" :key="item.id" class="funding-item" @click="detail(item.fno)">
                    <!-- 썸네일 이미지 -->
                    <img :src="item.thumb" alt="썸네일 이미지">

                    <div class="funding-item-content">
                        <h3 class="title">{{ item.title }}</h3>
                        <!-- dbday 출력 -->
                        <div class="meta-info">등록일: {{ item.dbday }}</div>
                    </div>

                    <!-- 취소 버튼 -->
                    <button class="btn btn-cancel" @click.stop="wishDelete(item.fno)">취소</button>
                </div>
                <div class="load-more" v-if="list.length > visibleItems">
                    <button @click="loadMore">더보기</button>
                </div>
            </div>
            <div v-else class="no-items">찜 목록이 없습니다!</div>
        </div>

        <!-- 알림신청 목록 -->
        <div v-if="activeTab === '알림신청'" class="funding-list">
	        <div style="text-align: center; margin-bottom: 20px">
			    <p style="font-size: 20px;">내가 알림 신청한 
			        <span style="font-weight: bold; font-size: 24px; color: red;">${AlertCount}</span> 
			        개의 프로젝트
			    </p>
			</div>
            <div v-if="list.length > 0">
                <div v-for="item in visibleList" :key="item.id" class="funding-item" @click="detail(item.fno)">
                    <!-- 썸네일 이미지 -->
                    <img :src="item.thumb" alt="썸네일 이미지">

                    <div class="funding-item-content">
                        <h3 class="title">{{ item.title }}</h3>
                        <div class="meta-info">등록일: {{ item.dbday }}</div>
                        <div class="meta-info" style="color: red;font-weight: bold;">펀딩 시작일: {{ item.startdate }}</div>
                    </div>

                    <!-- 취소 버튼 -->
                    <button class="btn btn-cancel" @click.stop="alertDelete(item.fno)">취소</button>
                </div>
                <div class="load-more" v-if="list.length > visibleItems">
                    <button @click="loadMore">더보기</button>
                </div>
            </div>
            <div v-else class="no-items">알림 내역이 없습니다!</div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/vue@3"></script>
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    <script>
        const listApp = Vue.createApp({
            data() {
                return {
                    activeTab: '찜',
                    list: [],
                    visibleItems: 4
                }
            },
            computed: {
                visibleList() {
                    return this.list.slice(0, this.visibleItems)
                }
            },
            mounted() {
                this.fetchData()
            },
            methods: {
                fetchData() {
                    let apiUrl = ''
                    if (this.activeTab === '찜') {
                        apiUrl = '../mypage/jjim_vue.do'
                    } else if (this.activeTab === '알림신청') {
                        apiUrl = '../mypage/alert_vue.do'
                    }
                    
                    axios.get(apiUrl)
                        .then(response => {
                            this.list = response.data
                        })
                        .catch(error => {
                            console.log(error.response)
                        })
                },
                loadMore() {
                    this.visibleItems += 4
                },
                wishDelete(fno){
       				axios.get('../wish/delete.do',{
       					params:{
       						fno:fno,
	   						cate:1
       					}
       				}).then(response=>{
       					if(response.data=="ok"){
       						alert("삭제되었습니다!!")
       						this.fetchData()
       					}else{
       						console.log(response.data)	
       					}
       				}).catch(error=>{
       					console.log(error.response)
       				})
    			},
                // 알림 취소
    			alertDelete(fno){
       				axios.get('../funding/alert_delete.do',{
       					params:{
       						fno:fno
       					}
       				}).then(response=>{
       					if(response.data=="ok"){
       						alert("삭제되었습니다!!")
       						this.fetchData()
       					}
       				}).catch(error=>{
       					console.log(error.response)
       				})
                },
                detail(fno){
                	window.location.href="../funding/funding_detail.do?fno="+fno
                }
            }
        }).mount('#listApp');
    </script>
</body>
</html>
