<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="../css/main.css">
	<style type="text/css">
		.ProjectHomeLayout {
            display: flex;
            height: 100vh;
        }

        .LeftArea {
            flex: 0 0 20%;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .LeftAreaTop {
            flex: 0 0 70%;
            position: relative;
        }

        .LeftAreaTop h2 {
            position: absolute;
            top: 15%;
            left: 60%;
            transform: translateX(-50%);
            margin: 0;
        }

        .ProjectProfileThumbnail {
            position: absolute;
            top: 35%;
            left: 60%;
            transform: translateX(-50%);
            width: 120px;
            height: 120px;
            background-color: #ccc;
            border-radius: 50%;
            margin-bottom: 15px;
        }

        .ProjectProfileUserId {
            position: absolute;
            top: 60%;
            left: 60%;
            transform: translateX(-50%);
            font-size: 16px;
            font-weight: bold;
        }

        /* 로그아웃 버튼 스타일 */
        .LogoutButton {
            position: absolute;
            top: 80%; /* 사용자 아이디 아래에 배치 */
            left: 60%;
            transform: translateX(-50%);
            font-size: 14px;
            padding: 10px 20px;
            background-color: #f44336;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .SpaceArea {
            flex: 0 0 5%;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
        }

        .SpaceArea::before {
            content: '';
            position: absolute;
            width: 2px;
            height: 100%;
            background-color: gray;
        }

        .RightArea {
            flex: 0 0 75%;
            background-color: #fff;
            padding: 20px;
        }
	</style>
</head>
<body>
	<div id="ProjectHome">
		<section class="ProjectHomeLayout">
			<div class="LeftArea">
				<div class="LeftAreaTop">
					<h2>메이커 홈</h2>
					<div class="ProjectProfileThumbnail">
						<img src="../project/ProjectProvisionalProfileThumbnail.jpg" alt="프로필 이미지 출력 오류">
					</div>
					<div class="ProjectProfileUserId">사용자 아이디를 출력합니다.</div>
					
					<!-- 로그아웃 버튼 -->
					<button class="LogoutButton" @click="logout">로그아웃</button>
				</div>
				<div class="BottomHalf"></div>
			</div>

			<div class="SpaceArea"></div>

			<div class="RightArea">
				<section>
				</section>
			</div>
		</section>
	</div>

	<script>
		let ProjectHomeApp = Vue.createApp({
			data() {
				return {
					
				}
			},
			methods: {
				logout() {
					window.location.href = '../main/main.do'
				}
			}
		}).mount('#ProjectHome')
	</script>
</body>
</html>
