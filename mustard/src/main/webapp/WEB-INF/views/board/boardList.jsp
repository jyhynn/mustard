<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- <link rel="stylesheet" type="text/css" href="/resources/vendor/bootstrap/css/bootstrap.css" /> -->
</head>
<body>
	<div class="container mt-5">
		<div class="row">
			<div class="col-md-9 order-md-1 font-jeju">
				<div class="list-group-item mb-3">
					<c:if test="${bno==2 }">
						<h5>정보게시판</h5>
					</c:if>
					<c:if test="${bno==3 }">
						<h5>지역게시판</h5>
					</c:if>
					<c:if test="${bno==4 }">
						<h5>홍보게시판</h5>
					</c:if>
					<c:if test="${bno==5 }">
						<h5>자유게시판</h5>
					</c:if>
				</div>
				<c:if test="${bno==2 }">
					<div class="list-group-item mb-3">
						<small>클릭하시면 해당 링크로 이동합니다.</small>
					</div>
					<div class="list-group">
						<c:forEach var="l" items="${link }">
							<a href="${l.href }"
								class="list-group-item list-group-item-action"> 
								<h6 class="mb-1">${l.title }</h6>
							</a>
						</c:forEach>
					</div>
				</c:if>
				<c:if test="${bno!=2}">	
					<c:forEach var="b" items="${board }">
						<a href="boardRead?article_no=${b.article_no }&board_no=${b.board_no}" class="list-group-item list-group-item-action">
							<div class="d-flex w-100 justify-content-between">
								<input class="article_no" type="hidden" name="article_no" value="${n.article_no }"/>
								<h4 class="mb-1">${b.title }</h4>
								<%-- <c:if test="${!empty b.attach }">
									<div class="media"></div>
								</c:if> --%>
							</div>
							<p class="mb-1">${b.content }</p> 
							<small><fmt:formatDate pattern="yy/MM/dd hh:mm" value="${b.notice_date }"/> <span>${b.writer }</span></small>
							<span class="badge badge-light">조회수 ${b.readhit }</span>
							<span class="badge badge-light">댓글 ${b.replycnt }</span>
							<span class="badge badge-light">♥ ${b.likey }</span>
						</a>
					</c:forEach>
				</c:if>
				<!-- 페이징 -->
				<nav aria-label="Page navigation example mt-3">
					<ul class="pagination justify-content-center">
						<c:if test="${!empty pageMaker.prev }">
							<li class="page-item disabled"><a class="page-link" href="${pageMaker.startPage-1 }" tabindex="-1" aria-disabled="true">&laquo;</a></li>
						</c:if>
						<c:forEach var="idx" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
							<li class="page-item ${pageMaker.cri.pageNum==idx?'active':'' }">
								<a class="page-link" href="${idx }">${idx }</a>
							</li>
						</c:forEach>
						<c:if test="${!empty pageMaker.next }">
							<li class="page-item"><a class="page-link" href="${pageMaker.endPage+1 }">&raquo;</a>
						</c:if>
						</li>
					</ul>
				</nav>
				<!-- /페이징 -->
				<c:if test="${bno!=2}">	
					<button type="button" class="mt-4 mb-5 btn btn-warning btn-write btn-sm"><small>글쓰기</small></button>
				</c:if>
			</div>
			<div class="col-md-3 order-md-2 mb-4 font-jeju">
				<%@ include file="../include/trends.jsp"%>
			</div>
		</div>
	</div>
	<script>
		$(function() {
			var articleNo = $(".article_no").val();
			var thum_image = $(".media");

			$(".btn-write").on("click", function() {
				location.href = 'boardWrite?board_no=' + ${bno};
			});

			//이미지 첨부 글일경우 리스트에 이미지 같이 표시
			/* $.getJSON({
				url : 'getAttachs',
				success : function(data) {
					$(data).each(function(i, obj) {
						var attach_notice_no = encodeURIComponent(obj.notice_no);
						var filePath = encodeURIComponent(obj.uploadPath);
						$.getJSON({
							url : 'getAttachList',
							data : {notice_no : attach_notice_no,
									board_no : 1},
							success : function(data) {
								console.log(data);
								var str = "";
								$(data).each(function(i,obj) {
									if(i==0){
										str = "<img src='/display?fileName="+ filePath+ "' class='ml-3'>";
									}
								});
								thum_image.html(str);
							}
						});//getAttachList
					});
				}
			});//getAttachs */
		});
	</script>
	<%@ include file="../include/footer.jsp"%>