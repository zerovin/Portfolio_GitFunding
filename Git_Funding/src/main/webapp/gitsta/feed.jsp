<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Feed</title>
<style type="text/css">
/* ----------------- 인스타그램 스타일 내 피드 페이지 ------------------- */
body {
    font-family: Arial, sans-serif;
    background-color: #fafafa;
    margin: 0;
    padding: 0;
}

.instagram-page {
    max-width: 800px;
    margin: 0 auto;
    padding: 20px;
}

.header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 10px 20px;
    background-color: #ffffff;
    border-bottom: 1px solid #e0e0e0;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.header img {
    width: 30px;
    height: 30px;
    border-radius: 50%;
    object-fit: cover;
}

.profile-info {
    text-align: center;
    margin-top: 20px;
}

.profile-info img {
    width: 100px;
    height: 100px;
    border-radius: 50%;
    object-fit: cover;
}

.profile-info h2 {
    font-size: 20px;
    margin: 10px 0;
}

.profile-info p {
    font-size: 14px;
    color: #666;
}

.profile-stats {
    display: flex;
    justify-content: space-around;
    margin-top: 20px;
    padding: 10px 0;
    background-color: #ffffff;
    border-top: 1px solid #e0e0e0;
    border-bottom: 1px solid #e0e0e0;
}

.profile-stats div {
    text-align: center;
}

.profile-stats span {
    display: block;
    font-weight: bold;
    font-size: 16px;
}

.buttons {
    display: flex;
    justify-content: space-around;
    margin: 20px 0;
}

.buttons button {
    background-color: #ffffff;
    border: 1px solid #e0e0e0;
    padding: 10px 20px;
    border-radius: 5px;
    cursor: pointer;
    font-weight: 500;
    transition: background-color 0.3s;
}

.buttons button:hover {
    background-color: #e0e0e0;
}

.grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 10px;
    margin-top: 20px;
}

.grid img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    border-radius: 5px;
}
</style>
</head>
<body>
<div class="instagram-page">
    <div class="header">
        <a href="../gitsta/main.do"><img src="../images/back.png" alt="뒤로가기"></a>
        <h1>My Feed</h1>
        <img src="../images/notification_icon.png" alt="알림">
    </div>

    <div class="profile-info">
        <img src="../images/favicon.png" alt="내 프로필">
        <h2>29CM HOME</h2>
        <p>무엇을 그리든 나의 집<br>반 발짝 가까이 29CM HOME에서</p>
    </div>

    <div class="profile-stats">
        <div>
            <span>104</span>
            게시물
        </div>
        <div>
            <span>1.2만</span>
            팔로워
        </div>
        <div>
            <span>3</span>
            팔로잉
        </div>
    </div>

    <div class="buttons">
        <button>참여</button>
        <button>지지서명</button>
        <button>찜</button>
    </div>

    <div class="grid">
        <img src="../images/latest.jpeg" alt="피드 이미지 1">
        <img src="../images/latest.jpeg" alt="피드 이미지 2">
        <img src="../images/latest.jpeg" alt="피드 이미지 3">
        <img src="../images/latest.jpeg" alt="피드 이미지 4">
        <img src="../images/latest.jpeg" alt="피드 이미지 5">
        <img src="../images/latest.jpeg" alt="피드 이미지 6">
        <img src="../images/latest.jpeg" alt="피드 이미지 6">
        <img src="../images/latest.jpeg" alt="피드 이미지 6">
        <img src="../images/latest.jpeg" alt="피드 이미지 6">
    </div>
</div>
</body>
</html>