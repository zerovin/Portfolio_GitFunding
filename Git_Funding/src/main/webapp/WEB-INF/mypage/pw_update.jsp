<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://unpkg.com/vue@3"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<style>
        .password-change-wrapper {
            width: 800px;
            margin: 0 auto;
            padding: 20px;
            font-family: 'NEXON Lv2 Gothic';
            text-align: center;
        }
        .password-change-title {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 20px;
        }
        .password-change-text {
            font-size: 16px;
            color: #666;
            margin-bottom: 20px;
            line-height: 1.6;
        }
        .password-form {
            margin-top: 20px;
        }
        .password-input {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #e0e0e0;
            border-radius: 5px;
            font-size: 14px;
            box-sizing: border-box;
        }
        .change-button {
            padding: 12px 24px;
            border: none;
            background-color: orange;
            color: white;
            font-size: 16px;
            font-weight: bold;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .change-button:hover {
            background-color: #E67E22;
        }
        .cancel-button {
            padding: 12px 24px;
            border: none;
            background-color: #CCCCCC;
            color: white;
            font-size: 16px;
            font-weight: bold;
            border-radius: 5px;
            cursor: pointer;
            margin-left: 10px;
            transition: background-color 0.3s;
        }
        .cancel-button:hover {
            background-color: #AAAAAA;
        }
    </style>
</head>
<body>
    <div class="password-change-wrapper">
    	<img src="../images/logo.png" style="margin-bottom: 20px">
        <div class="password-change-title">비밀번호 변경</div>
        <div class="password-change-text">
            새 비밀번호를 입력하고, 한 번 더 확인해주세요.
        </div>
        <div class="password-form">
            <input type="password" class="password-input" placeholder="새 비밀번호 입력">
            <input type="password" class="password-input" placeholder="새 비밀번호 확인">
            <button class="change-button">비밀번호 변경</button>
            <button class="cancel-button"  onclick="window.history.back()">취소</button>
        </div>
    </div>
</body>
</html>