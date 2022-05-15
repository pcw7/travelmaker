<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>    
<!DOCTYPE html><html><head><meta charset="UTF-8">
<title>Insert title here</title>

<!-- <script type="text/javascript">
	$(function() {
		$('#rvListDisp').load("replyList.do","bno=${board.bno}");
		$('#boardListDisp').load("list.do", "pageNum=${pageNum}");
		$('#rInsert').click(function() {
			/* var sendData = "bno="+frm1.bno.value+"&replier="+frm1.replier.value+"&replytext="+frm1.replytext.value; */
			var sendData = $('#frm1').serialize();
			$.post("rInsert.do", sendData, function(data) {
				alert("댓글이 입력 되었습니다");
				$('#rvListDisp').html(data);
				frm1.reply_content.value = "";		// 댓글 지우기
			});
		});
	});
</script>
 -->
<script type="text/javascript">
	$(function() {
		$('#rvListDisp').load("replyList.do","bno=${board.bno}");
		$('#boardListDisp').load("list.do", "pageNum=${pageNum}");
		$('#rInsert').click(function() {
			var uploadfiles = [];
			var formData = new FormData();
			formData.append('reply_content', frm.reply_content.value);
			formData.append('replier', frm.replier.value);
			formData.append('bno', frm.bno.value);
			var files = e.originalEvent.dataTransfer.files; // 드래그 그림들
			for (var i = 0; i < files.length; i++) {
				var file = files[i];
				uploadfiles.push(file);  // 업로드 파일 목록배열에 추가
				preview(file, size - 1); // 미리보기
			}
			$.each(uploadfiles, function(idx, file) {
				formData.append('file', file, file.name);
			});
			$.ajax({
				url:'rInsert.do', data:formData, type:'post',contentType:false,
				processData:false, enctype:'multipart/form-data',
				success: function(data) {
					$('form').hide();
					$('#disp').html(data);
				}
			});
		});
	});
</script>

</head><body>

<div class="container" align="center">
	<h2 class="text-primary">게시글 상세 내역</h2>
	<table class="table table-bordered table-striped">
		<tr><td>제목</td><td>${board.title }</td>
			<td>조회수</td><td>${board.readcount }</td></tr>
		<tr><td>작성자</td><td>철수</td>
			<td>작성일</td><td>${board.reg_date }</td></tr>
		<tr><td>내용</td><td colspan="3"><pre>${board.content }</pre></td></tr>
		<tr><td colspan="4" align="center">
			<a href="list.do?pageNum=${pageNum }" class="btn btn-info">게시글 목록</a>
			<a href="updateForm.do?bno=${board.bno }&pageNum=${pageNum}" class="btn btn-warning">수정</a>
			<!-- 회원 게시판인 경우에는 폼없이 삭제 여부를 묻고 삭제, 비회원인 경우에는 암호를 확인하기 위한 화면-->
			<a href="deleteForm.do?bno=${board.bno }&pageNum=${pageNum}" class="btn btn-danger">삭제</a>
	</table>
	<h2 class="text-primary">댓글 작성</h2>
	<!-- submit할 때 action에 값이 없으면 자신(view.do)을 한번 더 수행 -->
	<form action="" method="post" enctype="multipart/form-data" name="frm1" id="frm1">
		<input type="hidden" name="bno" value="${board.bno }">
		<table class="table table-hover">
			 	<tr><th>작성자</th><td><input type="text" name="replier" value="철수"></td>
				<td>댓글</td><td><textarea rows="3" cols="30" name="reply_content"></textarea></td></tr>
				<tr><td>사진 <span class="glyphicon glyphicon-picture"></span></td>
					<td><input type="file" name="file" multiple="multiple"></td></tr>
				<tr><td><input type="submit" value="댓글 입력" id="rInsert"></td></tr>			<!--  -->
		</table>
	</form>
	<div id="rvListDisp"></div>
	<div id="boardListDisp"></div>
</div>

</body>
</html>