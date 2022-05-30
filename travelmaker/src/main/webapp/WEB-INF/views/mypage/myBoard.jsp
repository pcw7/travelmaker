<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }"></c:set>
<!DOCTYPE html>
<html><head><meta charset="UTF-8"><title>Insert title here</title>
<script type="text/javascript" src="${path }/resources/bootstrap/js/jquery.js"></script>
<script type="text/javascript">
	$(function() {
		$('#myBoardDisp').load("http://localhost:8080/tm/board/bdMyBoard.do?search=m.nickName&keyword=${member.nickName}");
	});
</script>
</head>
<body>

<div id="myBoardDisp" align="center"></div>

</body>
</html>