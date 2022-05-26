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
//				preview(file, size - 1); // 미리보기
			}
			$.each(uploadfiles, function(idx, file) {
				formData.append('file', file, file.name);
			});
			$.ajax({
				url:'rInsert.do', data:formData, type:'post',contentType:false,
				processData:false, enctype:'multipart/form-data',
				success: function(data) {
					alert("댓글이 작성되었습니다");
					// $('form').hide();
					// $('#disp').html(data);
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
</script>

</head><body>

<div class="header">
	<h2>여행게시판</h2>
	<p>지역 : ${board.loc }</p>
</div>
<div class="header2">
	<div class="a80">
		<p>${board.title }</p>
		<img src="${path }/resources/images/img/comment.PNG" class="icon" alt="">1,012 likes
    	<img src="${path }/resources/images/img/send.PNG" class="icon" alt="">${board.readcount } readcount
	</div>
	<div class="a20">
		<img src="${path }/resources/images/img/send.PNG" class="icon_right" alt="">
	</div>
</div>
<div class="header3">
	작성자 : ${board.nickName }		<p class="post-time">${board.reg_date }</p>
</div>
<div class="body">
	<div class="leftSideBar"></div>
	<div class="content">
		<div><img src="${path }/resources/course/${board.courseImg }" class="post-image" alt=""></div>
		<div>${board.content }</div>
	</div>
	<div class="rightSideBar"></div>
</div>
<div class="body2">
	<div class="leftSideBar"></div>
	<div class="content">
		<p>댓글 작성</p>
		<!-- submit할 때 action에 값이 없으면 자신(view.do)을 한번 더 수행 -->
		<form action="" method="post" enctype="multipart/form-data" name="frm1" id="frm1">
			<input type="hidden" name="bno" value="${board.bno }">
			<input type="hidden" name="mno" value="${member.mno }">
			<input type="hidden" name="nickName" value="${member.nickName }">
			<table>
				<tr><td><textarea rows="10" cols="70" name="reply_content"></textarea></td></tr>
				<tr><div class="file">
						<td><label for="file">이미지</label>
							<input type="file" name="file" id="file" multiple="multiple"></td>
					</div></tr>
				<tr><td><input type="button" value="리뷰 올리기" id="rInsert"></td></tr>		
			</table>
		</form>
	</div>
	<div class="rightSideBar"></div>
</div>
<div class="body">
	<div class="leftSideBar"></div>
	<div class="content">
		<div id="rvListDisp"></div>
	</div>
	<div class="rightSideBar"></div>
</div>

<div class="footer"></div>



</body>
</html>