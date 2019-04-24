<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/resources/vendor/bootstrap/css/bootstrap.min.css" />
</head>
<body>
<div class="container mt-5">
	<div class="row">
		<div class="col-md-9 order-md-1 font-jeju">
			<div class="list-group-item">
				<h1 class="display-7 mb-3">${notice.title }</h1>
			  	<p>${notice_date} ${notice.writer } <!-- 조회수 댓글수 스크랩수 신고여부 --></p>
			  	<input type="hidden" name="notice_no" value="${notice.notice_no }"/>
			  	<hr class="my-4">
			  	<p class="lead">${notice.content }</p>
			</div>
			<!-- 댓글 -->
			<ul class="list-group mt-4">
				<li class="list-group-item"><small>작성자</small> <small>작성시간</small> <small>좋아요/싫어요</small>
					<br>댓글</li>
			</ul>
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