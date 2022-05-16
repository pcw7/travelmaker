<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">@import url("resources/css/loginForm.css");</style>
</head>
<body>
<div>
	<img class="logo" src="resources/images/logo.png">
</div>
<form action="login.do" method="post">
	<input type="text" name="id" required="required" autofocus="autofocus"
		placeholder="아이디"><br>
	<input type="password" name="password" required="required"
		placeholder="비밀번호"><br>
	<input type="submit" value="로그인">
</form>	
<a href="joinForm.do">회원가입</a>
<a href="findIdForm.do">아이디 찾기</a>
<a href="findPwForm.do">비밀번호 찾기</a>
</body>
</html>