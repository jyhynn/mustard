<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/header.jsp"%>
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
</head>
<body>
	<div class="container mt-5">
		<div class="row">
			<div class="col-md-3 order-md-2 mb-4 font-jeju">
				<div class="list-group-item mb-3">
					<h5>마이 페이지</h5>
					<a href="myInfo" class="list-group-item list-group-item-action">기본 정보</a>
					<a href="changeMyInfo?&memNo=${log.memNo }" class="list-group-item list-group-item-action">개인정보 변경</a>
					<a href="mylist?mylistno=1&memNo=${log.memNo }" class="list-group-item list-group-item-action">내가 쓴 글</a>
					<a href="mylist?mylistno=2&memNo=${log.memNo }" class="list-group-item list-group-item-action">댓글 단 글</a>
					<a href="mylist?mylistno=3&memNo=${log.memNo }" class="list-group-item list-group-item-action">내 스크랩</a>
					<a href="removeMember?&memNo=${log.memNo }" class="list-group-item list-group-item-action">회원탈퇴</a>
				</div>
			</div>
			<div class="col-md-9 order-md-1 font-jeju">
				<div class="list-group-item mb-3">
						<h5>기본 정보</h5>
				</div>
				<ul class="list-group">
					<li class="list-group-item"><b>이메일 </b> ${log.email }</li>
					<li class="list-group-item"><b>지역 </b></li>
				</ul>
			</div>
		</div>
	</div>
<%@ include file="../../include/footer.jsp"%>