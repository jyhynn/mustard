<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
					<c:if test="${bno==3 }">
						<h5>지역게시판</h5>
					</c:if>
					<c:if test="${bno==4 }">
						<h5>홍보게시판</h5>
					</c:if>
					<c:if test="${bno==5 }">
						<h5>자유게시판</h5>
					</c:if>
				</div>
				<c:if test="${bno!=2}">	
					<c:forEach var="s" items="${search }">
						<a href="boardRead?article_no=${s.article_no }&board_no=${s.board_no}" class="list-group-item list-group-item-action">
							<div class="d-flex w-100 justify-content-between">
								<input class="article_no" type="hidden" name="article_no" value="${s.article_no }"/>
								<h6 class="mb-1">${s.title }</h6>
							</div>
							<p class="mb-1">${s.content }</p> 
							<small><fmt:formatDate pattern="yy/MM/dd hh:mm" value="${s.notice_date }"/> <span>${s.writer }</span></small>
							<span class="badge badge-light">조회수 ${s.readhit }</span>
							<span class="badge badge-light">댓글 ${s.replycnt }</span>
							<span class="badge badge-light">♥ ${s.likey }</span>
						</a>
					</c:forEach>
				</c:if>
				<!-- 페이징 -->
				<nav aria-label="Page navigation example">
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
			</div>
			<div class="col-md-3 order-md-2 mb-4 font-jeju">
				<%@ include file="../include/trends.jsp"%>
			</div>
		</div>
	</div>
	<script>
		$(function() {
			var articleNo = $(".article_no").val();
			var thum_image = $(".media");
		});
	</script>
	<%@ include file="../include/footer.jsp"%>