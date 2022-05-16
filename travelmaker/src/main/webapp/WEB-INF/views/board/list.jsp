<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>    
<!DOCTYPE html><html><head><meta charset="UTF-8">
<title>Insert title here</title>
</head><body>

<div class="container" align="center">
	<h2 class="text-primary">게시글 목록</h2>
	<table class="table table-striped">
		<tr><th>번호</th><th>제목</th><th>작성자</th><th>조회수</th><th>작성일</th></tr>
		<c:if test="${empty list }">
			<tr><td colspan="5">게시글이 없습니다</td>
		</c:if>
		<c:if test="${not empty list }">
			<c:forEach var="board" items="${list }">
				<tr><td>${bno }<c:set var="bno" value="${bno - 1}"></c:set>
					<%-- ${board.num } --%></td>
				<c:if test="${board.del == 'y' }">
					<td colspan="4">삭제된 글 입니다</td>
				</c:if>
				<c:if test="${board.del != 'y' }">
					<td title="${board.content }">
						<a href="view.do?bno=${board.bno }&pageNum=${pb.currentPage}" class="btn btn-info btn-sm">${board.title }</a>
					</td>
					<td>철수</td>
					<td>${board.readcount }</td>
					<td>${board.reg_date }</td>
				</c:if></tr>
			</c:forEach>
		</c:if>
	</table>
	<div align="center">
		<ul class="pagination">
			<!-- 시작페이지가 pagePerBlock보다 크면 앞에 보여줄 것이 있다 -->
			<c:if test="${pb.startPage > pb.pagePerBlock }">
				<li><a href="list.do?pageNum=1"><span class="glyphicon glyphicon-backward"></span></a></li>
				<li><a href="list.do?pageNum=${pb.startPage - 1 }"><span class="glyphicon glyphicon-triangle-left"></span></a></li>			
			</c:if>
			<c:forEach var="i" begin="${pb.startPage}" end="${pb.endPage}">
				<c:if test="${pb.currentPage == i }">
					<li class="active"><a href="list.do?pageNum=${i }">${i }</a></li>
				</c:if>
				<c:if test="${pb.currentPage != i }">
					<li><a href="list.do?pageNum=${i }">${i }</a></li>
				</c:if>
			</c:forEach>
			<!-- 보여줄 것이 남아 있으면 endPage보다 totalPage가 크다 -->
			<c:if test="${pb.endPage < pb.totalPage }">
				<li><a href="list.do?pageNum=${pb.endPage + 1 }"><span class="glyphicon glyphicon-triangle-right"></span></a></li>
				<li><a href="list.do?pageNum=${pb.totalPage }"><span class="glyphicon glyphicon-forward"></span></a></li>
			</c:if>
		</ul>
	</div>
	<div align="center"><a href="insertForm.do?bno=0&pageNum=1" class="btn btn-success">게시글 입력</a></div>
</div>

</body>
</html>