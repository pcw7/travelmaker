<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${path }/resources/bootstrap/js/jquery.js"></script>
<script type="text/javascript">
	var join = {
		pw: { 
			valid: { code:'valid', desc: '사용 가능한 비밀번호입니다.' }, 
			invalid: { code:'invalid', desc: '비밀번호는 영문 대/소문자, 숫자만 입력하세요.' },
			lack: { code:'invalid', desc: '비밀번호는 영문 대/소문자, 숫자를 모두 포함해야 합니다.' }, 
			equal: { code: 'valid', desc: '비밀번호가 일치합니다.' }, 
			notEqual: { code: 'invalid', desc: '비밀번호가 일치하지 않습니다.' } 
		}		
		
	}
	
	function idChk() {
		if (!frm.id.value) {
			alert("아이디를 입력한 후에 체크하세요");
			frm.id.focus();
			return false;
		}
		$.post('idChk.do', "id="+frm.id.value, function(data) {
			$('#idChk1').html(data);
		});
	}
	
	function nickNameChk() {
		if (!frm.nickName.value) {
			alert("별명을 입력한 후에 체크하세요");
			frm.nickName.focus();
			return false;
		}
		$.post('nickNameChk.do', "nickName="+frm.nickName.value, function(data) {
			$('#nickNameChk1').html(data);
		});
	}
	
/* 	$('.password').on('keyup', function() { 
		validate($(this));
	} */

	function validate(t) {
		var data = join.pw_status(t);		
	}
	
	
	function chk() {
		if (frm.password.value != frm.password2.value) {
			alert("비밀번호와 비밀번호 확인이 다릅니다");
			frm.password.focus();
			frm.password.value = "";
			frm.password2.value = "";
			return false;
		}
	}
	
	
</script>
</head>
<body>
<div>
	<h2>회원가입</h2>
</div>
<form action="join.do" method="post" name="frm" onsubmit="return chk()">
	아이디<input type="text" name="id" required="required" autofocus="autofocus">
	<input type="button" value="중복체크" onclick="idChk()">
	<div id="idChk1" class="err1"></div>
	비밀번호<input type="password" name="password" class="password" required="required">
	<div class="pwChk">비밀번호를 입력하세요.(영문 대/소문자, 숫자를 모두 포함)</div>
	비밀번호 확인<input type="password" name="password2" required="required"><br>
	이름<input type="text" name="name" required="required"><br>
	이메일<input type="email" name="email" required="required"><br>
	전화번호<input type="text" name="tel" required="required"
		pattern="\d{3}-\d{4}-\d{4}" placeholder="000-0000-0000"><br>
	별명<input type="text" name="nickName" required="required">
	<input type="button" value="중복체크" onclick="nickNameChk()">
	<div id="nickNameChk1" class="err2"></div>
	<input type="submit" value="회원가입">
</form>
<a href="loginForm.do">로그인</a>
</body>
</html>