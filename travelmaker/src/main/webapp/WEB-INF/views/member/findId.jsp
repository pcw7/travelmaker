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
<h2>아이디 찾기</h2>
<c:if test="${result == 1 }">
	회원님의 아이디는 '${member.id }'입니다.<br>
</c:if>
<c:if test="${result == 0 }">
	<script type="text/javascript">
		alert("아이디 찾기에 실패했습니다");
		history.back();
	</script>
</c:if>
<c:if test="${result == -1 }">
	<script type="text/javascript">
		alert("존재하지 않는 계정입니다.");
		history.back();
	</script>
</c:if>
<a href="findPwForm.do">비밀번호 찾기</a>
<a href="loginForm.do">로그인</a>
<a href="joinForm.do">회원가입</a>
</body>
</html>