<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html><html><head><meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/header.css">

</head><body>

<p style="text-align: center;">타일즈에는 뭐를 넣고 싶나?</p>

<a href="${pageContext.request.contextPath }/board/bdList.do" style="text-decoration: none;">메인화면</a>
<c:set var="id" value="${sessionScope.id}"></c:set>
<c:if test="${not empty id }">
	<a class="right" href="${pageContext.request.contextPath }/mypage/myUpdateForm.do" style="text-decoration: none;">마이페이지</a>
	<a class="right" href="${pageContext.request.contextPath }/member/logout.do" style="text-decoration: none;">로그아웃</a>
</c:if>

</body>
</html>

