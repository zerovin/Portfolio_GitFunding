<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/cart.css">
<style type="text/css">
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
            max-width : 700px;
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
	<div class="container commu_list" style="margin-top: 20px;" id="cart">
            <div class="cartHead">
            	<div class="cartHeadInfo">
	            	<p >STEP1</p>
	            	<h1 >장바구니</h1>
            	</div>
            	<div class="cartHeadInfo">
	            	<p>STEP2</p>
	            	<h1>주문결제</h1>
            	</div>
            	<div class="cartHeadInfo">
	            	<p style="color: white;">STEP3</p>
	            	<h1 style="color: white;">주문완료</h1>
            	</div>
            	<div></div>
            </div>
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
                    <span class="info-value">{{ selectedPurchase.buydate }}</span>
                </div>

                <!-- 리워드 정보 -->
                <div class="info-item">
                    <span class="info-label">구매한 상품:</span>
                    <span class="info-value"></span>
                </div>
            </div>
        </div>

      </div>
      <script>
      let orderOK=Vue.createApp({
	      data() {
	          return {
	              selectedPurchase:{},  // 선택된 구매 항목을 저장
	              id:'${sessionScope.userId}',
	              orderInfo:{},
	              order:''
	          }
	      },
	      mounted() {
	    	  this.fetchPurchaseDetail()
	    	  forEach()
	      },
	      methods: {
	          fetchPurchaseDetail() {
	              axios.get('../goods/order_ok_vue.do', {
	                  params: {
	                	  id:this.id
	                  }
	              }).then(res => {
	                  console.log(res.data);
	                  this.selectedPurchase = res.data.gvo;
	                  this.orderInfo = res.data.vo;
	              }).catch(error => {
	                  console.error(error.response);
	              });
	          }
	      }
	  }).mount('#detailSection');
      </script>
</body>
</html>