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
	
	// 비밀번호 형태 유효성 검사
	$("#pwChk1").hide();
	$("#pwChk2").hide();
	$("#pwChk3").hide();
	$("#pwChk4").hide();
	
	$("#pw").keyup(function() {  
	 	var pw = $("#pw").val(); 
     	var num = pw.search(/[0-9]/g);      //숫자 기입
	 	var eng = pw.search(/[a-zA-Z]/ig);  //영문자 기입
	 	var tab = pw.search(/[/\s/]/ig);    //공백

	 	if (tab != -1) {
	    	 $("#alert1").hide();
			 $("#alert2").toggle();
			 $("#alert3").hide();
			 $("#alert4").hide();
			 /* $("#submit").attr('disabled', true); */
		 } else {
		 	 if (pw.length < 4 ) {  
				$("#alert1").toggle();
				$("#alert2").hide();
				$("#alert3").hide();
			    $("#alert4").hide();
			   /*  $("#submit").attr('disabled', true);  */
   			 } else if (num >= 0 && eng >= 0){
    			$(".alert").hide(); 
    			/* $("#submit").attr('disabled', false); */
 	  		 } else if (num < 0 && eng >= 0  ) {   
			    $("#alert1").hide();
		        $("#alert2").hide();
		  	    $("#alert3").toggle();    
		   	    $("#alert4").hide();
		   	    /* $("#submit").attr('disabled', true); */
	   		 } else if ( num >= 0 && eng < 0  ){  
			    $("#alert1").hide();
				$("#alert2").hide();
				$("#alert3").hide();
				$("#alert4").toggle();
				/* $("#submit").attr('disabled', true); */
		 	 }
        } 
	  });	
	
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
	비밀번호<input type="password" name="password" id="password" title="비밀번호" 
		placeholder="영문 대/소문자, 숫자를 모두 포함" required="required">
	<div id="pwChk1">"숫자와 영문자를 포함해서 4자리 이상"</div>
	<div id="pwChk2">"공백 없이 입력"</div>
	<div id="pwChk3">"숫자 필수 포함"</div>
	<div id="pwChk4">"영문자 필수 포함"</div>	
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