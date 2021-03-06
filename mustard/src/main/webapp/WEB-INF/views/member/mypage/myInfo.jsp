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
						<h5>기본 정보</h5>
				</div>
				<ul class="list-group">
					<li class="list-group-item"><b>이메일 </b> <br>${log.email }</li>
					<li class="list-group-item"><b>닉네임 </b> <br>${log.nick }</li>
					<li class="list-group-item"><b>지역 </b> 
					<div class="select-location">
						<select name="zip.shi" id="shi" disabled="disabled">
							<option value="">${log.zip.shi }</option>
						</select> 
						<select name="zip.gungu" id="gungu" disabled="disabled">
							<option value="">${log.zip.gungu }</option>
						</select>
						<select name="zip.dong" id="dong" disabled="disabled">
							<option value="">${log.zip.dong }</option>
						</select>
					</div>
					</li>
				</ul>
			</div>
			<div class="col-md-3 order-md-2 mb-4 font-jeju">
				<%@ include file="../../include/mypagetab.jsp"%>
			</div>
		</div>
	</div>
<%@ include file="../../include/footer.jsp"%>