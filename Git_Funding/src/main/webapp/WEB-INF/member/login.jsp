<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<head>
	<link rel="stylesheet" href="../css/login.css">
</head>
<body>
	<div id="login">
        <div class="tt_box">
            <a href="../main/main.do">
                <img src="../images/logo.png" alt="Git Funding">
            </a>
        </div>
        <form method="POST" action="../member/login.do" id="loginForm">
        	<div class="autologin">
                   <input type="checkbox" id="auto" name="remember-me">
                   <label for="auto">자동 로그인</label>
        	</div>
            <div class="login_box">
                <div class="input_wrap">
                    <input type="text" id="id" name="userId" v-model="userId">
                    <label for="id">아이디</label>
                </div>
                <div class="input_wrap">
                    <input type="password" id="pw" name="userPwd" v-model="userPwd">
                    <label for="pw">비밀번호</label>
                </div>
            </div>
            <p class="error">{{errorMsg}}${errorMsg}</p>
            <button class="loginBtn" @click="login">로그인</button>
        </form>
        <ul class="login_links">
            <li><a href="../member/member_find.do?type=id">아이디 찾기</a></li>
            <li><a href="../member/member_find.do?type=pw">비밀번호 찾기</a></li>
            <li><a href="../member/join.do">회원가입</a></li>
        </ul>
        <ul class="sns_btns">
            <li>
                <a href="#">카카오톡 로그인</a>
            </li>
            <li>
                <a href="#">네이버 로그인</a>
            </li>
            <li>
                <a href="#">애플 로그인</a>
            </li>
        </ul>
    </div>
    <script>
    	let loginApp=Vue.createApp({
    		data(){
    			return{
    				userId:'',
    				userPwd:'',
    				errorMsg:''
    			}
    		},
    		methods:{
    			login(e){
    				if(this.userId===""){
    					this.errorMsg='아이디를 입력하세요.'
    					e.preventDefault()
    					return
    				}
    				if(this.userPwd===""){
    					this.errorMsg='비밀번호를 입력하세요.'
    					e.preventDefault()
    					return
    				}
    				$('#loginForm').submit()
    			}
    		}
    	}).mount('#login')
    </script>
</body>
</html>