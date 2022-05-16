<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>비밀번호 찾기</h2>
회원 아이디와 이름을 확인하여 일치 시 이메일로 임시 비밀번호를 전송한다.
<form action="findPw.do" method="post">
	<input type="text" name="id" required="required" autofocus="autofocus"
		placeholder="아이디"><br>
	<input type="text" name="name" required="required" placeholder="이름"><br>
	<input type="submit" value="비밀번호 찾기">
</form>
<a href="findIdForm.do">아이디 찾기</a>
<a href="joinForm.do">회원가입</a>
<a href="loginForm.do">로그인</a>
</body>
</html>