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
    <h2>신고된 글 목록</h2>
      <div class="table-responsive mb-5">
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
          <c:forEach var="b" items="${br }">
          	<tr>
              <td>${b.article_no }</td>
              <td><a href="/board/boardRead?board_no=${b.board_no }&article_no=${b.article_no}">${b.title }</a></td>
              <td>(${b.memNo })${b.writer }</td>
              <td>${b.notice_date }</td>
            </tr>
          </c:forEach>
          <c:if test="${empty br }">
          	<td colspan="4">신고된 글이 없습니다.</td>
          </c:if>
          </tbody>
        </table>
  		</div> 
   
      <h2>신고회원 목록</h2>
      <div class="table-responsive">
        <table class="table table-striped table-sm">
          <thead>
            <tr>
              <th>#</th>
              <th>NAME</th>
              <th>EMAIL</th>
              <th>ZIPCODE</th>
              <th>NICKNAME</th>
              <th>REGDATE</th>
              <th>AUTH STATUS</th>
              <th>LEVEL</th>
              <th>REPORTED</th>
            </tr>
          </thead>
          <tbody>
          <c:forEach var="m" items="${mr }">
          	<tr>
              <td>${m.memNo }</td>
              <td>${m.name }</td>
              <td>${m.email }</td>
              <td>${m.code }</td>
              <td>${m.nick }</td>
              <td>${m.regdate}</td>
              <td>${m.authstatus}</td>
              <td>${m.memlevel}</td>
              <td>${m.memreport}</td>
            </tr>
          </c:forEach>
          </tbody>
        </table>
  		</div> 
    </main>
  </div>
</div>
<%@ include file="../include/footer.jsp"%>