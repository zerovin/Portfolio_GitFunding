<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>구매 목록</title>
    <style>
     .no-purchases {
            text-align: center;
            padding: 40px 0;
            font-size: 20px;
            color: #888;
            font-weight: bold;
        }

        .no-purchases-icon {
            font-size: 50px;
            color: #f8c200;
            margin-bottom: 10px;
        }
        .purchase-list {
            width: 800px;
            margin: 0 auto;
            padding: 20px;
            font-family: 'NEXON Lv2 Gothic';
        }

        .purchase-table {
            width: 100%;
            max-width : 800px;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        .purchase-table th, .purchase-table td {
            border: 1px solid #ddd;
            padding: 12px;
        }

        .purchase-table th {
            background-color: #f8c200;
            color: white;
        }

        .purchase-table td {
            vertical-align: middle;
            white-space: nowrap;
            max-width: 400px;
    		overflow: hidden;
    		text-overflow: ellipsis;
            
        }
        .purchase-table tr:hover {
            background-color: #f2f2f2;
            cursor: pointer;
            
        }

        .purchase-table img {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 5px;
        }

        .detail-info {
            background-color: #f9f9f9;
            padding: 15px;
            margin-top: 5px;
            border-left: 3px solid #ffa500;
            transition: all 0.3s ease;
        }

        .detail-info td {
            padding: 15px;
        }

        .detail-box {
            background-color: #fff;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            margin-top: 10px;
        }

        .detail-box .info-item {
            display: block;
            justify-content: space-between;
            margin-bottom: 10px;
            border-bottom: 1px solid #eee;
            padding-bottom: 10px;
        }

        .detail-box .info-label {
            font-weight: bold;
            margin-right: 15px;
            color: #555;
        }

        .detail-box .info-value {
            color: #333;
        }

        .pagination {
            text-align: center;
            margin-top: 20px;
        }

        .pagination a {
            margin: 0 5px;
            padding: 10px 15px;
            background-color: #f8c200;
            color: white;
            border-radius: 5px;
            text-decoration: none;
        }

        .pagination a:hover {
            background-color: #e0a800;
        }
        #fundingtext {
        	font-size: 30px;
    text-align: center;
    font-weight: 400;
    margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <div id="purchaseApp" class="purchase-list">
        <h2 id="fundingtext">상품 주문 내역</h2>
        <div v-if="purchases.length === 0" class="no-purchases">
            <div class="no-purchases-icon">🛒</div>
            주문 내역이 없습니다!!
        </div>
        <table v-else class="purchase-table">
            <thead>
                <tr>

                    <th>주문 번호</th>
                    <th>총 가격</th>
                    <th>주문 날짜</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="purchase in purchases" @click="fetchPurchaseDetail(purchase.fgono)">

                    <td style="text-align: center;">{{ purchase.fgono }}</td>
                    <td>{{ purchase.payment }}원</td>
                    <td>{{ purchase.dbday }}</td>
                </tr>
            </tbody>
        </table>

        <!-- 클릭 시 상세 정보 출력 -->
        <div id="detailSection" v-if="selectedPurchase" class="detail-info">
                <h1 style="text-align: center;font-size: 25px;padding-bottom: 5px;">구매 내역 상세</h1>
            <div class="detail-box">
                <div class="info-item">
                    <span class="info-label">주문번호:</span>
                    <span class="info-value">{{ selectedPurchase.fgono }}</span>
                </div>
                <!-- 구매자 정보 -->
                <div class="info-item">
                    <span class="info-label">구매자 이름:</span>
                    <span class="info-value">{{ selectedPurchase.send }}</span>
                </div>
                <div class="info-item">
                    <span class="info-label">전화번호:</span>
                    <span class="info-value">{{ selectedPurchase.sendPhone }}</span>
                </div>
                <div class="info-item">
                    <span class="info-label">주소:</span>
                    <span class="info-value">{{ selectedPurchase.recvAddress }}</span>
                </div>

                <!-- 주문 정보 -->
                <div class="info-item">
                    <span class="info-label">결제 금액:</span>
                    <span class="info-value">{{ selectedPurchase.payment }} 원</span>
                </div>
                <div class="info-item">
                    <span class="info-label">요청 메시지:</span>
                    <span class="info-value">{{ selectedPurchase.msg }}</span>
                </div>
                <div class="info-item">
                    <span class="info-label">주문 날짜:</span>
                    <span class="info-value">{{ selectedPurchase.dbday }}</span>
                </div>

                <!-- 리워드 정보 -->
                <div class="info-item" style="white-space: nowrap;overflow: hidden;text-overflow: ellipsis;">
                    <span class="info-label">주문한 상품:</span>
                    <span class="info-value" >{{orderInfo}}</span>
                </div>
            </div>
        </div>

        <!-- Pagination -->
        <div class="pagination">
            <a href="#" @click.prevent="prevPage">이전</a>
            <a href="#" v-for="page in pages" :key="page" @click.prevent="changePage(page)">{{ page }}</a>
            <a href="#" @click.prevent="nextPage">다음</a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    const purchaseApp = Vue.createApp({
        data() {
            return {
                purchases: [],
                selectedPurchase: null,  // 선택된 구매 항목을 저장
                curpage: 1,
                startpage: 1,
                totalPages: 0,
                pages: [],
                orderInfo:''
            }
        },
        mounted() {
            this.fetchPurchases();

            $(document).on('click', '.purchase-table tr', function() {
                const $detailSection = $('#detailSection');
                if ($detailSection.is(':visible')) {
                    $detailSection.slideUp();  // 닫기
                } else {
                    $detailSection.slideDown();  // 열기
                }
            });
        },
        methods: {
            fetchPurchases() {
                axios.get('../mypage/store_order_vue.do', {
                    params: { page: this.curpage }
                }).then(res => {
                    console.log(res.data);
                    this.purchases = res.data.list;
                    this.totalPages = res.data.totalpage;
                    this.startpage = res.data.startpage;
                    this.generatePages();

                    // 페이지 변경 시 상세 정보 닫기
                    $('#detailSection').slideUp();
                }).catch(error => {
                    console.error(error.response);
                });
            },
            fetchPurchaseDetail(fgono) {
                axios.get('../mypage/store_buy_detail_vue.do', {
                    params: { fgono }
                }).then(res => {
                    console.log(res.data);
                    this.selectedPurchase = res.data.gvo;
                    this.orderInfo =res.data.info
                }).catch(error => {
                    console.error(error.response);
                });
            },
            generatePages() {
                this.pages = [];
                for (let i = this.startpage; i <= this.totalPages; i++) {
                    this.pages.push(i);
                }
            },
            changePage(page) {
                this.curpage = page;
                this.fetchPurchases();
            },
            prevPage() {
                if (this.curpage > 1) {
                    this.curpage--;
                    this.fetchPurchases();
                }
            },
            nextPage() {
                if (this.curpage < this.totalPages) {
                    this.curpage++;
                    this.fetchPurchases();
                }
            }
        }
    }).mount('#purchaseApp');
</script>
</body>
</html>