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
      <h2>ALL MEMBERS</h2>
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
          <c:forEach var="m" items="${members }">
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
  		<!-- 페이징 -->
		<nav aria-label="Page navigation example m-3">
			<ul class="pagination justify-content-center">${pageMenu }</ul>
		</nav>
		<!-- /페이징 -->
    </main>
  </div>
</div>
<%@ include file="../include/footer.jsp"%>