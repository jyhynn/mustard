<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/resources/css/mainstyles.css">
<link type="text/css" href="/resources/css/register.css" rel="stylesheet">
<link rel="stylesheet" href="/resources/vendor/bootstrap/css/bootstrap.css">
<script src="/resources/jquery-3.3.1.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.0/dist/jquery.validate.js"></script>
<script src="/resources/js/messages_ko.js"></script>
<script src="/resources/js/registValidation.js"></script>
<script src="/resources/js/register.js"></script>
</head>
<body> 
	<div id="container" class="register">
		<h1 class="logo">
			<a href="#">Mustard 회원가입</a>
		</h1>
				
		<h1 class="h3 mb-3 font-weight-normal">[사이트이름]</h1>
		<button class="btn btn-lg btn-primary btn-block m-2 start-email" type="button">이메일로 시작하기</button>
		<!-- <button class="btn btn-lg btn-primary btn-block m-2 start-kakao" type="button">카카오계정으로 시작하기</button> -->
		<form class="form-signin" id="form-signin" action="reigstMember" method="post">
			<div class="form-start-email">
				<c:if test="${email=='' }">
					<input type="email" id="email" name="email" class="form-control m-2" placeholder="이메일" required autofocus>
					<label for="email" class="tip tip-email">비밀번호 찾기에 사용</label> <br>
					<label for="email" class="tip email-msg"></label>
					<button class="btn btn-lg btn-primary btn-block m-2 auth-email" type="button">이메일 인증하기</button> 
				</c:if>
				<c:if test="${email!='' }">
				<input type="email" id="email" name="email" class="form-control m-2" placeholder="이메일" value="${email }" readonly>
				<label for="email" class="tip email-msg">이메일 인증 완료</label>
				</c:if>
			</div>
			<div class="start-email-info">
				<input type="text" id="name" name="name" class="form-control m-2" placeholder="이름(실명)" required>
				<label for="name" class="tip tip-name">2~10자 한글,영문</label> 
				<input type="text" id="nick" name="nick" class="form-control m-2" placeholder="닉네임" >
				<label for="nick" class="tip tip-nick">2~20자. 미입력시 '익명'으로 설정</label> 
				<input type="password" id="password" name="password" class="form-control m-2" placeholder="비밀번호" required>
				<label for="password" class="tip tip-pwd">8~15자 영문, 숫자, 특수문자</label> 
				<input type="password" id="passwordCheck" name="passwordCheck" class="form-control m-2" placeholder="비밀번호 확인" required>
				<label for="passwordCheck" class="tip tip-pwdCk">비밀번호 재입력</label> 
			</div>
			<div class="select-location">
				<p class="tip tip-loc">나중에 선택 가능</p>
				<select name="shi" id="shi">
					<option value="">-----시-----</option>
				</select>
				<select name="gungu" id="gungu">
					<option value="">----군/구----</option>
				</select>
				<select name="dong" class="donglist" id="donglist"></select>
			</div>
		<div id="step4" class="step">
			<h2>약관</h2>
			<p>
				<label class="checkbox bold">
				<input type="checkbox" id="agree_all" name="agree_all">Mustard 통합약관에 모두 동의합니다.</label>
			</p>
			<p>
				<label class="checkbox">
				<input type="checkbox" id="agree_service" name="agree_service" required>Mustard 통합서비스이용약관 동의 (필수)</label>
			</p>
			<article class="agreement service">
				~~
			</article>
			<p>
				<label class="checkbox">
				<input type="checkbox" id="agree_privacy" name="agree_privacy" required>Mustard 통합개인정보처리방침 동의 (필수)</label>
			</p>
			<article class="agreement privacy">
				~~
			</article>
			<p>
				<label class="checkbox">
				<input type="checkbox" id="agree_rules" name="agree_rules" required>Mustard 통합커뮤니티이용규칙 확인 (필수)</label>
			</p>
			<article class="agreement rules">
				~~
			</article>
			<p>
				<label class="checkbox">
				<input type="checkbox" name="agree_ad">대학생 우대 이벤트 등 광고성 정보 수신 동의 (선택)</label>
			</p>
			<article class="agreement ad">
				영화/전시 초대 이벤트, 대학생 특별 할인 혜택 등 다양한 이벤트 및 정보를 서비스에서 만나보실 수 있습니다.<br>1.항목
				: 마케팅 수신 동의<br>2.목적: 서비스 및 이벤트 정보 안내<br>3.기간: 탈퇴 후 최대 1년<br>
			</article>
		</div>
		<button class="btn btn-lg btn-primary btn-block m-2 goRegist" type="submit">Mustard 가입하기</button> 
		</form>
	</div>
	<address>
		<ul class="links">
			<li class="copyright"><a href="#">&copy; Mustard</a></li>
			<li><a href="#">문의하기</a></li>
			<li><a href="#">개인정보처리방침</a></li>
		</ul>
	</address>

</body>
</html>