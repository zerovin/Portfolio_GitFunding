<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
        .inquiries-wrapper {
            width: 800px;
            margin: 0 auto;
            padding: 20px;
            font-family: 'NEXON Lv2 Gothic';
        }
        .inquiries-title {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 20px;
            text-align: center;
        }
        .inquiries-list {
            border: 1px solid #e0e0e0;
            border-radius: 10px;
            padding: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            background-color: #ffffff;
        }
        .inquiry-item {
            padding: 10px 0;
		    border-bottom: 1px solid #e0e0e0;
		    display: flex;
		    justify-content: space-between;
		    align-items: center;
		    gap: 10px;
        }
        .inquiry-item:last-child {
            border-bottom: none;
        }
        .inquiry-info {
            display: flex;
            flex-direction: column;
            flex-grow: 1;
        }
        .inquiry-title, .inquiry-date {
            font-size: 16px;
            margin-bottom: 5px;
        }
        .inquiry-title {
            font-weight: bold;
        }
        .inquiry-date {
            color: #888;
        }

        /* Tag styles for type */
        .inquiry-type-tag {
            padding: 5px 10px;
            border-radius: 5px;
            color: white;
            font-size: 14px;
            font-weight: bold;
        }
        .tag-site {
            background-color: #007BFF; /* 사이트 색상 */
            width: 41px;
            text-align: center;
            text-align: center;
        }
        .tag-funding {
            background-color: #28A745; /* 펀딩 색상 */
            width: 41px;
            text-align: center;
        }
        .tag-product {
            background-color: #f29886; /* 상품 색상 */
            width: 41px;
            text-align: center;
        }

        .inquiry-status {
            padding: 8px 12px;
            border-radius: 5px;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s;
            font-size: 14px;
        }
        .status-complete {
            background-color: #FFCC00;
            color: white;
        }
        .status-waiting {
            background-color: #e9e9e9;
            color: #000;
        }
        .inquiry-status:hover {
            opacity: 0.9;
        }
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
        background-color: #FFCC00;
        color: #fff;
        border: 1px solid #FFCC00;
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
    <div class="inquiries-wrapper" id="myQnaApp">
        <div class="inquiries-title">나의 문의 내역</div>
        <div class="inquiries-list" v-for="list in qna_list">
            <div class="inquiry-item">
                <span v-if="list.type===1" class="inquiry-type-tag tag-site">사이트</span>
                <span v-if="list.type===2" class="inquiry-type-tag tag-funding">펀딩</span>
                <span v-if="list.type===3" class="inquiry-type-tag tag-product">상품</span>
                <div class="inquiry-info">
                    <div class="inquiry-title">{{list.subject}}</div>
                    <div class="inquiry-date">{{list.dbday}}</div>
                </div>
                <button v-if="list.reok===1" class="inquiry-status status-complete" @click="QnaDetail(list.qno)">답변 완료</button>
                <button v-else  class="inquiry-status status-waiting" @click="QnaDetail(list.qno)">답변 대기</button>
            </div>
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
    </div>
    <script>
    	let myQnaApp=Vue.createApp({
    		data() {
    			return {
    				qna_list:[],
    				curpage:1,
    				totalpage:0,
    				startPage:0,
    				endPage:0,
    				count:0
    			}
    		},
    		mounted(){
    			this.dataRecv()
    		},
    		methods:{
    			dataRecv() {
    				axios.get('../mypage/qna_vue.do',{
    					params:{page:this.curpage}
    				}).then(res=>{
    					console.log(res.data)
    					this.qna_list = res.data.list
    					this.curpage = res.data.curpage
    					this.totalpage = res.data.totalpage
    					this.startPage = res.data.startPage
    					this.endPage = res.data.endPage
    					this.count = res.data.count
    				}).catch(error=>{
    					console.log(error.response)
    				})
    			},
    			range(start,end) {
    				let arr = []
    				for(let i=start;i<=end;i++){
    					arr.push(i)
    				}
    				return arr
    			},
    			pageChange(page) {
    				this.curpage=page
    				this.dataRecv()
    			},
    			prev() {
    				if(this.startPage>1) {
    					this.curpage=this.startPage-1
    					this.dataRecv()
    				}
    			},
    			next() {
    				if(this.endPage<this.totalpage) {
    					this.curpage=this.endPage+1
    					this.dataRecv()
    				}
    			},
    			QnaDetail(qno) {
    				location.href='../community/qna_detail.do?qno='+qno
    			}
    		}
    	}).mount('#myQnaApp')
    </script>
</body>
</html>