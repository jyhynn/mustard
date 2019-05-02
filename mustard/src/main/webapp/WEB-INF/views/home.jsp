<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/resources/fonts.css">
<link rel="stylesheet" type="text/css" href="/resources/css/commons.css">
<link rel="stylesheet" type="text/css" href="/resources/css/mainstyles.css">
<script src="/resources/vendor/jquery/jquery.js"></script>
<title>우리동네</title>
<!-- <script src="/resources/jquery-3.3.1.js"></script> -->
</head>
<body>
	<aside>
    <div class="login" style="text-align:center">
      <img src="/resources/icons/uri.png" alt="logo" width="80" height="80" style="margin-bottom:30px">
      <a href="/member/signin" class="button login">로그인</a>
      <a href="/member/register" class="button register">회원가입</a>
      <!-- <p id="facebookLogin" class="facebook">
        <span class="text">페이스북으로 시작하기</span>
        <img src="" class="loading">
      </p> -->
      <p class="find">
        <a href="#">비밀번호 찾기</a>
      </p>
      <hr>
    </div>
    <form class="search">
      <p>우리 동네 커뮤니티 둘러보기</p>
	<select name="shi" id="shi">
		<option value="">-----시-----</option>
	</select>
	<select name="gungu" id="gungu">
		<option value="">----군/구----</option>
	</select>
    </form> 
    <div class="donglist" id="donglist"></div>
     </aside>
  <section class="init withaside">
    <div class="wrap">
          
      <h1><strong>우리동네</strong>를 <br>구석구석</h1>
      <div class="stores">
        <a href="/page/mlink?lid=web_about&store=playstore"><img src="/resources/playstore.png" alt="Play Store - Google"></a>
        <a href="/page/mlink?lid=web_about&store=appstore"><img src="/resources/appstore.png" alt="AppStore - Apple"></a>
      </div>
      	<div class="logoicon">
	      	<img src="/resources/icons/uri.png" alt="logo" width="350" height="350">
      </div>
    </div>
  </section>
	<script>
  	$(function(){
  		//호출과 동시에 시 목록 가져오기
  		$.getJSON({
  			url : "/getShi",
  			success:function(data){
  				console.log(data)
  				 $.each(data, function(i, zip){
  					$("#shi").append("<option value='" + zip.shi + "'>" + zip.shi + "</option>");
  				});
  			}
  		});
  		//선택한 시에 따라 군구 목록 가져오기
  		$("#shi").on("change",function(){
  			$("#gungu option").remove();
  			$("#donglist").html("");
  			$("#gungu").append("<option value=''>---------군/구---------</option>")
  			$.getJSON({
  	  			url : "/getGungu",
  	  			data : {shi:$("#shi").val()},
  	  			success:function(data){
  	  				console.log(data)
  	  				 $.each(data, function(i, g){
  	  					$("#gungu").append("<option value='" + g.gungu + "'>" + g.gungu + "</option>");
  	  				});
  	  			}
  	  		});
  		});
  		//선택값에 따른 읍동면 목록 가져오기
  		$("#gungu").on("change",function(){
  			$("#donglist").html("");
  			$.getJSON({
  	  			url : "/getDong",
  	  			data : {shi:$("#shi").val(), gungu:$("#gungu").val()},
  	  			success:function(data){
  	  				console.log(data)
  	  				 $.each(data, function(i, d){
  	  					$("#donglist").append("<a href='/?shi=" + $("#shi").val() + "&gungu=" + $("#gungu").val() + "&dong=" + d.dong + "'><span class='name'>" + d.dong + "</span></a>");
  	  				});
  	  			}
  	  		});
  			
  		});
  		
  		
  	});
  </script>
<%@ include file="include/footer.jsp"%>