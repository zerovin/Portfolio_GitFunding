<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<header id="header">
    <div class="container">
        <div class="left">
            <h1><a href="../main/main.do" class="logo">Git Funding</a></h1>
            <nav>
                <ul class="menu">
                    <li><a href="../funding/open_list.do">오픈예정</a></li>
                    <li><a href="../funding/funding_list.do">펀딩</a></li>
                    <li><a href="../goods/list.do">스토어</a></li>
                    <li><a href="../community/faq_list.do">커뮤니티</a></li>
                </ul>
            </nav>
        </div>    
        <div class="right">
            <ul class="links">
            	<c:if test="${sessionScope.userId==null}">
	                <li><a href="../member/login.do">로그인</a></li>
	                <li><a href="../member/join.do">회원가입</a></li>
                </c:if>
                <c:if test="${sessionScope.userId!=null}">
					<li><a href="../mypage/main.do" class="mypage"><img src="../images/profile.png" alt="마이페이지"></a></li>
                	<li><a href="" class="icon gitstargram">깃스타그램</a></li>
                	<li><a href="" class="icon wish">위시리스트</a></li>
                	<sec:authorize access="hasRole('ROLE_ADMIN')">
		            	<li><a href="../member/logout.do">관리자페이지</a></li>
		            </sec:authorize>
		            <li><a href="../member/logout.do">로그아웃</a></li>
                </c:if>
            </ul>
            <a href="../project/home.do" class="make_btn">프로젝트 만들기</a>
        </div>
    </div>
</header>