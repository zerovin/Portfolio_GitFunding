<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
/* ----------------- 인스타그램 스타일 페이지 ------------------- */
.instagram-page {
    max-width: 800px;
    margin: 0 auto;
    padding: 20px;
}

.user-info {
    display: flex;
    align-items: center;
    justify-content: flex-start;
    margin-bottom: 20px;
}

.user-info div {
    text-align: center;
    margin-right: 20px;
}

.profile-pic {
    width: 70px;
    height: 70px;
    border-radius: 50%;
    margin-bottom: 5px;
    object-fit: cover;
}

.post {
    border: 1px solid #e0e0e0;
    border-radius: 10px;
    margin-bottom: 20px;
    background-color: #ffffff;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.post-header {
    display: flex;
    align-items: center;
    padding: 15px;
    border-bottom: 1px solid #e0e0e0;
}

.post-profile-pic {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    margin-right: 7px;
    object-fit: cover;
}

.post-user-info {
    display: flex;
    align-items: center;
    justify-content: space-between;
    width: 100%;
}

.username {
    font-weight: 600;
    font-size: 16px;
}

.follow-btn {
    background-color: #f8c200;
    border: none;
    padding: 5px 10px;
    border-radius: 5px;
    cursor: pointer;
    font-weight: 500;
    transition: background-color 0.3s;
}

.follow-btn:hover {
    background-color: #e0a800;
}

.post-image {
    width: 100%;
    max-height: 400px;
    overflow: hidden;
}

.post-image img {
    width: 100%;
    height: auto;
    object-fit: cover;
}

.post-content {
    padding: 15px;
}

.post-content p {
    margin-bottom: 10px;
    font-size: 15px;
    color: #333;
}

.tag {
    display: inline-block;
    background-color: #f0f0f0;
    padding: 5px 10px;
    border-radius: 15px;
    font-size: 14px;
    color: #666;
}

.load-more {
    display: block;
    width: 100%;
    padding: 15px 0;
    margin: 20px 0;
    text-align: center;
    background-color: #f8c200;
    color: #ffffff;
    font-weight: 600;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s;
    text-decoration: none;
}

.load-more:hover {
    background-color: #e0a800;
}
</style>
</head>
<body>
<div class="instagram-page">
    <div class="user-info">
        <div>
            <a href="../gitsta/myfeed.do"><img src="../images/favicon.png" alt="사용자 프로필" class="profile-pic"></a>
            <p><span style="font-weight: bold;">나</span></p>
        </div>
        <div>
            <img src="../images/favicon.png" alt="사용자 프로필" class="profile-pic">
            <p>김다인</p>
        </div>
        <div>
            <img src="../images/favicon.png" alt="사용자 프로필" class="profile-pic">
            <p>김다영</p>
        </div>
        <div>
            <img src="../images/favicon.png" alt="사용자 프로필" class="profile-pic">
            <p>민다진</p>
        </div>
        <div>
            <img src="../images/favicon.png" alt="사용자 프로필" class="profile-pic">
            <p>정지나</p>
        </div>
        <div>
            <img src="../images/favicon.png" alt="사용자 프로필" class="profile-pic">
            <p>정지나</p>
        </div>
        <div>
            <img src="../images/favicon.png" alt="사용자 프로필" class="profile-pic">
            <p>정지나</p>
        </div>
        <div>
            <img src="../images/favicon.png" alt="사용자 프로필" class="profile-pic">
            <p>정지나</p>
        </div>
        <div>
            <img src="../images/favicon.png" alt="사용자 프로필" class="profile-pic">
            <p>정지나</p>
        </div>
    </div>

    <div class="post">
        <div class="post-header">
            <img src="../images/favicon.png" alt="사용자 프로필" class="post-profile-pic">
            <div class="post-user-info">
                <div><span class="username">심미영</span> 님이 지지서명했어요</div>
                <button class="follow-btn">+ 팔로우</button>
            </div>
        </div>
        <div class="post-image">
            <img src="../images/latest.jpeg" alt="제품 이미지">
        </div>
        <div class="post-content">
            <p>풀씨를 검색하다가 우연히 들렀습니다. 14일 오픈할게요~</p>
            <span class="tag">일상용 비채줌</span>
        </div>
    </div>

    <div class="post">
        <div class="post-header">
            <img src="../images/favicon.png" alt="사용자 프로필" class="post-profile-pic">
            <div class="post-user-info">
                <div><span class="username">이재훈</span> 님이 좋아요를 눌렀습니다</div>
                <button class="follow-btn">+ 팔로우</button>
            </div>
        </div>
        <div class="post-image">
            <img src="../images/latest.jpeg" alt="제품 이미지">
        </div>
        <div class="post-content">
            <p>신제품이 도착했어요! 여러분의 많은 관심 부탁드립니다.</p>
            <span class="tag">뷰티디바이스</span>
        </div>
    </div>

    <a href="#" class="load-more">피드 더보기</a>
</div>
</body>
</html>