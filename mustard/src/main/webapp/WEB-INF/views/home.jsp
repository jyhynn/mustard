<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/resources/fonts.css">
<link rel="stylesheet" type="text/css" href="/resources/css/mainstyles.css">
<script src="/resources/vendor/jquery/jquery.js"></script>
<title>Insert title here</title>
<!-- <script src="/resources/jquery-3.3.1.js"></script> -->
</head>
<body>
	<aside>
    <div class="login">
      <a href="/" class="logo"><img src="" alt="사이트로고"></a>
      <a href="member/signin" class="button login">로그인</a>
      <a href="member/register" class="button register">[사이트이름] 회원가입</a>
      <p id="facebookLogin" class="facebook">
        <span class="text">페이스북으로 시작하기</span>
        <img src="" class="loading">
      </p>
      <p class="find">
        <a href="/forgot">아이디/비밀번호 찾기</a>
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
      <h1>~~~~~~~어쩌고<br><strong>[사이트이름]</strong></h1>
      <div class="stores">
        <a href="/page/mlink?lid=web_about&store=playstore"><img src="/resources/playstore.png" alt="Play Store - Google"></a>
        <a href="/page/mlink?lid=web_about&store=appstore"><img src="/resources/appstore.png" alt="AppStore - Apple"></a>
      </div>
      <hr>
      <div class="device">
        <div class="screen">
          <div class="image frame home-frame"></div>
          <div class="image content home-content"></div>
          <div class="image frame board-frame"></div>
          <div class="image content board-content"></div>
          <div class="image frame timetable-status"></div>
          <div class="image frame timetable-frame"></div>
          <div class="image content timetable-content"></div>
        </div>
      </div>
    </div>
  </section>
    <section class="footer white withaside">
    <ul class="links">
      <li class="copyright"><a href="/about">&copy; [사이트이름]</a></li>
      <li><a href="/page/faq">문의하기</a></li>
      <li><a href="/page/rules">커뮤니티이용규칙</a></li>
      <li><a href="/page/privacy">개인정보처리방침</a></li>
    </ul>
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
</body>
</html>