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
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
			<form id="writeForm" action="askWrite" method="post">
				<div class="list-group-item mb-3 p-0">
					<input class="custom-form-control" type="text" id="title" name="title" placeholder="제목" required="required"/>
					<input class="custom-form-control" type="hidden" name="board_no" value="6"/>
					<input class="custom-form-control" type="hidden" name="writer" value=${log.nick }"/>
					<input class="custom-form-control" type="hidden" name="memNo" value="${log.memNo }"/>
					</div>
				<div class="list-group-item p-0 mb-3">
					<textarea id="content" class="form-control m-0 h-50" placeholder="내용을 입력하세요" name="content" required="required" rows="50" cols=""></textarea>
				</div>
				<!-- 등록 -->
				<button type="submit" class="mt-4 mb-5 btn btn-warning btn-submit">등록</button>
			</form>
		</div>
		<div class="col-md-3 order-md-2 mb-4 font-jeju">
			<%@ include file="../include/trends.jsp" %>
		</div>
	</div>
</div>
<script>
	$(function(){
		$(".btn-submit").on("click",function(e){
			e.preventDefault();
			if($("#title").val()==""){
				alert("제목을 입력해주세요.");
				return;
			}
			if($("#content").val()==""){
				alert("내용을 입력해주세요.");
				return;
			}
			if("#title").val()!="" && $("#content").val(!=""){
				e.submit();
			}
		});
	});
</script>
<%@ include file="../include/footer.jsp"%>