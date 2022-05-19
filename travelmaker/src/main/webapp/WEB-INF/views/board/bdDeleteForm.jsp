<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>    
<!DOCTYPE html><html><head><meta charset="UTF-8">
<title>Insert title here</title>

</head><body>

<div class="container" align="center">
	<h2 class="text-primary">게시글 삭제</h2>
	<form action="bdDelete.do" method="post" name="frm">
		<input type="hidden" name="bno" value="${board.bno }">
		<input type="hidden" name="pageNum" value="${pageNum }">
	<table class="table table-bordered table-hover">
		<tr><td colspan="2" align="center"><input type="submit" value="확인" class="btn btn-info">
	</table>
	</form>
</div>

</body>
</html>