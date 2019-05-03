<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../include/header.jsp"%>
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
<title>Insert title here</title>
<!-- <link rel="stylesheet" type="text/css" href="/resources/vendor/bootstrap/css/bootstrap.css" /> -->
</head>
<body>
	<div class="container mt-5">
		<div class="row">
			<div class="col-md-9 order-md-1 font-jeju">
				<div class="list-group-item mb-3">
					<c:if test="${mylistno==1 }">
						<h3>내가 쓴 글</h3>
					</c:if>
					<c:if test="${mylistno==2 }">
						<h3>댓글 단 글</h3>
					</c:if>
					<c:if test="${mylistno==3}">
						<h3>스크랩 리스트</h3>
					</c:if>
				</div>
				<c:forEach var="m" items="${mylist }">
					<a href="/board/boardRead?article_no=${m.article_no }&board_no=${m.board_no}" class="list-group-item list-group-item-action">
						<div class="d-flex w-100 justify-content-between">
							<input class="article_no" type="hidden" name="article_no" value="${m.article_no }"/>
							<h4 class="mb-1">${m.title }</h4>
							<%-- <c:if test="${!empty b.attach }">
								<div class="media"></div>
							</c:if> --%>
						</div>
						<p class="mb-1">${m.content }</p> 
						<small>${m.notice_date } <span>${m.writer }</span></small>
						<span class="badge badge-light">조회수 ${m.readhit }</span>
						<span class="badge badge-light">댓글 ${m.replycnt }</span>
						<span class="badge badge-light">♥ ${m.likey }</span>
					</a>
				</c:forEach>
				<c:if test="${empty mylist }">
					<a href="#" class="list-group-item list-group-item-action" aria-disabled="true">
						<div class="d-flex w-100 justify-content-between">
							<h4 class="mb-1">작성한 글이 없습니다.</h4>
						</div>
					</a>
				</c:if>
				<!-- 페이징 -->
				<nav aria-label="Page navigation example">
					<ul class="pagination justify-content-center">
						<c:if test="${pageMaker.prev }">
							<li class="page-item disabled"><a class="page-link" href="${pageMaker.startPage-1 }" tabindex="-1" aria-disabled="true">&laquo;</a></li>
						</c:if>
						<c:forEach var="idx" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
							<li class="page-item ${pageMaker.cri.pageNum==idx?'active':'' }">
								<a class="page-link" href="${idx }">${idx }</a>
							</li>
						</c:forEach>
						<c:if test="${pageMaker.next }">
							<li class="page-item"><a class="page-link" href="${pageMaker.endPage+1 }">&raquo;</a>
						</c:if>
						</li>
					</ul>
				</nav>
				<!-- /페이징 -->

				<button type="button" class="mt-4 mb-5 btn btn-warning btn-write">글쓰기</button>
			</div>
			<div class="col-md-3 order-md-2 mb-4 font-jeju">
				<%@ include file="../../include/mypagetab.jsp"%>
			</div>
		</div>
	</div>
	<%@ include file="../../include/footer.jsp"%>