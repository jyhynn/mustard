<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/resources/vendor/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css">
<link rel="stylesheet" href="/resources/editor/froala_editor.css">
<link rel="stylesheet" href="/resources/editor/froala_style.css">
<link rel="stylesheet" href="/resources/css/plugins/code_view.css">
<link rel="stylesheet" href="/resources/css/plugins/image_manager.css">
<link rel="stylesheet" href="/resources/css/plugins/image.css">
<link rel="stylesheet" href="/resources/css/plugins/table.css">
<link rel="stylesheet" href="/resources/css/plugins/video.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.3.0/codemirror.min.css">
<script src="/resources/editor/froala_editor.min.js"></script>
<script>
  $(function() {
    $('textarea#froala-editor').froalaEditor()
  });
</script>
</head>
<body>
<div class="container mt-5">
	<div class="row">
		<div class="col-md-9 order-md-1 font-jeju ">
			<h4 class="mb-3">공지사항 등록</h4>
			<form action="noticeWrite" method="post">
				<div class="list-group-item mb-3 p-0">
					<input class="custom-form-control" type="text" name="title" placeholder="제목" required="required"/>
					<input class="custom-form-control" type="hidden" value="로그인된 작성자"/>
					</div>
				<div class="list-group-item p-0 mb-3">
					<textarea id="froala-editor" class="form-control m-0 h-50" placeholder="내용을 입력하세요" name="content" required="required" rows="50" cols=""></textarea>
				</div>
				<!-- 첨부파일 -->
				<ul class="list-group">
					<li class="list-group-item">
						<input type="file" multiple="multiple" name="uploadFile"/>
					</li>
					<li class="list-group-item">
						<div class="uploadResult"><ul></ul></div>
					</li>
				</ul>
				<!-- 등록 -->
				<button type="submit" class="mt-4 mb-5 btn btn-warning">등록</button>
			</form>
		</div>
		<div class="col-md-3 order-md-2 mb-4 font-jeju">
			<ul class="list-group">
			  <li class="list-group-item">정보 게시판</li>
			  <li class="list-group-item"><a href="#">지역 게시판</a></li>
			  <li class="list-group-item"><a href="#">홍보 게시판</a></li>
			  <li class="list-group-item"><a href="#">자유 게시판</a></li>
			  <li class="list-group-item"><a href="/board/noticeList" aria-disabled="true">공지사항</a></li>
			</ul>
			<ul class="list-group mt-4">
			  <li class="list-group-item" aria-disabled="true"><h4>실시간 인기글</h4></li>
			  <li class="list-group-item"><a href="#">글목록</a></li>
			</ul>
		</div>
	</div>
</div>
<%@ include file="../include/footer.jsp"%>