<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
   .mymenu-div {
   		font-family: 'NexonLv2Gothic';
        display: flex;
        flex-direction: column;
        align-items: center;
        width: 250px;
        background-color: #ffffff;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        margin: 20px;
    }
    .profile-div {
        position: relative;
        text-align: center;
    }
    .profile-div img {
        width: 100px;
        height: 100px;
        border-radius: 50%;
        border: 2px solid #e0e0e0;
    }
    .profile-div .edit-icon {
        position: absolute;
        bottom: 5px;
        right: 5px;
        background-color: #ffffff;
        border-radius: 50%;
        padding: 5px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }
    .mymenu-div p {
        font-size: 18px;
        font-weight: bold;
        margin-top: 10px;
        margin-bottom: 20px;
    }
    .mymenu {
        width: 100%;
    }
    .mymenu_p {
        font-weight: bold;
        border-bottom: 1px solid #e0e0e0;
        padding-bottom: 10px;
    }
    .mymenu-detail{
    	margin-bottom: 10px;
    	margin-top: 10px;
    }
    .mymenu li {
        list-style-type: none;
        margin-top: 10px;
        padding: 10px;
        border-radius: 5px;
        transition: background-color 0.3s;
    }
    .mymenu li:hover {
        background-color: #f0f0f0;
        cursor: point;
    }
    .gitsta-button {
    	display : block;
        width: 90%;
        padding: 10px;
        border: 1px solid #e0e0e0;
        background-color: #ffffff;
        border-radius: 5px;
        text-align: center;
        margin-top: 20px;
        cursor: pointer;
        transition: background-color 0.3s;
        margin-bottom: 30px;
    }
    .gitsta-button:hover {
        background-color: #f0f0f0;
    }
    .edit-icon {
		width: 20px;
    }
</style>
</head>
<body>
    <div class="mymenu-div">
        <div class="profile-div">
            <img src="../images/profile.png">
            <div class="edit-icon">
                <img src="../images/edit.png" style="width: 20px;height: 20px">
            </div>
        </div>
        <p>햄짱짱님</p>
        <div class="mymenu">
        	<a href="../project/home.do" class="gitsta-button">프로젝트 관리자</a>
        	<div class="mymenu-detail">
        		<p class="mymenu_p">나의 활동</p>
	            <ul> 
	            	<li>최근 본</li>
		            <li>찜·알림신청</li>
		            <li>지지 프로젝트</li>
		            <li>펀딩</li>
		            <li>스토어</li>
	            </ul>

            </div>
            <div class="mymenu-detail">
        		<p class="mymenu_p" style="margin-top: 25px;">커뮤니티</p>
	            <ul>
		            <li>나의 리뷰</li>
		            <li>문의 내역</li>
		            <li>정보 수정</li>
		            <li>회원 탈퇴</li>
	            </ul>

	        </div>
        </div>
    </div>
</body>
</html>