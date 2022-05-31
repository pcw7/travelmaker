<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>    
<!DOCTYPE html><html><head><meta charset="UTF-8">
<title>Insert title here</title>

<c:set var="path" value="${pageContext.request.contextPath }"></c:set>
<%-- ${path }를 사용하면 경로가 절대경로로 변경됨 --%>
<style type="text/css">@import url("${path}/resources/css/view.css");</style>
<script type="text/javascript" src="${path}/resources/bootstrap/js/jquery.js"></script>

<script type="text/javascript">
	$(function() {
		$('#rvListDisp').load("rvList.do","bno=${board.bno}");
		$('#rInsert').click(function() {
			var uploadfiles = [];
			var formData = new FormData();
			formData.append('reply_content', frm1.reply_content.value);
			formData.append('mno', frm1.mno.value);
			formData.append('nickName', frm1.nickName.value);
			formData.append('bno', frm1.bno.value);
			var inputFile = $("input[name='file']");
			var files = inputFile[0].files;
			for (var i = 0; i < files.length; i++) {
				var file = files[i];
				uploadfiles.push(file);  // 업로드 파일 목록배열에 추가
			}
			$.each(uploadfiles, function(idx, file) {
				formData.append('file', file, file.name);
			});
			$.ajax({
				url:'rInsert.do', data:formData, type:'post',contentType:false,
				processData:false, enctype:'multipart/form-data',
				success: function(data) {
					alert("댓글이 작성되었습니다");
					$('#rvListDisp').html(data);
					frm1.reply_content.value="";
					frm1.file.value=null;
				}
			});
		});
	});
	function del() {
		// 확인을 check하면 true이고 취소를 체크하면 false;
		var ch = confirm("정말로 삭제하시겠습니까 ?");
		if (ch) location.href="bdDelete.do?bno=${board.bno }&pageNum=${pageNum}";
		else alert("삭제가 취소 되었습니다");
	}
	
	// 좋아요 조회
	$(document).ready(function() {
			$.post('likesSelect.do?bno=${board.bno }&id=${sessionScope.id}', function(data) {
				$('.likes').attr('src', '${path }/resources/images/'+data);
			});
			$.post('likesCount.do?bno=${board.bno }', function(data) {
				$('#likesTotal').html(data);
			});
	});

	// 좋아요 기능
	$(document).ready(function() {
		$('.likes').on('click', function() {	
			$.post('likesUpdate.do?bno=${board.bno }&id=${sessionScope.id}', function(data) {
				$('.likes').attr('src', '${path }/resources/images/'+data);
				$.post('likesCount.do?bno=${board.bno }', function(data) {
					$('#likesTotal').html(data);
				});
			});
		});
	});
</script>

</head><body>
<div class="header2">
	<div class="a20"></div>
	<div class="b60">
		<h2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 여행게시판</h2>
		<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 지역 : ${board.loc }</p>
	</div>
	<div class="a40">
		<c:if test="${board.id == id}">
			<a href="bdUpdateForm.do?bno=${board.bno }&pageNum=${pageNum}" class="btn">수정</a>
		</c:if>
		<c:if test="${board.id == id}">
			<a class="btn" onclick="del()" style="cursor: pointer;">삭제</a>
		</c:if>
		<a href="bdList.do?pageNum=${pageNum }" class="btn">게시글 목록</a>
	</div>
</div>
<div class="header2">
	<div class="a20"></div>
	<div class="a48">
		<h2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${board.title }</h2>
		<img src="${path }/resources/images/heart.png" class="likesIcon"><span id="likesTotal"></span>
    	<img src="${path }/resources/images/img/send.PNG" class="icon" alt="">${board.readcount } readcount
	</div>
	<div class="a12">
		<img src="${path }/resources/images/heart.png" class="likes">
	</div>
	<div class="a20"></div>
</div>
<div class="header3">
	<div class="a20"></div>
	<div class="a60"><p><b>&nbsp;&nbsp;&nbsp;&nbsp; 글쓴이 : ${board.nickName }</b>		<b class="post-time">${board.reg_date }</b></div>
	<div class="a20"></div>
</div>
<div class="body">
	<div class="leftSideBar"></div>
	<div class="content">
		<div><center><img src="${path }/resources/course/${board.courseImg }" class="post-image" alt=""></center></div>
		<div class="text_center"><pre>${board.content }</pre></div>
	</div>
	<div class="rightSideBar"></div>
</div>
<div class="body2">
	<div class="leftSideBar"></div>
	<div class="content" align="center">
		<h3 style="margin-right: 550px">댓글 작성</h3>
		<!-- submit할 때 action에 값이 없으면 자신(view.do)을 한번 더 수행 -->
		<form action="" method="post" enctype="multipart/form-data" name="frm1" id="frm1">
			<input type="hidden" name="bno" value="${board.bno }">
			<input type="hidden" name="mno" value="${member.mno }">
			<input type="hidden" name="nickName" value="${member.nickName }">
			<table>
				<tr><td><textarea rows="10" cols="70" name="reply_content"></textarea></td></tr>
			</table>
			<div class="file" style="margin-right: 380px">
						<label for="file">이미지</label>
						<input type="file" name="file" id="file" multiple="multiple">
			</div>
			<input type="button" value="리뷰 올리기" id="rInsert" class="btn2" style="margin-left: 380px;">
		</form>
	</div>
	<div class="rightSideBar"></div>
</div>
<div class="body3">
	<div class="leftSideBar"></div>
	<div class="content">
		<h3 style="margin-left: 300px">댓글</h3>
		<div id="rvListDisp" align="center"></div>
	</div>
	<div class="rightSideBar"></div>
</div>

<div class="footer"></div>



</body>
</html>