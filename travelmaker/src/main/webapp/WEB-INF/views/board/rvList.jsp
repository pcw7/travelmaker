<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<%-- <%@ include file="header.jsp" %> --%>
<!DOCTYPE html><html><head><meta charset="UTF-8">
<title>Insert title here</title>

<c:set var="path" value="${pageContext.request.contextPath }"></c:set>
<%-- ${path }를 사용하면 경로가 절대경로로 변경됨 --%>
<style type="text/css">@import url("${path}/resources/css/view.css");</style>
<script type="text/javascript" src="${path}/resources/bootstrap/js/jquery.js"></script>

<script type="text/javascript">
	function rDelete(bno, rno) {
		var sendData = "bno="+bno+"&rno="+rno;
		$.post("rDelete.do", sendData, function(data) {
			alert("삭제 되었습니다");
			$("#rvListDisp").html(data);
		});
	}
	function rUpdate(bno, rno) {
	/*  input에 있는 데이터를 읽어서 textarea에 넣어서 변경할 수 있게 만들어야 한다
		input, textarea, select에 데이터를 읽을 때는 jquery에서 val()
		td, div, span등에서 데이터를 읽을 때는 jquery에서 text() */
		var txt = $('#td_'+rno).text();
		/* 읽은 데이터를 textarea에 넣어서 수정할 수 있게 만든다 */
		$('#td_'+rno).html('<textarea row="3" colos="40" id="rt">'+txt+'</textarea>');
		/* 버튼 처리를 확인과 취소로 변경 */
		$('#btn_'+rno).html("<input type='button' onclick='up("+bno+","+rno+
			")' class='btn3' value='확인'> "+
			"<input type='button' onclick='lst("+bno+")' class='btn3' value='취소'>");
	}
	function lst(bno) {
		$('#rvListDisp').load("rvList.do", "bno=${board.bno}");
	}
	function up(bno, rno) {
		var sendData = "reply_content="+$('#rt').val()+"&bno="+bno+"&rno="+rno;
		$.post('rUpdate.do', sendData, function(data) {
			alert("수정 되었습니다");
			$('#rvListDisp').html(data);
		});
	}
</script></head><body>
<c:if test="${not empty rvList }">
	<!-- <h3 class="text-primary">댓글</h3> -->
<table>
<c:forEach var="rv" items="${rvList }">
	<%-- <c:if test="${rv.del=='y' }">
		<tr><td colspan="4">삭제된 댓글입니다</td></tr>
	</c:if> --%>
	<c:if test="${rv.del!='y' }">
		<tr><td width="20%">${rv.nickName }</td><td class="post-time">${rv.update_date}</td></tr>	
		<tr><td></td><td id="td_${rv.rno }" height="100">${rv.reply_content }</td><td></td>
			<td id="btn_${rv.rno }">		
				<c:if test="${rv.nickName==member.nickName }">
					<input type="button" value="수정" class="btn3"
						onclick="rUpdate(${rv.bno},${rv.rno })">
					<input type="button" value="삭제" class="btn3"
						onclick="rDelete(${rv.bno},${rv.rno })">
				</c:if></td></tr>
		<tr><td></td>
			<c:forEach var="reviewphoto" items="${rpList }">
				<c:if test="${reviewphoto.rno==rv.rno }">			
					<td height="200"><img alt="${reviewphoto.imgName }" src="${path }/resources/upload/${reviewphoto.imgName }" width="100"></td>
			 	</c:if>
		 	</c:forEach></tr>
			<!-- 댓글 작성자와 로그인 한사람의 이름을 비교 같으면 수정/삭제 권한 제공 -->
	</c:if>
</c:forEach>
</table>
</c:if>
</body>
</html>