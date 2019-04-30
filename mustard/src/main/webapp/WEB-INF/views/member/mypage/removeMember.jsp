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
			<div class="col-md-9 order-md-1 font-jeju">
				<div class="list-group-item mb-3">
						<h5>회원탈퇴</h5>
				</div>
				<ul class="list-group">
					<li class="list-group-item"><b>이메일 </b> <br>${log.email }</li>
					<li class="list-group-item"><b>닉네임 </b> <br>${log.nick }</li>
					<li class="list-group-item"><b>정말로 탈퇴하시겠습니까? 탈퇴사유를 간략히 적어주세요. </b>
						<textarea id="reason" rows="" cols=""></textarea>
						<button type="button" class="btn go-remove">탈퇴하기</button>
					</li>
				</ul>
			</div>
			<div class="col-md-3 order-md-2 mb-4 font-jeju">
				<%@ include file="../../include/mypagetab.jsp"%>
			</div>
		</div>
	</div>
	<script>
		$(function(){
			$(".go-remove").on("click",function(){
				$.ajax({
					url: '/member/removeMember',
					type : 'post',
					data : {memNo : logedMemNo,
							reason : $("#reason").val();},
					success:function(data){
						if(data=="removeSuccess"){
							alert("탈퇴처리되었습니다. 이용해주셔서 감사합니다.");
						}else{
							alert("탈퇴처리실패.");
						}
					}
				})//ajax
			});
		})
	</script>
<%@ include file="../../include/footer.jsp"%>