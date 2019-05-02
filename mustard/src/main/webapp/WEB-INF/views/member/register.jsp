<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/resources/css/mainstyles.css">
<link type="text/css" href="/resources/css/register.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.0/dist/jquery.validate.js"></script>
<script src="/resources/js/messages_ko.js"></script>
<script src="/resources/js/registValidation.js"></script>
<script src="/resources/js/register.js"></script>
</head>
<body> 
	<div id="container" class="register">
		<div style="text-align:center">
			<img class="mb-0" src="/resources/icons/uri.png" alt="logo" width="150" height="150" style="margin:50px">		
			<h4 class="h3 mb-2 font-weight-normal"> 시작하기 </h4>
		</div>
		<!-- <button class="btn btn-lg btn-primary btn-block m-2 start-kakao" type="button">카카오계정으로 시작하기</button> -->
		<form class="form-signin" id="form-signin" action="reigstMember" method="post">
			<button class="btn btn-lg btn-block m-2 start-email btn-warning white" type="button">이메일로 시작하기</button>
			<div class="form-start-email">
				<c:if test="${email=='' }">
					<input type="email" id="email" name="email" class="form-control m-2" placeholder="이메일" required autofocus>
					<label for="email" class="tip tip-email">비밀번호 찾기에 사용</label> <br>
					<!-- <label for="email" class="tip email-msg"></label> -->
					<button class="btn btn-lg btn-block m-2 start-email btn-warning white auth-email" type="button">이메일 인증하기</button> 
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
			<div class="select-location mr-0">
				<select name="zip.shi" id="shi">
					<option value="">-----시-----</option>
				</select>
				<select name="zip.gungu" id="gungu">
					<option value="">----군/구----</option>
				</select>
				<select name="zip.dong" class="donglist" id="donglist"></select>
			</div>
		<div id="step4" class="step mt-3">
			<h2>약관</h2>
			<p class="mt-3 mb-1">
				<label class="checkbox bold">
				<input type="checkbox" id="agree_all" name="agree_all">우리동네 통합약관에 모두 동의합니다.</label>
			</p>
			<p class="mt-3 mb-0">
				<label class="checkbox">
				<input type="checkbox" id="agree_service" name="agree_service" required>우리동네 통합서비스이용약관 동의 (필수)</label>
			</p>
			<article class="agreement service">
				제1조(목적)

				우리동네 통합서비스이용약관은 회사가 다양한 맞춤 서비스를 제공함에 있어, 회사와 회원 간의 권리, 의무 및 책임 사항 등을 규정함을 목적으로 합니다.
				
				제2조(정의)
				
				1. "회사"란 서비스를 제공하는 주체를 말합니다.
				2. "서비스"란, 회사가 제공하는 우리동네, 캠퍼스픽, 책방, 오늘의학식 등 회사가 제공하는 서비스를 말합니다. 서비스는 정보통신설비를 이용하여 재화 및 용역을 거래할 수 있도록 설정한 가상의 영업장을 포함합니다. 서비스는 각 서비스 내부에서 보여지는 게시물, 기능, 재화, 용역 등을 모두 포함하며, 이와 관련된 사항과 정보 또한 모두 포함합니다.
				3. "회원"이란, 회사가 제공하는 서비스에 접속하여 본 약관을 동의하고 가입한 후 서비스를 제공받는 자를 말합니다.
				4. "게시물"이란, 서비스에 게재되는 모든 문자, 사진, 영상, 정보 등을 말합니다.
				5. "커뮤니티"란, 1:1 대화를 포함하여 회사가 제공하는 서비스 내 게시물이 게재될 수 있는 모든 공간을 말합니다.
				6. "약정"이란, 구매, 판매, 공급, 지급, 제작, 중개, 중계, 당첨 등 서비스 내부에서 회사와 회원 사이에 발생한 계약, 서약, 약속 등을 말합니다.
				7. "모든 약관"이란, 우리동네 통합서비스이용약관, 우리동네 통합개인정보처리방침 등 회사와 회원이 계약한 모든 약관을 말합니다.
				....등등
			</article>
			<p class="mt-3 mb-0">
				<label class="checkbox">
				<input type="checkbox" id="agree_privacy" name="agree_privacy" required>우리동네 통합개인정보처리방침 동의 (필수)</label>
			</p>
			<article class="agreement privacy">
				우리동네 통합개인정보처리방침은 우리동네, 정보 게시판, 지역 게시판, 홍보 게시판 등 회사가 제공하는 다양한 맞춤 서비스를 제공함에 있어, 정보를 어떻게 수집·이용·보관·파기하는지에 대한 정보를 담은 방침을 의미합니다. 우리동네 통합개인정보처리방침은 개인정보보호법, 정보통신망 이용촉진 및 정보보호 등에 관한 법률 등 국내의 개인정보 보호 법령을 준수하고 있으며, 각 서비스에서 언제든지 이 방침을 확인할 수 있습니다.....등등
			</article>
			<p class="mt-3 mb-0">
				<label class="checkbox">
				<input type="checkbox" id="agree_rules" name="agree_rules" required>우리동네 통합커뮤니티이용규칙 확인 (필수)</label>
			</p>
			<article class="agreement rules">
				[ 우리동네 커뮤니티이용규칙 ]

				1. 우리동네의 커뮤니티는 회원이 직접 만들어가는 공간입니다.
				
				- 우리동네는 회원분들의 자정 능력을 존중합니다. 깨끗한 커뮤니티를 위해 노력해주시기 바랍니다.
				- 회원은 서로 예의를 지키고, 존중해야 합니다.
				
				2. 다음 목록에 해당하는 게시물의 게시, 게시판의 개설을 금지하고 있습니다.
				
				- 욕설, 비아냥, 비속어 등 예의범절에 벗어난 게시물
				- 혐오스럽거나 타 회원을 놀라게 하는 게시물
				- 성적 비하를 포함하는 게시물
				- 불건전한 만남, 대화, 통화 등을 목적으로 하는 게시물
				- 특정인이나 단체/지역 등을 비방하는 게시물
				- 중복글, 도배글, 낚시글, 내용 없는 게시물
				- 익명을 악용한 여론 조작
				- 관련법에 위배되거나, 타인의 권리를 침해하는 게시물(초상권, 저작권 등)
				- 허가되지 않은 광고/홍보물 및 회사/상업체 연관 게시물 또는 이와 유사한 간접 홍보, 바이럴 게시물 일체 (타 서비스 및 사이트, 공동구매, 이벤트, 티켓판매, 참가비, 구인, 채용, 공모전, 대외활동, 아카데미 등)
				- 허가되지 않은 기부금품 모집 게시물
				- 논란 및 분란을 일으킬 수 있는 게시물
				- 청소년유해매체물, 외설, 음란물, 음담패설, 신체사진
				- 관리자를 사칭하는 게시물
				- 기타 부적합한 게시물
				
				3. 다음 목록에 해당하는 규칙을 모두 지켜야 합니다.
				
				- 타인의 개인정보 및 계정을 수집, 저장, 공개, 이용하거나, 자신의 개인정보 및 계정을 공개, 공유해서는 안 됩니다.
				- 회원이 관련법 및 각 약관에 위배되는 내용의 게시판을 개설하거나 게시물을 게시할 경우, 삭제, 중단, 변경 등의 제재가 가해질 수 있으며, 회원은 자격 및 권한을 제한, 정지, 박탈당할 수 있습니다.
				
				4. 관리자 권한
				
				- 관리자는 자신의 게시판에 올라오는 게시물을 공지로 지정하거나 삭제, 경고할 수 있습니다
				- 관리자는 게시판에서 탈퇴할 수 없으며, 다른 회원에게 관리자 권한을 양도할 수 있습니다.
				- 관리자는 게시판 개설 후 3일이 지나지 않았거나, 14일 동안 게시물이 올라오지 않았을 때만 해당 게시판을 삭제할 수 있습니다.
				
				5. 게시물 신고 제도
				
				- 커뮤니티 이용규칙에 어긋난다고 생각하는 게시물은 신고 버튼을 이용하여 신고해주시기 바랍니다.
				- 모든 신고는 자동신고시스템을 통해 자동으로 처리됩니다. 회원의 요청에 따라 게시물을 삭제하지 않습니다.
				- 신고가 누적된 회원은 접근 제한 등의 제재가 가해질 수 있습니다.
				- 신고 제도를 악용할 경우, 해당 신고는 처리되지 않습니다. 신고 제도를 악용한 회원은 제재가 가해질 수 있습니다.
				
				6. 허위사실 유포 및 명예훼손 게시물에 대한 게시중단 요청
				
				- 허위사실 유포 및 명예훼손 등 권리를 침해하는 게시물의 게시중단을 원하실 경우, 문의하기를 통해 게시중단 요청을 전달주시기 바랍니다.
				- 게시중단 요청 시 사실을 증명할 수 있는 자료를 같이 보내주셔야 합니다.
				- 게시중단 요청은 담당자를 통해 접수된 순서에 따라 처리됩니다.
				- 허위사실 유포 및 명예훼손에 해당하지 않는다고 판단되는 경우, 해당 게시물은 게시중단 처리되지 않습니다.
				
				....등등
			</article>
		</div>
		<button class="btn btn-lg btn-block start-email btn-warning white goRegist" type="submit">가입하기</button> 
		</form>
	</div>
<%@ include file="../include/footer.jsp"%>