<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>구매 목록</title>
    <style>
        .purchase-list {
            width: 800px;
            margin: 0 auto;
            padding: 20px;
            font-family: 'NEXON Lv2 Gothic';
        }

        .purchase-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        .purchase-table th, .purchase-table td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }

        .purchase-table th {
            background-color: #f8c200;
            color: white;
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
            display: none;
            background-color: #f9f9f9;
            padding: 15px;
            margin-top: 5px;
            border-left: 3px solid #ffa500;
            transition: all 0.3s ease;
        }

        .detail-info td {
            border-top: none;
            padding: 15px;
        }

        .show-details {
            display: table-row;
        }

        .detail-box {
            background-color: #fff;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            margin-top: 10px;
        }

        .detail-box .info-item {
            display: flex;
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
    </style>
</head>
<body>
    <div id="purchaseApp" class="purchase-list">
        <h2>구매 목록</h2>
        <table class="purchase-table">
            <thead>
                <tr>
                    <th>번호</th>
                    <th>펀딩 이미지</th>
                    <th>펀딩 제목</th>
                    <th>총 가격</th>
                    <th>주문 날짜</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="purchase in purchases" :key="purchase.rbno" @click="fetchPurchaseDetail(purchase.rbno)">
                    <td>{{ purchase.rbno }}</td>
                    <td><img :src="purchase.thumb" alt="펀딩 이미지"></td>
                    <td>{{ purchase.title }}</td>
                    <td>{{ purchase.totalprice }}</td>
                    <td>{{ purchase.regdate }}</td>
                </tr>
                <tr v-if="selectedPurchase" class="detail-info show-details">
                    <td colspan="5">
                        <div class="detail-box">
                            <div class="info-item">
                                <span class="info-label">구매자 이름:</span>
                                <span class="info-value">{{ selectedPurchase.name }}</span>
                                <span class="info-label">연락처:</span>
                                <span class="info-value">{{ selectedPurchase.phone }}</span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">배송 주소:</span>
                                <span class="info-value">{{ selectedPurchase.addr1 }} {{ selectedPurchase.addr2 }}</span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">요청 메시지:</span>
                                <span class="info-value">{{ selectedPurchase.requestMsg }}</span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">총 가격:</span>
                                <span class="info-value">{{ selectedPurchase.totalprice }}</span>
                                <span class="info-label">배송비:</span>
                                <span class="info-value">{{ selectedPurchase.delivery }}</span>
                                <span class="info-label">결제 금액:</span>
                                <span class="info-value">{{ selectedPurchase.totalprice + selectedPurchase.delivery }}</span>
                            </div>
                        </div>
                    </td>
                </tr>
            </tbody>
        </table>

        <!-- Pagination -->
        <div class="pagination">
            <a href="#" @click.prevent="prevPage">이전</a>
            <a href="#" v-for="page in pages" :key="page" @click.prevent="changePage(page)">{{ page }}</a>
            <a href="#" @click.prevent="nextPage">다음</a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script>
        const purchaseApp = Vue.createApp({
            data() {
                return {
                    purchases: [],
                    selectedPurchase: {},
                    curpage: 1,
                    startpage: 1,
                    totalPages: 0,
                    pages: []
                }
            },
            mounted() {
                this.fetchPurchases();
            },
            methods: {
                fetchPurchases() {
                    axios.get('../mypage/funding_buy_vue.do', {
                        params: { page: this.curpage }
                    }).then(res => {
                        console.log(res.data);
                        this.purchases = res.data.list;
                        this.totalPages = res.data.totalpage;
                        this.startpage = res.data.startpage;
                        this.generatePages();
                    }).catch(error => {
                        console.error(error.response);
                    });
                },
                fetchPurchaseDetail(rbno) {
                    axios.get('../mypage/funding_buy_detail_vue.do', {
                        params: { rbno }
                    }).then(res => {
                        console.log(res.data);
                        this.selectedPurchase = res.data;
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
