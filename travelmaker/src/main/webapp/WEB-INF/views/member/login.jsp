<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:set var="path" value="${pageContext.request.contextPath }"></c:set>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
</head>
<body>
<c:if test="${result > 0 }">
	<script type="text/javascript">
		/* alert("환영합니다");
		location.href="../board/bdList.do"; */
		Swal.fire({
			  title: '환영합니다',
			  width: 600,
			  padding: '3em',
			  color: '#716add',
			  background: '#fff url(${path }/resources/images/alert.png)',
			  backdrop: ` 
				  rgba(40,23,100,0.1)
			  `, closeOnClickOutside : false
			}).then(function() {
				location.href="../board/bdList.do";
			});
	</script>
</c:if>
<c:if test="${result == 0 }">
	<script type="text/javascript">
		/* alert("비밀번호가 다릅니다");
		history.go(-1); */
		Swal.fire({
			  title: '비밀번호가 다릅니다',
			  width: 600,
			  padding: '3em',
			  color: '#716add',
			  background: '#fff url(${path }/resources/images/alert.png)',
			  backdrop: ` 
				  rgba(40,23,100,0.1)
			  `, closeOnClickOutside : false
			}).then(function() {
				history.back();	
			});
	</script>
</c:if>
<c:if test="${result == -1 }">
	<script type="text/javascript">
		/* alert("없는 아이디입니다.");
		history.go(-1); */
		Swal.fire({
			  title: '없는 아이디입니다.',
			  width: 600,
			  padding: '3em',
			  color: '#716add',
			  background: '#fff url(${path }/resources/images/alert.png)',
			  backdrop: ` 
				  rgba(40,23,100,0.1)
			  `, closeOnClickOutside : false
			}).then(function() {
				history.back();	
			});
	</script>
</c:if>
</body>
</html>