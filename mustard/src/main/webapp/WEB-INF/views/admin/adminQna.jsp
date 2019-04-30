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
    	<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
          <h2>문의 목록</h2>
        <div class="btn-toolbar mb-2 mb-md-0">
          <div class="btn-group mr-2">
            <button type="button" class="btn btn-sm btn-outline-secondary" onclick="/admin/adminQna">전체보기</button>
            <button type="button" class="btn btn-sm btn-outline-secondary" onclick="/admin/adminWatingAnswer">답변대기중</button>
          </div>
        </div>
       </div>
      <div class="table-responsive">
        <table class="table table-striped table-sm">
          <thead>
            <tr>
              <th>#</th>
              <th>title</th>
              <th>writer</th>
              <th>status</th>
              <th>date</th>
            </tr>
          </thead>
          <tbody>
          <c:forEach var="q" items="${qnas }">
          	<tr>
              <td>${q.qna_no }</td>
              <td><a href="/board/askRead?qna_no=${q.qna_no}">${q.title }</a></td>
              <td>(${q.memNo })${q.writer }</td>
              <td>
              	<c:if test="${q.classify==0 }">
              		답변대기중
              	</c:if>
              	<c:if test="${q.classify!=0 }">
              		답변완료
              	</c:if>
              </td>
              <td>${q.qna_date }</td>
            </tr>
          </c:forEach>
          </tbody>
        </table>
  		</div> 
   <!-- 페이징 -->
	<nav aria-label="Page navigation example">
		<ul class="pagination justify-content-center">
			<c:if test="${pageMaker.prev }">
				<li class="page-item disabled"><a class="page-link" href="${pageMaker.startPage-1 }" tabindex="-1" aria-disabled="true">&laquo;</a></li>
			</c:if>
			<c:forEach var="idx" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
				<li class="page-item ${pageMaker.cri.pageNum==idx?'active':'' }">
					<a class="page-link" href="${idx }">${idx }</a>
				</li>
			</c:forEach>
			<c:if test="${pageMaker.next }">
				<li class="page-item"><a class="page-link" href="${pageMaker.endPage+1 }">&raquo;</a>
			</c:if>
			</li>
		</ul>
	</nav>
	<!-- /페이징 -->
    </main>
  </div>
</div>
<%@ include file="../include/footer.jsp"%>