<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<title>Mustard</title>
<link rel="stylesheet" type="text/css" href="/resources/css/commons.css" />
<link rel="stylesheet" type="text/css" href="/resources/css/boardmain.css" />
<link href="/resources/css/small-business.css" rel="stylesheet">
<link href="/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<script src="/resources/jquery-3.3.1.js"></script>
<script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<!-- Navigation -->
<nav class="navbar navbar-expand-lg bg-mustard fixed-top font-jeju">
	<div class="container">
		<a class="navbar-brand" href="/">우리동네</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarResponsive">
			<ul class="navbar-nav ml-auto">
				<li class="nav-item active">
					<a class="nav-link" href="/">Home<span class="sr-only">(current)</span></a>
				</li>
				<c:if test="${empty log }">
				<li class="nav-item"><a class="nav-link" href="/member/signin">로그인</a></li>
				<li class="nav-item"><a class="nav-link" href="/member/register">회원가입</a></li>
			</c:if>
			<c:if test="${!empty log }">
				<li class="nav-item"><a class="nav-link" href="/member/signout">로그아웃</a></li>
				<li class="nav-item"><a class="nav-link" href="/member/mypage/myInfo">마이페이지</a></li>
				<c:if test="${log.memlevel==10 }">
					<li class="nav-item"><a class="nav-link" href="/admin/adminMain">관리자페이지</a></li>
				</c:if>
			</c:if>
			</ul>
		</div>
	</div>
</nav>