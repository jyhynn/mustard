<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<title>우리동네</title>
<link rel="stylesheet" type="text/css" href="/resources/css/commons.css" />
<link rel="stylesheet" type="text/css" href="/resources/css/boardmain.css" />
<link href="/resources/css/small-business.css" rel="stylesheet">
<link href="/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<script src="/resources/jquery-3.3.1.js"></script>
<script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
</head>
<body class="bg-gray">
<!-- Navigation -->
<nav class="navbar navbar-expand-lg white fixed-top font-jeju">
	<div class="container">
		<a class="navbar-brand" href="/">
		<img src="/resources/icons/uri.png" class="logos mr-0" alt="..."></a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      
      <div class="collapse navbar-collapse" id="navbarResponsive">
	      <!-- 검색창 -->
			<ul class="navbar-nav ml-auto">
				<form class="garo my-2 my-lg-0">
					<select class="selectbox div-inline" name="board_no">
						<option value="3">지역</option>
						<option value="4">홍보</option>
						<option value="5">자유</option>
					</select> <input class="form-control searchkeyword" type="search" placeholder="검색" aria-label="Search">
					<button class="btn btn-outline-warning my-2 my-sm-0" type="button" id="button-addon2">
						<img src="/resources/icons/search.png" class="icons mr-0 mb-1" alt="...">
					</button>
				</form>
				<li class="nav-item active"><a class="nav-link"
					href=<c:if test="${!empty log }">"/?shi=${log.zip.shi }&gungu=${log.zip.gungu}&dong=${log.zip.dong}" </c:if>
					<c:if test="${empty log }">"/" </c:if>><img
						src="/resources/icons/home.png" class="icons mr-0 mb-1" alt="...">Home</span></a></li>
				<c:if test="${empty log }">
					<li class="nav-item"><a class="nav-link"
						href="/member/signin"> <img src="/resources/icons/user.png"
							class="icons mr-0 mb-1" alt="...">로그인
					</a></li>
					<li class="nav-item"><a class="nav-link"
						href="/member/register"> <img
							src="/resources/icons/userplus.png" class="icons mr-0 mb-1"
							alt="...">회원가입
					</a></li>
				</c:if>
				<c:if test="${!empty log }">
					<li class="nav-item"><a class="nav-link"
						href="/member/signout"> <img
							src="/resources/icons/logout.png" class="icons mr-0" alt="...">로그아웃
					</a></li>
					<li class="nav-item"><a class="nav-link"
						href="/member/mypage/myInfo"> <img
							src="/resources/icons/mypage.png" class="icons mr-0" alt="...">마이페이지
					</a></li>
					<c:if test="${log.memlevel==10 }">
						<li class="nav-item"><a class="nav-link"
							href="/admin/adminMain"> <img
								src="/resources/icons/setting.png" class="icons mr-0" alt="...">관리자페이지
						</a></li>
					</c:if>
				</c:if>
			</ul>
		</div>
	</div>
</nav>
<script>
$(function(){
	var logCheck = "${log.zip.shi}";
	
	$("#button-addon2").on("click",function(){
		if($(".searchkeyword").val()==""){
			alert("검색어를 입력해주세요.");
			return;
		}else{
			if(logCheck==""){
				location.href="/board/searching?board_no=" + $(".selectbox").val()
				+ "&keyword=" + $(".searchkeyword").val() 
				+ "&shi=${guest.shi}&gungu=${guest.gungu}&dong=${guest.dong}";		
			}else{
			location.href="/board/searching?board_no=" + $(".selectbox").val()
						+ "&keyword=" + $(".searchkeyword").val() 
						+ "&shi=${log.zip.shi}&gungu=${log.zip.gungu}&dong=${log.zip.dong}";		
			}
		}
	})
});
</script>