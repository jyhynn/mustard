<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
						<h5>공지사항</h5>
					</div>
					<form action="noticeModify" id="readNotice">
						<div class="list-group-item">
							<h6 class="display-7 mb-3">${notice.title }</h6>
						  	<p><fmt:formatDate pattern="yy/MM/dd hh:mm" value="${notice.notice_date}"/> ${notice.writer } <!-- 조회수 댓글수 스크랩수 신고여부 --></p>
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
				<c:if test="${log.memlevel==10 }">
					<button type="button" class="btn btn-warning btn-modify">수정</button>
					<button type="button" class="btn btn-warning btn-delete">삭제</button>
				</c:if>
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
		var result = confirm('삭제하시겠습니까?'); 
		if(result) {
			$("#readNotice").attr("method","post")
			$("#readNotice").attr("action","remove").submit();
		} else {
			return;
		}
	});

});
</script>
<%@ include file="../include/footer.jsp"%>