<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/resources/vendor/bootstrap/css/bootstrap.css" />
</head>
<body>
	 <div class="container mt-5">
		<div class="row">
			<div class="col-md-9 order-md-1 font-jeju">
				<div class="list-group-item mb-3">
					<h3>공지사항</h3>
				</div>
			<c:forEach var="n" items="${notice }">
				<a href="noticeRead?notice_no=${n.notice_no }" class="list-group-item list-group-item-action">
					<div class="d-flex w-100 justify-content-between">
						<h4 class="mb-1">${n.title }</h4>
						<small>첨부파일 있을 경우 표시</small>
					</div>
					<p class="mb-1">${n.content }</p> 
					<small>${n.notice_date } <span >${n.writer }</span></small>
				</a> 
			</c:forEach>
			</div>
			<div class="col-md-3 order-md-2 mb-4 font-jeju">
				<ul class="list-group">
				  <li class="list-group-item disabled" aria-disabled="true">정보 게시판</li>
				  <li class="list-group-item"><a href="#">지역 게시판</a></li>
				  <li class="list-group-item"><a href="#">홍보 게시판</a></li>
				  <li class="list-group-item"><a href="#">자유 게시판</a></li>
				  <li class="list-group-item"><a href="/board/noticeList">공지사항</a></li>
				</ul>
			</div>
		</div>
	</div>
	<%@ include file="../include/footer.jsp"%>