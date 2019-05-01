<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- <link rel="stylesheet" type="text/css" href="/resources/vendor/bootstrap/css/bootstrap.min.css" /> -->
</head>
<body>
	<div class="container mt-5">
		<div class="row">
			<div class="col-md-9 order-md-1 font-jeju">
				<div class="list-group-item mb-3">
					<h3>문의게시판</h3>
					</div>
					<form action="askModify" id="askRead">
						<div class="list-group-item">
							<h4 class="display-7 mb-3">${ask.title }</h4>
						  	<p>${ask.qna_date} ${ask.writer }
						  		<c:if test="${ask.classify==0 }">
									<span class="badge badge-light">답변대기중</span>
								</c:if>
								<c:if test="${ask.classify==1 }">
									<span class="badge badge-light">답변완료</span>
								</c:if>
						  	<input type="hidden" name="qna_no" value="${ask.qna_no }"/>
						  	<input type="hidden" name="board_no" value="${ask.board_no }"/>
						  	<input type="hidden" name="memNo" id="memNo" value="${ask.memNo }"/>
						  	<p class="lead">${board.content }</p>
						</div>
					</form>
				<div class="mt-4">
					<c:if test="${log.memNo==ask.memNo }">
						<button type="button" class="btn btn-warning btn-modify btn-sm">수정</button>
						<button type="button" class="btn btn-warning btn-delete btn-sm">삭제</button>
					</c:if>
				</div>
				<!-- 댓글달기 -->
				<div class="list-group mt-4 mb-5">
					<c:if test="${log.memlevel==10 }">
						<div class="input-group mb-3">
							<input id="reply" name="reply" type="text" class="form-control" placeholder="댓글">
							<div class="input-group-append">
								<span class="btn btn-warning btn-reply">등록</span>
							</div>
						</div>
					</c:if>
					<!-- 댓글리스트 -->
					<div>
						<ul class="replyBox"></ul>
					</div>
				</div>
			</div>
			<div class="col-md-3 order-md-2 mb-4 font-jeju">
				<%@ include file="../include/trends.jsp" %>
			</div>
		</div>
	</div>
 <%--	<form id="operForm" action="noticeModify">
        <input type="hidden" name="pageNum" value="${cri.pageNum }" />
		<input type="hidden" name="amount" value="${cri.amount }" />
		<input type="hidden" name="keyword" value="${cri.keyword }" />
		<input type="hidden" name="type" value="${cri.type }" /> 
    </form>    --%>
<script>
$(function(){
	var qnaNo = ${ask.qna_no };
	var re_box = $(".replyBox");
	var logedMemNo = ${log.memNo};
	var logedNick = "${log.nick}";

	showReply();
	
	$(".btn-modify").on("click",function(){
		$("#askRead").submit();
	});
	$(".btn-delete").on("click",function(){
		var result = confirm('삭제하시겠습니까?'); 
		if(result) {
			$("#askRead").attr("method","post");
			$("#askRead").attr("action","removeAsk").submit();
		} else {
			return;
		}
	});
	
	function showReply(){
		 $.getJSON({
			url : '/replies/getReplies',
			data : {article_no:qnaNo},
			success:function(data){
				var str = "";
				console.log(data);
				$(data).each(function(i,obj){
					str += "<li class='list-group-item' data-reno='" + obj.reNo + "'>";
					str += "<input type='hidden' name='reNo' data-reno='" + obj.reNo + "' value='" + obj.reNo + "' />";
					str += "<input type='hidden' name='board_no' data-boardno='" + obj.board_no + "' value='" + obj.board_no + "' />";
					str += "<input type='hidden' name='article_no' data-articleno='" + obj.article_no + "' value='" + obj.article_no + "' />";
					str += "<input type='hidden' name='writer' value='" + obj.writer + "' />";
					str += "<input type='hidden' name='memNo' value='" + obj.memNo + "' />";
					str += "<input type='hidden' name='reply' value='" + obj.reply + "' />";
					str += "<small class='re_writer'> " + obj.writer + " </small>";
					str += "<small class='time'> " + obj.replyDate + " </small>";
					str += "<small><span class='btn badge badge-light re-likey' data-reno='" + obj.reNo +"'>♥ " + obj.likey + "</span>";
					str += "<span class='btn badge badge-danger re-report' data-reno='" + obj.reNo +"' data-memno='" + obj.memNo + "'>신고</span>";
					str += "<c:if test='${log.memNo==" + obj.memNo + "}'><span class='btn badge badge-light re-del' data-reno='" + obj.reNo +"'> X 삭제 </span></c:if></small>";
					str += "<br><p class='replyContent'>" + obj.reply + "</p></li>";					
				});	
			//	console.log(str);
				re_box.html(str);
			}
		});//getJSON
	 }//showReply
	
	//댓글 입력
	$(".btn-reply").on("click",function(){
		if(logedMemNo==null){
			alert("로그인 후 이용가능합니다");
		}else{
			$.ajax({
				type:"post",
				url : '/replies/insertReply',
				data : {notice_no : qnaNo,
						reply : $("#reply").val(),
						board_no : boardNo,
						writer : logedNick,
						memNo : logedMemNo},
				success:function(data){
					console.log(data);
					 $("#reply").val("");
					 getReplyamount();
					 showReply();
				}
			});
		}
	});
	 
	 //댓글삭제
	$(".replyBox").on("click",".re-del",function(){
		var reNo  =$(this).data("reno");
		 $.ajax({
			type:"post",
			url : '/replies/deleteReply',
			data : {article_no : qnaNo,
					reNo : reNo,
					board_no : boardNo},
			success:function(data){
				console.log(data);
				if(data=='reDelSuccess'){
					alert("댓글이 삭제되었습니다.");
					showReply();
				}else{
					alert("댓글 삭제 실패.");
				}
			}
		});	//ajax	
	}); 

});
</script>
<%@ include file="../include/footer.jsp"%>