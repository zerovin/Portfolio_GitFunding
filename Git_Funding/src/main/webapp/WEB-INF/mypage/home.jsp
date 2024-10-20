<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>마이페이지 홈</title>
    <style>
        .home-container {
            margin-left: 50px;
            width: 900px;
            font-family: 'NEXON Lv2 Gothic';
        }
        .dashboard {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
        }
        .dashboard-item {
            flex: 1;
            background-color: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
            font-size: 18px;
        }
        .dashboard-item p {
            margin: 0;
            font-weight: bold;
        }
        .dashboard-item .value {
            font-size: 28px;
            color: #333333;
            margin-top: 10px;
        }
        .notice-list {
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-bottom: 20px;
        }
        .notice-list-item {
            display: flex;
            align-items: center;
            justify-content: center;
            border-bottom: 1px solid #e0e0e0;
            padding: 20px 0;
        }
        .notice-list-item img {
            width: 24px;
            height: 24px;
            margin-right: 10px;
        }
        .notice-list-item p {
            margin: 0;
            font-size: 16px;
        }
        .activity-list {
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }
        .activity-list-item {
            padding: 10px 0;
            border-bottom: 1px solid #e0e0e0;
        }
        .activity-list-item:last-child {
            border-bottom: none;
        }
        .activity-list-item button {
            background: none;
            border: none;
            font-size: 16px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 100%;
            padding: 10px 0;
            text-align: left;
        }
        .activity-list-item button:hover {
            background: #f0f0f0;
            cursor: pointer;
            border-radius: 5px;
        }
        #gitsta{
            border: none;
            background-color: #f8c200;
            color: white;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 5px;
            font-size: 14px;
            margin-right: 20px;
            text-align: center;
        }
        #gitsta:hover{
            background-color: orange;
        
        }
        .gitsta-info {
            display: flex;
            align-items: center;
            gap: 30px;
            border: 1px solid #e0e0e0;
            padding: 20px;
            border-radius: 10px;
            background-color: #f9f9f9;
        }
        .gitsta-info p {
            margin: 0;
            font-size: 16px;
            color: #333;
        }
        .arrow-icon {
            font-size: 18px;
        }
        #click {
        	cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="home-container">
        <!-- 대시보드 영역 -->
        <div class="dashboard">
            <div class="dashboard-item" id="click">
                <p>알림</p>
                <div class="value">0</div>
            </div>
            <div class="dashboard-item" id="click">
                <p>펀딩</p>
                <div class="value">0</div>
            </div>
            <div class="dashboard-item" id="click">
                <p>스토어</p>
                <div class="value">0</div>
            </div>
        </div>
        <div class="notice-list">
            <div class="notice-list-item">
                <a href="../gitsta/main.do" id="gitsta">깃스타그램</a>
                <div class="gitsta-info">
                    <p>게시물 <span style="font-weight: bold">30</span></p>
                    <p>팔로워 <span style="font-weight: bold">100</span></p>
                    <p>팔로잉 <span style="font-weight: bold">3</span></p>
                </div>
            </div>
        </div>
        <div class="notice-list">
            <div class="notice-list-item">
                <img src="../images/info_icon.png" alt="icon">
                <p>첫 탑 0원으로 배송비 할인과 쿠폰팩 지급</p>
            </div>
            <div class="notice-list-item">
                <img src="../images/info_icon.png" alt="icon">
                <p>지지서명으로 최대 50,000P 받는 방법</p>
            </div>
            <div class="notice-list-item">
                <img src="../images/info_icon.png" alt="icon">
                <p>햄짱짱님, 나만의 브랜드 콘을 해 보실래요?</p>
            </div>
        </div>
        <div class="activity-list">
            <div class="activity-list-item">
                <button>
                    <p>최근 본</p>
                    <div class="arrow-icon">></div>
                </button>
            </div>
            <div class="activity-list-item">
                <button>
                    <p>찜·알림신청</p>
                    <div class="arrow-icon"></div>
                </button>
            </div>
            <div class="activity-list-item">
                <button>
                    <p>팔로잉</p>
                    <div class="arrow-icon">></div>
                </button>
            </div>
            <div class="activity-list-item">
                <button>
                    <p>문의 하기</p>
                    <div class="arrow-icon">></div>
                </button>
            </div>
        </div>
    </div>
</body>
</html>
