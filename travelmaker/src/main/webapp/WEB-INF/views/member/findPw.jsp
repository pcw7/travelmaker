<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:set var="path" value="${pageContext.request.contextPath }"></c:set>
<style type="text/css">@import url("${path}/resources/css/findPw.css");</style>
</head>
<body>
<div class="wrap">
<div class="findPw">
<c:if test="${result == 1 && resultUpdatePw == 1 }">
	<p class="p_space">${member.id }님의 이메일로 임시비밀번호를 전송하였습니다.</p>
</c:if>
<c:if test="${result == 0 }">
	${msg}
</c:if>
<c:if test="${result == -1 }">
	<script type="text/javascript">
		alert("찾을 수 없는 계정입니다. 정보를 확인해주세요.");
		history.go(-1);
	</script>
</c:if>
<input class="link" type="button" onclick="location.href='loginForm.do';" value="로그인">
</div>
</div>
</body>
</html>