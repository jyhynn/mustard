<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="list-group-item mb-3">
	<h5>마이 페이지</h5>
	<a href="myInfo" class="list-group-item list-group-item-action">기본
		정보</a> <a href="changeMyInfo?&memNo=${log.memNo }"
		class="list-group-item list-group-item-action">개인정보 변경</a> <a
		href="mylist?mylistno=1&memNo=${log.memNo }"
		class="list-group-item list-group-item-action">내가 쓴 글</a> <a
		href="mylist?mylistno=2&memNo=${log.memNo }"
		class="list-group-item list-group-item-action">댓글 단 글</a> <a
		href="mylist?mylistno=3&memNo=${log.memNo }"
		class="list-group-item list-group-item-action">내 스크랩</a> <a
		href="removeMember?&memNo=${log.memNo }"
		class="list-group-item list-group-item-action">회원탈퇴</a>
</div>
