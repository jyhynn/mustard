<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- <link rel="stylesheet" type="text/css" href="/resources/vendor/bootstrap/css/bootstrap.css" /> -->
</head>
<body>
	<div class="container mt-5">
		<div class="row">
			<div class="col-md-9 order-md-1 font-jeju">
				<div class="list-group-item mb-3">
					<h5>문의게시판</h5>
				</div>
				<div class="mb-3">
					<c:forEach var="a" items="${ask }">
						<a href="askRead?qna_no=${a.qna_no }" class="list-group-item list-group-item-action">
							<div class="d-flex w-100 justify-content-between">
								<input class="qna_no" type="hidden" name="qna_no" value="${a.qna_no }"/>
								<h6 class="mb-1">${a.title }</h6>
							</div>
							<small><fmt:formatDate pattern="yy/MM/dd hh:mm" value="${b.notice_date }"/> <span>${a.writer }</span></small>
							<c:if test="${a.classify==0 }">
								<span class="badge badge-light">답변대기중</span>
							</c:if>
							<c:if test="${a.classify!=0 }">
								<span class="badge badge-light">답변완료</span>
							</c:if>
						</a>
					</c:forEach>
				</div>
				<!-- 페이징 -->
				<nav aria-label="Page navigation example m-3">
					<ul class="pagination justify-content-center">${pageMenu }</ul>
				</nav>
				<!-- /페이징 -->
				<button type="button" class="mt-4 mb-5 btn btn-warning btn-write btn-sm">문의하기</button>
			</div>
			<div class="col-md-3 order-md-2 mb-4 font-jeju">
				<%@ include file="../include/trends.jsp"%>
			</div>
		</div>
	</div>
	<script>
		$(function() {
			var qnaNo = $(".qna_no").val();
			//var thum_image = $(".media");
			$(".btn-write").on("click", function() {
				location.href = '/board/askWrite';
			});

			//이미지 첨부 글일경우 리스트에 이미지 같이 표시
			/* $.getJSON({
				url : 'getAttachs',
				success : function(data) {
					$(data).each(function(i, obj) {
						var attach_notice_no = encodeURIComponent(obj.notice_no);
						var filePath = encodeURIComponent(obj.uploadPath);
						$.getJSON({
							url : 'getAttachList',
							data : {notice_no : attach_notice_no,
									board_no : 1},
							success : function(data) {
								console.log(data);
								var str = "";
								$(data).each(function(i,obj) {
									if(i==0){
										str = "<img src='/display?fileName="+ filePath+ "' class='ml-3'>";
									}
								});
								thum_image.html(str);
							}
						});//getAttachList
					});
				}
			});//getAttachs */
		});
	</script>
	<%@ include file="../include/footer.jsp"%>