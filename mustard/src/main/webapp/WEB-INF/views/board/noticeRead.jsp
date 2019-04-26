<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
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
						<h3>공지사항</h3>
					</div>
					<form action="noticeModify" id="readNotice">
						<div class="list-group-item">
							<h4 class="display-7 mb-3">${notice.title }</h4>
						  	<p>${notice.notice_date} ${notice.writer } <!-- 조회수 댓글수 스크랩수 신고여부 --></p>
						  	<input type="hidden" name="notice_no" value="${notice.notice_no }"/>
						  	<input type="hidden" name="memNo" value="${notice.memNo }"/>
						  	<input type="hidden" name="board_no" value="${notice.board_no }"/>
						  	<hr class="my-4">
						  	<div class="showImages">
						  		<div class="showFiles"><ul></ul></div>
						  	</div>
						  	<p class="lead">${notice.content }</p>
						</div>
					</form>
				<div class="mt-4">
					<button type="button" class="btn btn-warning btn-modify">수정</button>
					<button type="button" class="btn btn-warning btn-delete">삭제</button>
					<button type="button" class="btn btn-danger btn-report">신고</button>
				</div>
				<!-- 댓글달기 -->
				<div class="list-group mt-4 mb-5">
					<div class="input-group mb-3">
						<input id="reply" name="reply" type="text" class="form-control" placeholder="댓글">
						<div class="input-group-append">
							<span class="btn btn-warning btn-reply">등록</span>
						</div>
					</div>
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
	var noticeNo = ${notice.notice_no };
	var boardNo = ${notice.board_no };
	var re_box = $(".replyBox");
	
	$.getJSON({
		url : 'getAttachList',
		data : {notice_no:noticeNo,
				board_no:boardNo},
		success:function(data){
			console.log(data);
			
			var uploadResult = $(".showImages");
			var str="";
			$(data).each(function(i,obj){
				var filePath = encodeURIComponent(obj.uploadPath + "\\" + obj.uuid + "_" + obj.fileName);
				if(obj.fileType){//이미지
					//썸네일 이미지 경로
					str+="<input type='hidden' data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "' data-type='" + obj.fileType + "'>";
					str+="<img src='/display?fileName=" + filePath + "' class='card-img'>";
				}else{//false : 이미지 외
					str+="<li data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "' data-type='" + obj.fileType + "'>";
					str+="<div><span><a href='/download?fileName=" + filePath + "'>" + obj.fileName + "</a></span></div></li>";
				}
			});
			uploadResult.append(str);
		}
	});
	//첨부파일 다운로드
	$(".showFiles").on("click","li",function(){
		var liObj=$(this);
		var path=encodeURIComponent(liObj.data("path") + "/" + liObj.data("uuid") + "_" + liObj.data("filename"));
		self.location="/download?fileName=" + path;
	});
	
	$(".btn-modify").on("click",function(){
		$("#readNotice").submit();
	});
	$(".btn-delete").on("click",function(){
		$("#readNotice").attr("method","post")
		$("#readNotice").attr("action","remove").submit();
	});
	showReply();

	function showReply(){
		 $.getJSON({
			url : '/replies/getReplies',
			data : {notice_no:noticeNo,
					board_no:boardNo},
			success:function(data){
				var str = "";
				console.log(data);
				$(data).each(function(i,obj){
					str += "<li class='list-group-item' data-reno='" + encodeURIComponent(obj.reNo) + "'>";
					str += "<input type='hidden' name='reNo' data-reno='" + encodeURIComponent(obj.reNo) + "' value='" + obj.reNo + "' />";
					str += "<input type='hidden' name='board_no' data-boardno='" + encodeURIComponent(obj.board_no) + "' value='" + obj.board_no + "' />";
					str += "<input type='hidden' name='notice_no' data-noticeno='" + encodeURIComponent(obj.notice_no) + "' value='" + obj.notice_no + "' />";
					str += "<input type='hidden' name='writer' value='" + obj.writer + "' />";
					str += "<input type='hidden' name='memNo' value='" + obj.memNo + "' />";
					str += "<input type='hidden' name='reply' value='" + obj.reply + "' />";
					str += "<small class='re_writer'> " + obj.writer + " </small>";
					str += "<small class='time'> " + obj.replyDate + " </small>";
					str += "<small> 좋아요/싫어요 </small>";
					str += "<button type='button'> X </button>";
					str += "<br><p class='replyContent'>" + obj.reply + "</p></li>";					
				});	
			//	console.log(str);
				re_box.html(str);
			}
		});//getJSON
	 }//showReply
	
	//댓글 입력
	$(".btn-reply").on("click",function(){
		$.ajax({
			type:"post",
			url : '/replies/insertReply',
			data : {notice_no : noticeNo,
					reply : $("#reply").val(),
					board_no : boardNo,
					writer : "로그인한 사용자",
					memNo : "1"},
			success:function(data){
				console.log(data);
				 $("#reply").val("");
			}
		})
		
	});
	 
	 //댓글삭제
	$(".replyBox").on("click","li",function(){
		var reNo  =$(this).data("reno");
		 $.ajax({
			type:"post",
			url : '/replies/deleteReply',
			data : {notice_no : noticeNo,
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