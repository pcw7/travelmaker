<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }"></c:set>
<!DOCTYPE html>
<html><head><meta charset="UTF-8"><title>Insert title here</title>
<style type="text/css">@import url("${path}/resources/css/myBoard.css");</style>
<script type="text/javascript" src="${path }/resources/bootstrap/js/jquery.js"></script>
<script type="text/javascript">
	$(function() {
		$('#myBoardDisp').load("http://localhost:8080/tm/board/bdMyBoard.do?search=m.nickName&keyword=${member.nickName}");
	});
</script>
</head>
<body>
<div class="headerSpace"></div>

<div class="nav">
<ul class="nav_ul">
	<li class="nav_li1"><a href="myUpdateForm.do">마이페이지</a></li>
	<li class="nav_li2"><a href="myUpdateForm.do">내 정보 수정</a></li>
	<li class="nav_li2"><a href="myBoard.do">내가 쓴 글</a></li>
	<li class="nav_li2"><a href="likesList.do?id=${sessionScope.id}">좋아요 목록</a></li>
</ul>
</div>
<div id="myBoardDisp"></div>

</body>
</html>