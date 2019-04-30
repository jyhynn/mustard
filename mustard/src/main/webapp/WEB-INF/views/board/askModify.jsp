<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:if test="${empty log }">
	<script>
		alert("로그인 후 이용가능합니다");
		location.href="/member/signin";		
	</script>
</c:if>
<c:if test="${log.memNo != ask.memNo }">
	<script>
		alert("작성자만 이용가능합니다");
		location.href="history.back()";		
	</script>
</c:if>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css">
<link rel="stylesheet" href="/resources/editor/froala_editor.css">
<link rel="stylesheet" href="/resources/editor/froala_style.css">
<link rel="stylesheet" href="/resources/css/plugins/code_view.css">
<link rel="stylesheet" href="/resources/css/plugins/image_manager.css">
<link rel="stylesheet" href="/resources/css/plugins/image.css">
<link rel="stylesheet" href="/resources/css/plugins/table.css">
<link rel="stylesheet" href="/resources/css/plugins/video.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.3.0/codemirror.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.0/dist/jquery.validate.js"></script>
<script src="/resources/js/messages_ko.js"></script>
<script src="/resources/js/registValidation.js"></script>
<script src="/resources/editor/froala_editor.min.js"></script>
</head>
<body>
<div class="container mt-5">
	<div class="row">
		<div class="col-md-9 order-md-1 font-jeju ">
			<h3>문의게시판</h3>
			<form id="askModify" action="askModify" method="post">
				<div class="list-group-item mb-3 p-0">
					<input class="custom-form-control" type="text" id="title" name="title" placeholder="제목" required="required" value="${ask.title }"/>
					<input class="custom-form-control" type="hidden" name="board_no" id="board_no" value="${ask.board_no}"/>
					<input class="custom-form-control" type="hidden" id="article_no" name="qna_no" value="${ask.qna_no }"/>
					<input class="custom-form-control" type="hidden" name="writer" value="${ask.writer}"/>
					<input class="custom-form-control" type="hidden" name="memNo" value="${ask.memNo}"/>
					</div>
				<div class="list-group-item p-0 mb-3">
					<textarea id="content" class="form-control m-0 h-50" name="content" required="required" rows="50" cols="">${board.content }</textarea>
				</div>
				<!-- 등록 -->
				<div class="mt-4">
					<button type="submit" class="btn btn-warning btn-modify">수정</button>
					<button type="button" class="btn btn-warning btn-return" onclick="history.back();">취소</button>
				</div>
			</form>
		</div>
		<div class="col-md-3 order-md-2 mb-4 font-jeju">
			<%@ include file="../include/trends.jsp" %>
		</div>
	</div>
</div>
<script>
	$(function(){
		var qnaNo = ${ask.qna_no };
		//validation
		$(".btn-modify").on("click",function(e){
			e.preventDefault();
			if($("#title").val()==""){
				alert("제목을 입력해주세요.");
			}
			if($("#content").val()==""){
				alert("내용을 입력해주세요.");
			}
			if($("#title").val()!="" && $("#froala-editor").val()!=""){
				$("#askModify").submit();
			}
		});
	});
</script>
<%@ include file="../include/footer.jsp"%>