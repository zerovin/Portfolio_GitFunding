<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<head>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" href="../css/join.css">
</head>
<body>
	<div id="join">
        <div class="tt_box">
            <h2>회원가입</h2>
        </div>
        <section class="join_wrap">
            <p><span>*</span> 필수입력사항</p>
            <form method="POST" action="../member/join_ok.do" id="join_form">
                <div class="center">
                    <div class="hasBtn">
                        <div class="input_wrap">
                            <label for="id">아이디<span>*</span></label>
                            <input type="text" id="userId" name="userId" placeholder="아이디를 입력해주세요" required>
                        </div>
                        <p class="id_check">아이디 중복체크 메세지<p>
                    </div>
                    <div class="input_wrap">
                        <label for="pw">비밀번호<span>*</span></label>
                        <input type="password" id="userPwd" name="userPwd" placeholder="비밀번호를 입력해주세요" required>
                    </div>
                    <div class="input_wrap">
                        <label for="pw_check">비밀번호확인<span>*</span></label>
                        <input type="password" id="pw_check" placeholder="비밀번호를 한번 더 입력해주세요" required>
                    </div>
                    <div class="input_wrap">
                        <label for="name">이름<span>*</span></label>
                        <input type="text" id="userName" name="userName" placeholder="이름을 입력해주세요" required>
                    </div>
                    <div class="input_wrap">
                        <p class="label">성별</p>
                        <div class="radios">
                            <div class="radio_btn">
                                <label for="man">남자</label>
                                <input type="radio" id="man" name="gender" value="남자">
                            </div>
                            <div class="radio_btn">
                                <label for="woman">여자</label>
                                <input type="radio" id="woman" name="gender" value="여자">
                            </div>
                        </div>
                    </div>
                    <div class="input_wrap">
                        <label for="phone">휴대폰<span>*</span></label>
                        <input type="tel" id="phone" name="phone" placeholder="숫자만 입력해주세요" required>
                    </div>
                    <div class="input_wrap">
                        <label for="id">이메일<span>*</span></label>
                        <div>
                            <input type="text" id="email" name="email" placeholder="ex&#41; git_funding" required>@
                            <select name="email_domain">
                                <option value="naver.com">naver.com</option>
                                <option value="gmail.com">gmail.com</option>
                                <option value="hanmail.net">hanmail.net</option>
                                <option value="kakao.com">kakao.com</option>
                                <option value="daum.net">daum.net</option>
                                <option value="hotmail.com">hotmail.com</option>
                                <option value="yahoo.co.kr">yahoo.co.kr</option>
                            </select>
                        </div>
                    </div>
                    <div class="hasBtn">
                        <div class="input_wrap">
                            <label for="post">우편번호<span>*</span></label>
                            <input type="text" id="post" name="post" placeholder="검색버튼을 눌러주세요" required readonly>
                        </div>
                        <input type="button" class="post_search" value="우편번호 검색">
                    </div>
                    <div class="input_wrap">
                        <label for="address1">기본주소<span>*</span></label>
                        <input type="text" id="address1" name="address1" readonly>
                    </div>
                    <div class="input_wrap">
                        <label for="address2">상세주소</label>
                        <input type="text" id="address2" name="address2">
                    </div>
                    <div class="form_btns">
                        <button class="join_btn">회원가입</button>
                        <button onclick="javascript:history.back()">취소</button>
                    </div>
                </div>
            </form>
        </section>
    </div>
</body>
</html>