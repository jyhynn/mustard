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
					<c:if test="${bno==2 }">
						<h3>정보게시판</h3>
					</c:if>
					<c:if test="${bno==3 }">
						<h3>지역게시판</h3>
					</c:if>
					<c:if test="${bno==4 }">
						<h3>홍보게시판</h3>
					</c:if>
					<c:if test="${bno==5 }">
						<h3>자유게시판</h3>
					</c:if>
					</div>
					<form action="boardModify" id="readBoard">
						<div class="list-group-item">
							<h4 class="display-7 mb-3">${board.title }</h4>
						  	<p>${board.notice_date} ${board.writer }
						  		<span class="badge badge-light">조회수 ${board.readhit }</span>
								<span class="badge badge-light badge-recnt">댓글 ${board.replycnt }</span>
								<span class="badge badge-light badge-likey">♥ ${board.likey }</span></p>
						  	<input type="hidden" name="article_no" value="${board.article_no }"/>
						  	<input type="hidden" name="memNo" id="memNo" value="${board.memNo }"/>
						  	<input type="hidden" name="board_no" value="${board.board_no }"/>
						  	<hr class="my-4">
						  	<div class="showImages">
						  		<div class="showFiles"><ul></ul></div>
						  	</div>
						  	<p class="lead">${board.content }</p>
						</div>
					</form>
				<div class="mt-4">
					<button type="button" class="btn btn-warning btn-modify">수정</button>
					<button type="button" class="btn btn-warning btn-delete">삭제</button>
					<button type="button" class="btn btn-outline-danger btn-likey">♥ 좋아요</button>
					<button type="button" class="btn btn-outline-danger btn-scrap">★ 스크랩</button>
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
	var articleNo = ${board.article_no };
	var boardNo = ${board.board_no };
	var re_box = $(".replyBox");
	
	$.getJSON({
		url : 'BoardgetAttachList',
		data : {article_no:articleNo,
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
		$("#readBoard").submit();
	});
	$(".btn-delete").on("click",function(){
		$("#readBoard").attr("method","post")
		$("#readBoard").attr("action","removeBoard").submit();
	});

	//신고
	$("#btn-report").on("click",function(){
		 $.ajax({
			type:"post",
			url : '/reportBoard',
			data : {article_no : articleNo,
					board_no : boardNo,
					memNo : $("#memNo").val()},
			success:function(data){
				console.log(data);
				if(data=='boardReportSuccess'){
					alert("신고가 성공적으로 접수되었습니다. 빠른 시일 내에 조치가 이루어집니다.");
				}
			}
		});	//ajax	
	});
	
	//좋아요
	$(".btn-likey").on("click",function(){
		 $.ajax({
			type:"post",
			url : '/likeyBoard',
			data : {article_no : articleNo,
					board_no : boardNo,
					memNo : 61},
			success:function(data){
				console.log(data);
				getLikeyamount();
			}
		});	//ajax	
	});
	
	//스크랩
	$(".btn-scrap").on("click",function(){
		 $.ajax({
			type:"post",
			url : '/scrapBoard',
			data : {article_no : articleNo,
					board_no : boardNo,
					memNo : 61},
			success:function(data){
				console.log(data);
				if(data=='boardScrapSuccess'){
					alert("스크랩된 글은 마이페이지 > 내 스크랩 에서 확인가능합니다.");
				}
			}
		});	//ajax	
	});
	
	function getLikeyamount(){
		$.getJSON({
			url : '/getLikeyamount',
			data : {article_no:articleNo,
					board_no:boardNo},
			success:function(data){
				$(".badge-likey").html("♥ " + data);
			}
		});
	}
	
	function getReplyamount(){
		$.getJSON({
			url : '/replies/getReplyamount',
			data : {article_no:articleNo,
					board_no:boardNo},
			success:function(data){
				$(".badge-recnt").html("댓글 " + data);
			}
		});
	}
	
	showReply();

	function showReply(){
		 $.getJSON({
			url : '/replies/getReplies',
			data : {article_no:articleNo,
					board_no:boardNo},
			success:function(data){
				var str = "";
				console.log(data);
				$(data).each(function(i,obj){
					str += "<li class='list-group-item' data-reno='" + obj.reNo + "'>";
					str += "<input type='hidden' name='reNo' data-reno='" + obj.reNo + "' value='" + obj.reNo + "' />";
					str += "<input type='hidden' name='board_no' data-boardno='" + obj.board_no + "' value='" + obj.board_no + "' />";
					str += "<input type='hidden' name='article_no' data-noticeno='" + obj.article_no + "' value='" + obj.article_no + "' />";
					str += "<input type='hidden' name='writer' value='" + obj.writer + "' />";
					str += "<input type='hidden' name='memNo' value='" + obj.memNo + "' />";
					str += "<input type='hidden' name='reply' value='" + obj.reply + "' />";
					str += "<small class='re_writer'> " + obj.writer + " </small>";
					str += "<small class='time'> " + obj.replyDate + " </small>";
					str += "<small><span class='btn badge badge-light re-likey' data-reno='" + obj.reNo +"'>♥ " + obj.likey + "</span>";
					str += "<span class='btn badge badge-danger re-report' data-reno='" + obj.reNo +"' data-memno='" + obj.memNo + "'>신고</span>";
					str += "<span class='btn badge badge-light re-del' data-reno='" + obj.reNo +"'> X 삭제 </span></small>";
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
			data : {article_no : articleNo,
					reply : $("#reply").val(),
					board_no : boardNo,
					writer : "관리자",
					memNo : "61"},
			success:function(data){
				console.log(data);
				 $("#reply").val("");
				 getReplyamount();
				 showReply();
			}
		})
		
	});
	 
	 //댓글삭제
	$(".replyBox").on("click",".re-del",function(){
		var reNo  =$(this).data("reno");
		 $.ajax({
			type:"post",
			url : '/replies/deleteReply',
			data : {article_no : articleNo,
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
		
	//댓글좋아요
	$(".replyBox").on("click",".re-likey",function(){
		var reNo  = $(this).data("reno");
		console.log($(this).text().substr(2));
		 $.ajax({
			type:"post",
			url : '/replies/likeyReply',
			data : {article_no : articleNo,
					reNo : reNo,
					board_no : boardNo},
			success:function(data){
				console.log(data);
				showReply();
			}
		});	//ajax	
	}); 
	
	//댓글신고
	$(".replyBox").on("click",".re-report",function(){
		var reNo  = $(this).data("reno");
		var memNo = $(this).data("memno");
		 $.ajax({
			type:"post",
			url : '/replies/reportReply',
			data : {article_no : articleNo,
					reNo : reNo,
					board_no : boardNo,
					memNo : memNo},	//글쓴이회원번호
			success:function(data){
				console.log(data);
				if(data=='reReportSuccess'){
					alert("댓글신고가 성공적으로 접수되었습니다. 빠른 시일 내에 조치가 이루어집니다.");
					showReply();
				}
			}
		});	//ajax	
	}); 
});
</script>
<%@ include file="../include/footer.jsp"%>