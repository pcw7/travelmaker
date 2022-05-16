<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>아이디 찾기</h2>
<form action="findId.do" method="post">
	<input type="text" name="name" required="required" autofocus="autofocus"
		placeholder="이름"><br>
	<input type="text" name="tel" required="required" pattern="\d{3}-\d{4}-\d{4}" 
		placeholder="전화번호"><br>
	<input type="submit" value="확인">
</form>
<a href="findPwForm.do">비밀번호 찾기</a>
<a href="joinForm.do">회원가입</a>
<a href="loginForm.do">로그인</a>
</body>
</html>