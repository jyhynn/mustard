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
					<h5>공지사항</h5>
				</div>
				<c:forEach var="n" items="${notice }">
					<a href="noticeRead?notice_no=${n.notice_no }&board_no=${n.board_no}" class="list-group-item list-group-item-action">
						<div class="d-flex w-100 justify-content-between">
							<input class="notice_no" type="hidden" name="notice_no" value="${n.notice_no }"/>
							<h6 class="mb-1">${n.title }</h6>
							<c:if test="${!empty n.noticeAttach }">
								<div class="media"></div>
							</c:if>
						</div>
						<p class="mb-1">${n.content }</p> 
						<small><fmt:formatDate pattern="yy/MM/dd hh:mm" value="${n.notice_date }"/> <span>${n.writer }</span></small>
					</a>
				</c:forEach>
				<!-- 페이징 -->
				<nav aria-label="Page navigation example mt-3">
					<ul class="pagination justify-content-center">
						<c:if test="${!empty pageMaker.prev }">
							<li class="page-item disabled"><a class="page-link" href="${pageMaker.startPage-1 }" tabindex="-1" aria-disabled="true">&laquo;</a></li>
						</c:if>
						<c:forEach var="idx" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
							<li class="page-item ${pageMaker.cri.pageNum==idx?'active':'' }">
								<a class="page-link" href="${idx }">${idx }</a>
							</li>
						</c:forEach>
						<c:if test="${!empty pageMaker.next }">
							<li class="page-item"><a class="page-link" href="${pageMaker.endPage+1 }">&raquo;</a>
						</c:if>
						</li>
					</ul>
				</nav>
				<!-- /페이징 -->
				<c:if test="${log.memlevel==10 }">
					<button type="button" class="mt-4 mb-5 btn btn-warning btn-write">글쓰기</button>
				</c:if>
			</div>
			<div class="col-md-3 order-md-2 mb-4 font-jeju">
				<%@ include file="../include/trends.jsp"%>
			</div>
		</div>
	</div>
	<script>
		$(function() {
			var noticeNo = $(".notice_no").val();
			var thum_image = $(".media");

			$(".btn-write").on("click", function() {
				location.href = 'noticeWrite';
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