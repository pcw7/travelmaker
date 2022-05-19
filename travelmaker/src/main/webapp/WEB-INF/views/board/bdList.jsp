<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>    
<!DOCTYPE html><html><head><meta charset="UTF-8">
<title>Insert title here</title>
</head><body>

<div class="container" align="center">
	<h2 class="text-primary">게시글 목록</h2>	<!-- {sessionScope.id} -->
	<table class="table table-striped">
		<tr><th>번호</th><th>제목</th><th>작성자</th><th>조회수</th><th>작성일</th></tr>
		<c:if test="${empty list }">
			<tr><td colspan="5">게시글이 없습니다</td>
		</c:if>
		<c:if test="${not empty list }">
			<c:forEach var="board" items="${list }">
				<tr><td>${bno }<c:set var="bno" value="${bno - 1}"></c:set></td>
				<c:if test="${board.del == 'y' }">
					<td colspan="4">삭제된 글 입니다</td>
				</c:if>
				<c:if test="${board.del != 'y' }">
					<td title="${board.content }">
						<a href="bdView.do?bno=${board.bno }&pageNum=${pb.currentPage}" class="btn btn-info btn-sm">${board.title }</a>
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
				<li><a href="bdList.do?pageNum=1"><span class="glyphicon glyphicon-backward"></span></a></li>
				<li><a href="bdList.do?pageNum=${pb.startPage - 1 }"><span class="glyphicon glyphicon-triangle-left"></span></a></li>			
			</c:if>
			<c:forEach var="i" begin="${pb.startPage}" end="${pb.endPage}">
				<c:if test="${pb.currentPage == i }">
					<li class="active"><a href="bdList.do?pageNum=${i }">${i }</a></li>
				</c:if>
				<c:if test="${pb.currentPage != i }">
					<li><a href="bdList.do?pageNum=${i }">${i }</a></li>
				</c:if>
			</c:forEach>
			<!-- 보여줄 것이 남아 있으면 endPage보다 totalPage가 크다 -->
			<c:if test="${pb.endPage < pb.totalPage }">
				<li><a href="bdList.do?pageNum=${pb.endPage + 1 }"><span class="glyphicon glyphicon-triangle-right"></span></a></li>
				<li><a href="bdList.do?pageNum=${pb.totalPage }"><span class="glyphicon glyphicon-forward"></span></a></li>
			</c:if>
		</ul>
	</div>
</div>

<div align="center" style="position: fixed; top: 30%; left: 10px">
	<form action="bdList.do?pageNum=1">
		<select name="search">
			<c:forTokens var="sh" items="content" delims="," varStatus="i">
				<c:if test="${sh==board.search }">
					<option value="${sh }" selected="selected">${title[i.index] }</option>
				</c:if>
				<c:if test="${sh!=board.search }">
					<option value="${sh }">${title[i.index] }</option>
				</c:if>
			</c:forTokens>
		</select>
		<input type="text" name="keyword" value="${board.keyword }">
		<input type="submit" value="검색">
	</form>
	<div align="center"><a href="bdInsertForm2.do?bno=0&pageNum=1" class="btn btn-success">게시글 입력</a></div>
</div>

</body>
</html>