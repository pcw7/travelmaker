<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html><html><head><meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/header.css">

</head><body>

<div class="header">
	<a href="${pageContext.request.contextPath }/board/bdList.do"><img class="logo" src="${pageContext.request.contextPath }/resources/images/headerLogo.png"></a>
	<c:set var="id" value="${sessionScope.id}"></c:set>
	<c:if test="${not empty id }">
		<a href="${pageContext.request.contextPath }/mypage/myUpdateForm.do"><img class="MyPage" src="${pageContext.request.contextPath }/resources/images/MyPage.png"></a>
		<a href="${pageContext.request.contextPath }/member/logout.do"><img class="Logout" src="${pageContext.request.contextPath }/resources/images/Logout.png"></a>
		<%-- <a class="right1" href="${pageContext.request.contextPath }/member/logout.do">로그아웃</a> --%>
		<%-- <a class="right2" href="${pageContext.request.contextPath }/mypage/myUpdateForm.do">마이페이지</a> --%>
	</c:if>
</div>

</body>
</html>

