<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- <c:if test="${log.memlevel!=10 || empty log}">
	<script>
		alert("잘못된 접근");
		location.href="/";
	</script>
</c:if> --%>
<!DOCTYPE html>
<html>
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<title>Mustard</title>
</head>
<body>
<div class="container mt-5">
  <div class="row">
    <nav class="col-md-2 d-none d-md-block bg-light sidebar">
		<%@ include file="../include/adminSidebar.jsp" %>
    </nav>
    <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
      <h2>지역 게시판</h2>
      <div class="table-responsive">
        <table class="table table-striped table-sm">
          <thead>
            <tr>
              <th>#</th>
              <th>title</th>
              <th>writer</th>
              <th>date</th>
            </tr>
          </thead>
          <tbody>
          <c:forEach var="b" items="${board3 }">
          	<tr>
              <td>${b.article_no }</td>
              <td><a href="/board/boardRead?board_no=${b.board_no }&article_no=${b.article_no}">${b.title }</a></td>
              <td>(${b.memNo })${b.writer }</td>
              <td>${b.notice_date }</td>
            </tr>
          </c:forEach>
          </tbody>
        </table>
  		</div> 
   <!-- 페이징 -->
	<nav aria-label="Page navigation example mt-3">
		<ul class="pagination justify-content-center">
			<c:if test="${!empty pageMaker3.prev }">
				<li class="page-item disabled"><a class="page-link" href="${pageMaker3.startPage-1 }" tabindex="-1" aria-disabled="true">&laquo;</a></li>
			</c:if>
			<c:forEach var="idx" begin="${pageMaker3.startPage }" end="${pageMaker3.endPage }">
				<li class="page-item ${pageMaker3.cri.pageNum==idx?'active':'' }">
					<a class="page-link" href="${idx }">${idx }</a>
				</li>
			</c:forEach>
			<c:if test="${!empty pageMaker3.next }">
				<li class="page-item"><a class="page-link" href="${pageMaker3.endPage+1 }">&raquo;</a>
			</c:if>
			</li>
		</ul>
	</nav>
	<!-- /페이징 -->

      <h2>홍보 게시판</h2>
      <div class="table-responsive">
        <table class="table table-striped table-sm">
          <thead>
            <tr>
              <th>#</th>
              <th>title</th>
              <th>writer</th>
              <th>date</th>
            </tr>
          </thead>
          <tbody>
          <c:forEach var="b" items="${board4 }">
          	<tr>
              <td>${b.article_no }</td>
              <td><a href="/board/boardRead?board_no=${b.board_no }&article_no=${b.article_no}">${b.title }</a></td>
              <td>(${b.memNo })${b.writer }</td>
              <td>${b.notice_date }</td>
            </tr>
          </c:forEach>
          </tbody>
        </table>
      </div>
      <nav aria-label="Page navigation example mt-3">
		<ul class="pagination justify-content-center">
			<c:if test="${!empty pageMaker4.prev }">
				<li class="page-item disabled"><a class="page-link" href="${pageMaker4.startPage-1 }" tabindex="-1" aria-disabled="true">&laquo;</a></li>
			</c:if>
			<c:forEach var="idx" begin="${pageMaker4.startPage }" end="${pageMaker4.endPage }">
				<li class="page-item ${pageMaker4.cri.pageNum==idx?'active':'' }">
					<a class="page-link" href="${idx }">${idx }</a>
				</li>
			</c:forEach>
			<c:if test="${!empty pageMaker4.next }">
				<li class="page-item"><a class="page-link" href="${pageMaker4.endPage+1 }">&raquo;</a>
			</c:if>
			</li>
		</ul>
	</nav>
    <h2>자유 게시판</h2>
      <div class="table-responsive">
        <table class="table table-striped table-sm">
          <thead>
            <tr>
              <th>#</th>
              <th>title</th>
              <th>writer</th>
              <th>date</th>
            </tr>
          </thead>
          <tbody>
          <c:forEach var="b" items="${board5 }">
          	<tr>
              <td>${b.article_no }</td>
              <td><a href="/board/boardRead?board_no=${b.board_no }&article_no=${b.article_no}">${b.title }</a></td>
              <td>(${b.memNo })${b.writer }</td>
              <td>${b.notice_date }</td>
            </tr>
          </c:forEach>
          </tbody>
        </table>
      </div>
      <nav aria-label="Page navigation example">
		<ul class="pagination justify-content-center">
			<c:if test="${pageMaker5.prev }">
				<li class="page-item disabled"><a class="page-link" href="${pageMaker5.startPage-1 }" tabindex="-1" aria-disabled="true">&laquo;</a></li>
			</c:if>
			<c:forEach var="idx" begin="${pageMaker5.startPage }" end="${pageMaker5.endPage }">
				<li class="page-item ${pageMaker5.cri.pageNum==idx?'active':'' }">
					<a class="page-link" href="${idx }">${idx }</a>
				</li>
			</c:forEach>
			<c:if test="${pageMaker5.next }">
				<li class="page-item"><a class="page-link" href="${pageMaker5.endPage+1 }">&raquo;</a>
			</c:if>
			</li>
		</ul>
	</nav>
    </main>
  </div>
</div>
<%@ include file="../include/footer.jsp"%>