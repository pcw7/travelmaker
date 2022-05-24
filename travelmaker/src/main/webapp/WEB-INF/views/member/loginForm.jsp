<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:set var="path" value="${pageContext.request.contextPath }"></c:set>
<style type="text/css">@import url("${path}/resources/css/loginForm.css");</style>
</head>
<body>
<div class="wrap">
<div class="wrapper">
<div class="logo">
	<img class="logoImg" src="${path }/resources/images/logo.png">
</div>
<div class="loginForm">
<div>
<form action="login.do" method="post">
	<input class="id" type="text" name="id" required="required" autofocus="autofocus"
		placeholder="아이디"><br>
	<input class="password" type="password" name="password" required="required"
		placeholder="비밀번호"><br>
	<input class="submit" type="submit" value="로그인">
</form>
</div>
<div>	
<a href="joinForm.do">회원가입</a>
<a href="findIdForm.do">아이디 찾기</a>
<a href="findPwForm.do">비밀번호 찾기</a>
</div> 
</div>
</div>
<!--     <div class="aurora-base aurora-one"></div>
    <div class="aurora-base aurora-two"></div>
    <div class="aurora-base aurora-three"></div> -->
</div>
</body>
</html>