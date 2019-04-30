<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body class="text-center">
  <form class="form-signin" action="goSignin" method="post">
  <!-- <img class="mb-4" src="" alt="" width="72" height="72"> -->
  <h1 class="h3 mb-3 font-weight-normal">Mustard</h1>
  <div class="form-label-group">
  	<input type="email" id="email" name="email" class="form-control m-2" placeholder="이메일" required autofocus>
  </div>
  <div class="form-label-group">
  	<input type="password" id="password" name="password" class="form-control m-2" placeholder="비밀번호" required>
  </div>
  <button class="btn btn-lg btn-block m-2 start-email btn-warning" type="submit">로그인</button>
  <div class="checkbox mb-3">
    <label>
      <input type="checkbox" value="remember-me"> Remember me
    </label>
    <p><a href="#">아이디/비밀번호 찾기</a></p>
  </div>
  
  <p class="mt-5 mb-3 text-muted">처음이신가요? <a href="register"><span>회원가입</span></a>하기</p>
</form>
</body>
</html>