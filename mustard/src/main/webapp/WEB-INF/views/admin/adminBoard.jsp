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
    <c:if test="${board_no == 3 }">
      <h2>지역 게시판</h2>
    </c:if>
    <c:if test="${board_no == 4 }">
      <h2>홍보 게시판</h2>
    </c:if>
    <c:if test="${board_no == 5 }">
      <h2>자유 게시판</h2>
    </c:if>
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
          <c:forEach var="b" items="${board }">
          	<tr>
              <td>${b.article_no }</td>
              <td><a href="/board/boardRead?board_no=${b.board_no }&article_no=${b.article_no}">${b.title }</a></td>
              <td>(${b.memNo })${b.writer }</td>
              <td>${b.notice_date }</td>
            </tr>
          </c:forEach>
          </tbody>
        </table>
        <!-- 페이징 -->
		<nav aria-label="Page navigation example m-3">
					<ul class="pagination justify-content-center">
					${pageMenu }
			</ul>
		</nav>
		
		<!-- /페이징 -->
  		</div>
  		
    </main>
  </div>
</div>
<%@ include file="../include/footer.jsp"%>