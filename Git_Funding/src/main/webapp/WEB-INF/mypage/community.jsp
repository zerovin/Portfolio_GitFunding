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
    	margin-top: 10px;
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
	    background-color: #f5f5f5; /* 연한 회색 배경 */
	    padding: 12px; /* 내부 여백 */
	    border-radius: 5px; /* 둥근 테두리 */
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
    .delete-popup-overlay {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-color: rgba(0, 0, 0, 0.5);
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 1000;
	}
	
	.delete-popup {
	    background-color: #fff;
	    padding: 20px;
	    border-radius: 10px;
	    text-align: center;
	    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
	}
	
	.popup-buttons button {
	    padding: 10px 20px;
	    margin: 5px;
	    border: none;
	    border-radius: 5px;
	    cursor: pointer;
	}
	
	.popup-buttons button:first-child {
	    background-color: #FF6666;
	    color: #fff;
	}
	
	.popup-buttons button:last-child {
	    background-color: #ccc;
	    color: #000;
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
                        <button class="mypost-button" @click="showDeleteConfirm(list.dcno)">삭제</button>
                    </div>
                </div>

                <!-- 펀딩 정보 -->
                <div class="funding-info" @click="Fdetail(list.fno)" style="cursor: pointer;">
                    <img :src="list.thumb" alt="funding thumbnail">
                    {{list.title}}
                </div>
            <!-- Pagination -->
            </div>
			<div class="pagination">
				<button v-if="startPage > 1" @click="prev"
					:class="{'inactive-btn': curpage !== startPage}">이전</button>

				<button v-for="i in range(startPage, endPage)"
					:class="{ 'active-btn': i === curpage, 'inactive-btn': i !== curpage }"
					@click="pageChange(i)">{{ i }}</button>

				<button v-if="endPage < totalpage" @click="next"
					:class="{'inactive-btn': curpage !== endPage}">다음</button>
			</div>
			<div v-if="showDeletePopup" class="delete-popup-overlay">
				<div class="delete-popup">
					<p>삭제하시겠습니까?</p>
					<div class="popup-buttons">
						<button @click="confirmDelete">네</button>
						<button @click="cancelDelete">아니오</button>
					</div>
				</div>
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
                count: 0,
                delete_dcno: 0,
                showDeletePopup: false  
            };
        },
        mounted() {
            this.dataRecv()
        },
        methods: {
            dataRecv() {
                axios.get('../mypage/community_vue.do', {
                    params: {
                        page: this.curpage
                    }
                }).then(res => {
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
            },
            Fdetail(fno) {
                location.href = "../funding/funding_detail.do?fno=" + fno;
            },
            showDeleteConfirm(dcno) {
                this.delete_dcno = dcno
                this.showDeletePopup = true
            },
            confirmDelete() {
                axios.get('../funding/comm_delete.do', {
                    params: {
                        dcno: this.delete_dcno
                    }
                }).then(response => {
                    if (response.data === 'ok') {
                        alert("삭제되었습니다!")
                        this.dataRecv()
                    } else {
                        console.log(response.data)
                    }
                    this.showDeletePopup = false
                }).catch(error => {
                    console.log(error.response);
                    this.showDeletePopup = false
                })
            },
            cancelDelete() {
                this.showDeletePopup = false
            }
        }
    }).mount('#myCommApp')
    </script>
</body>
</html>