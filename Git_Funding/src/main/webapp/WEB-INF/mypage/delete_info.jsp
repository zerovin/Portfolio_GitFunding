<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <style>
        .withdrawal-wrapper {
            width: 800px;
            margin: 0 auto;
            padding: 20px;
            font-family: 'NEXON Lv2 Gothic';
            text-align: center;
        }
        .withdrawal-title {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 20px;
        }
        .withdrawal-text {
            font-size: 16px;
            color: #666;
            margin-bottom: 20px;
            line-height: 1.6;
        }
        .withdrawal-form {
            margin-top: 20px;
        }
        .withdrawal-input {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #e0e0e0;
            border-radius: 5px;
            font-size: 14px;
            box-sizing: border-box;
        }
        .withdrawal-button {
            padding: 12px 24px;
            border: none;
            background-color: #FF6666;
            color: white;
            font-size: 16px;
            font-weight: bold;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .withdrawal-button:hover {
            background-color: #FF3333;
        }
       
    </style>
</head>
<body>
    <div class="withdrawal-wrapper">
    	<img src="../images/logo.png" style="margin-bottom: 20px">
        <div class="withdrawal-title">회원 탈퇴</div>
        <div class="withdrawal-text">
            정말로 회원 탈퇴를 진행하시겠습니까?<br>
            탈퇴 후에는 계정 정보와 모든 데이터가 삭제되며 복구가 불가합니다.
        </div>
        <div class="withdrawal-form">
            <input type="password" class="withdrawal-input" placeholder="비밀번호를 입력하세요">
            <button class="withdrawal-button">탈퇴하기</button>
        </div>
    </div>
</body>
</html>
