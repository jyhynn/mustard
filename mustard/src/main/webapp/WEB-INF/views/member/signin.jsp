<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body style="text-align:center; margin-top:7%;">
  <form class="form-signin" action="signin" method="post">
  <img class="mb-4" src="/resources/icons/uri.png" alt="logo" width="150" height="150" style="margin:50px">
  
  <div class="form-label-group">
  	<input type="email" id="email" name="email" class="form-control m-2" placeholder="이메일" required autofocus>
  </div>
  <div class="form-label-group">
  	<input type="password" id="password" name="password" class="form-control m-2" placeholder="비밀번호" required>
  </div>
  <button class="btn btn-lg btn-block m-2 start-email btn-warning white" type="submit">로그인</button>
  <div class="checkbox mb-3">
     <p class="find">
        <a href="#">비밀번호 찾기</a>
      </p>
  <p class="text-muted">처음이신가요? <a href="register"><b><span>회원가입</span></b></a>하기</p>
  </div>
  
</form>
<script>
	$(function(){
		var error = '${error}';
		if(error=='LogFailed'){
			alert('이메일 혹은 비밀번호를 확인해주세요.');
			return;
		}	
	})
	
</script>
<%@ include file="../include/footer.jsp"%>