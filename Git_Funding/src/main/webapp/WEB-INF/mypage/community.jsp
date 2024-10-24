<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Community Posts</title>
<style>
    .myposts-wrapper {
        width: 800px;
        margin: 0 auto;
        padding: 20px;
        font-family: 'NEXON Lv2 Gothic';
    }
    .myposts-title {
        font-size: 24px;
        font-weight: bold;
        margin-bottom: 20px;
        text-align: center;
    }
    .myposts-list {
        border: 1px solid #e0e0e0;
        border-radius: 10px;
        padding: 15px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        background-color: #ffffff;
    }
    .mypost-item {
        padding: 10px 0;
        border-bottom: 1px solid #e0e0e0;
    }
    .mypost-item:last-child {
        border-bottom: none;
    }
    .post-title {
        font-size: 18px;
        font-weight: bold;
    }
    .post-date {
        font-size: 14px;
        color: #888;
    }
    .cate-label {
        display: inline-block;
        padding: 5px 10px;
        border-radius: 20px;
        font-size: 14px;
        font-weight: bold;
        margin-bottom: 10px;
    }
    /* 카테고리에 따른 라벨 색상 */
    .cate-label.의견 {
        background-color: #FFCC00;
        color: #000;
    }
    .cate-label.응원 {
        background-color: #33CC99;
        color: #fff;
    }
    .cate-label.리뷰 {
        background-color: #FF6666;
        color: #fff;
    }
    .funding-info {
        margin-top: 10px;
        font-size: 14px;
        color: #666;
    }
    .funding-info img {
        width: 50px;
        height: 50px;
        object-fit: cover;
        margin-right: 10px;
        vertical-align: middle;
    }
    .mypost-item .top {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
    }
    .mypost-actions {
        margin-top: 10px;
    }
    .mypost-button {
        padding: 8px 12px;
        border: 1px solid #e0e0e0;
        border-radius: 5px;
        background-color: #f9f9f9;
        cursor: pointer;
        transition: background-color 0.3s;
    }
    .mypost-button:hover {
        background-color: #f0f0f0;
    }

    /* Pagination Styling */
    .pagination {
        margin-top: 20px;
        text-align: center;
    }
    .pagination button {
        padding: 8px 12px;
        margin: 0 5px;
        border-radius: 5px;
        border: 1px solid #e0e0e0;
        background-color: #f9f9f9;
        cursor: pointer;
        transition: background-color 0.3s;
    }
    .pagination button:hover {
        background-color: #f0f0f0;
    }
    .pagination .active-btn {
        background-color: #33CC99;
        color: #fff;
        border: 1px solid #33CC99;
    }
    .pagination .inactive-btn {
        background-color: #f9f9f9;
        color: #000;
    }
    .pagination button:disabled {
        cursor: not-allowed;
        opacity: 0.5;
    }
</style>
</head>
<body>
    <div class="myposts-wrapper" id="myCommApp">
        <div class="myposts-title">나의 커뮤니티 활동</div>
        <div class="myposts-list">
            <div class="mypost-item" v-for="list in comm_list">
                <!-- 카테고리 라벨 -->
                <div :class="['cate-label', list.cate]">{{ list.cate }}</div>
                <!-- 게시글 내용 -->
                <div class="top">
                    <div>
                        <div class="post-title">{{list.content}}</div>
                        <div class="post-date">{{list.dbday}}</div>
                    </div>
                    <div class="mypost-actions">
                        <button class="mypost-button">삭제</button>
                    </div>
                </div>

                <!-- 펀딩 정보 -->
                <div class="funding-info">
                    <img :src="list.thumb" alt="funding thumbnail">
                    {{list.title}}
                </div>
            <!-- Pagination -->
            </div>
			<div class="pagination">
			    <!-- 이전 버튼 -->
			    <button v-if="curpage > 1" @click="prev" :disabled="curpage === 1">이전</button>
			
			    <!-- 페이지 번호 버튼 -->
			    <button v-for="i in range(startPage, endPage)" 
			            :class="{ 'active-btn': i === curpage, 'inactive-btn': i !== curpage }" 
			            @click="pageChange(i)">
			        {{ i }}
			    </button>
			
			    <!-- 다음 버튼 -->
			    <button v-if="curpage < totalpage" @click="next" :disabled="curpage === totalpage">다음</button>
			</div>

        </div>
    </div>

    <script>
        let myCommApp = Vue.createApp({
            data() {
                return {
                    comm_list: [],
                    curpage: 1,
                    totalpage: 0,
                    startPage: 0,
                    endPage: 0,
                    count: 0
                };
            },
            mounted() {
                this.dataRecv();
            },
            methods: {
                dataRecv() {
                    axios.get('../mypage/community_vue.do', {
                        params: {
                            page: this.curpage
                        }
                    }).then(res => {
                        console.log(res.data);
                        this.comm_list = res.data.list;
                        this.curpage = res.data.curpage;
                        this.totalpage = res.data.totalpage;
                        this.startPage = res.data.startPage;
                        this.endPage = res.data.endPage;
                        this.count = res.data.count;
                    }).catch(error => {
                        console.log(error.response);
                    });
                },
                range(start, end) {
                    let arr = [];
                    for (let i = start; i <= end; i++) {
                        arr.push(i);
                    }
                    return arr;
                },
                pageChange(page) {
                    this.curpage = page;
                    this.dataRecv();
                },
                prev() {
                    if (this.startPage > 1) {
                        this.curpage = this.startPage - 1;
                        this.dataRecv();
                    }
                },
                next() {
                    if (this.endPage < this.totalpage) {
                        this.curpage = this.endPage + 1;
                        this.dataRecv();
                    }
                }
            }
        }).mount('#myCommApp');
    </script>
</body>
</html>