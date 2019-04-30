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
       <h2>개별회원관리</h2>
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
              <th>CONTROL</th>
            </tr>
          </thead>
          <tbody>
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
              <td>
			  	<div class="dropdown">
			 		 <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			    		회원등급 조정
			  		</button>
					 <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
					   <a class="dropdown-item controlDOWN" href="#">등급 올리기</a>
					   <a class="dropdown-item controlUP" href="#">등급 내리기</a>
					   <a class="dropdown-item controlREMOVE" href="#">강제 탈퇴</a>
					 </div>
				</div>
              </td>
            </tr>
          </tbody>
        </table>
  		</div> 
    </main>
  </div>
</div>
<form action="control" method="post" id="memInfo">
	<input type="hidden" name="memNo" value="${m.memlevel }" />
	<input type="hidden" name="how" id="how"/>
</form>
<script>
	$(function(){
		$(".controlDOWN").on("click", function(){
			$("#how").val(0);
			$("#memInfo").submit();
		});
		$(".controlDOWN").on("click", function(){
			$("#how").val(1);
			$("#memInfo").submit();
		});
		$(".controlDOWN").on("click", function(){
			$("#how").val(2);
			$("#memInfo").submit();
		});
	})

</script>
<%@ include file="../include/footer.jsp"%>