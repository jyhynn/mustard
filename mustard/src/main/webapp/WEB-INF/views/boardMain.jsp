<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="include/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Mustard</title>
<!-- Bootstrap core JavaScript -->
<script src="/resources/vendor/jquery/jquery.min.js"></script>
<script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d00c419e88d4d82746a22e3671354977&libraries=services"></script>

</head>
<body>
  <!-- Page Content -->
	<div class="container">
		<!-- Heading Row -->
		<div class="row my-5">
			<div class="col-lg-7 map_wrap">
				<!-- 지도 -->
				<div id="map"></div>
				<div class="hAddr">
					<span class="map-title">우리 동네</span> <span id="centerAddr"></span>
					<div class="bAddr">
						<c:if test="${empty log }">
							<span class="title selectedaddr">${guest.shi } ${guest.gungu } ${guest.dong }</span>
						</c:if>
						 <c:if test="${!empty log }">
								<c:if test="${!empty log.zip}">
									<span class="title selectedaddr">${log.zip.shi } ${log.zip.gungu } ${log.zip.dong }</span>
								</c:if>
								<c:if test="${empty log.zip}">
									<span class="title selectedaddr">서울특별시 중구</span>
								</c:if>
						</c:if> 
					</div>
				</div>
			</div>
			<div class="col-lg-5">
				<!-- 슬라이드 이미지 -->
				<div id="carouselExampleCaptions" class="carousel slide w-100 mb-3" data-ride="carousel">
					<ol class="carousel-indicators">
						<li data-target="#carouselExampleCaptions" data-slide-to="0" class="active"></li>
						<li data-target="#carouselExampleCaptions" data-slide-to="1"></li>
						<li data-target="#carouselExampleCaptions" data-slide-to="2"></li>
					</ol>
					<div class="carousel-inner">
						<div class="carousel-item active">
							<img src="http://placehold.it/900x400" class="d-block w-100" alt="...">
						</div>
						<div class="carousel-item">
							<img src="http://placehold.it/900x400" class="d-block w-100" alt="...">
						</div>
						<div class="carousel-item">
							<img src="http://placehold.it/900x400" class="d-block w-100" alt="...">
						</div>
					</div>
					<a class="carousel-control-prev" href="#carouselExampleCaptions"
						role="button" data-slide="prev"> <span
						class="carousel-control-prev-icon" aria-hidden="true"></span> <span
						class="sr-only">Previous</span>
					</a> <a class="carousel-control-next" href="#carouselExampleCaptions"
						role="button" data-slide="next"> <span
						class="carousel-control-next-icon" aria-hidden="true"></span> <span
						class="sr-only">Next</span>
					</a>
				</div>
				<!-- 공지사항 -->
				<div class="list-group">
				  <h7 class="font-weight-light mt-2 mr-1 mb-1">
				  <img src="/resources/icons/info.png" class="icons mr-1 mb-1" alt="...">공지사항 
				  <a href="/board/noticeList"><img src="/resources/icons/plus.png" class="icons mr-1 mb-1" alt="..."></a></h7>
				  <c:forEach var="n" items="${noticeMain }">
				  	<a href="/board/noticeRead?notice_no=${n.notice_no }&board_no=${n.board_no}" class="list-group-item list-group-item-action">- ${n.title }</a>
				  </c:forEach>
				</div>
			</div>
		</div>
	<!-- /.row -->

	<!-- 메뉴바 -->
	<div class="text-white bg-secondary py-4 text-center">
		<ul class="nav nav-pills nav-fill">
		  <li class="nav-item">
		    <a href= <c:if test="${empty log}">"/board/boardList?board_no=2&shi=${guest.shi}&gungu=${guest.gungu }&dong=${guest.dong }"</c:if>
					 <c:if test="${!empty log}">"/board/boardList?board_no=2&shi=${log.zip.shi }&gungu=${log.zip.gungu }&dong=${log.zip.dong }"</c:if>
				class="text-white" >정보게시판</a>
		  </li>
		  <li class="nav-item">
		    <a href=<c:if test="${empty log}">"/board/boardList?board_no=3&shi=${guest.shi}&gungu=${guest.gungu }&dong=${guest.dong }"</c:if>
					<c:if test="${!empty log}">"/board/boardList?board_no=3&shi=${log.zip.shi}&gungu=${log.zip.gungu }&dong=${log.zip.dong }"</c:if>
				class="text-white">지역게시판</a>
		  </li>
		  <li class="nav-item">
		    <a href=<c:if test="${empty log}">"/board/boardList?board_no=4&shi=${guest.shi}&gungu=${guest.gungu }&dong=${guest.dong }"</c:if>
					<c:if test="${!empty log}">"/board/boardList?board_no=4&shi=${log.zip.shi}&gungu=${log.zip.gungu }&dong=${log.zip.dong }"</c:if> 
				class="text-white">홍보게시판</a>
		  </li>
		  <li class="nav-item">
		    <a href=<c:if test="${empty log}">"/board/boardList?board_no=5&shi=${guest.shi}&gungu=${guest.gungu }&dong=${guest.dong }"</c:if>
					<c:if test="${!empty log}">"/board/boardList?board_no=5&shi=${log.zip.shi}&gungu=${log.zip.gungu }&dong=${log.zip.dong }"</c:if> 
				class="text-white">자유게시판</a>
		  </li>
		  <li class="nav-item">
		    <a class="text-white" href="/board/boardList?board_no=1">공지사항</a>
		  </li>
		</ul>			
	</div>

	<!-- Content Row -->
		<div class="row my-5">
			<!-- 정보게시판 -->
			<div class="col-md-3 mb-5">
				<div class="list-group">
				  <a href=<c:if test="${empty log}">"/board/boardList?&board_no=2&shi=${guest.shi}&gungu=${guest.gungu }&dong=${guest.dong }"</c:if>
						  <c:if test="${!empty log}">"/board/boardList?&board_no=2&zip=${log.zip.shi}&gungu=${log.zip.gungu }&dong=${log.zip.dong }"</c:if>
						  class="list-group-item list-group-item-action">
						  <img src="/resources/icons/web.png" class="icons mr-1 mb-1" alt="...">정보 게시판
						  <br><small>게시판으로 바로 이동합니다.</small></a>
				</div>
			</div>
			<!-- 지역게시판 -->
			<div class="col-md-3 mb-5">
				<div class="list-group">
				<a href=<c:if test="${empty log}">"/board/boardList?board_no=3&shi=${guest.shi}&gungu=${guest.gungu }&dong=${guest.dong }"</c:if>
						<c:if test="${!empty log}">"/board/boardList?board_no=3&shi=${log.zip.shi}&gungu=${log.zip.gungu }&dong=${log.zip.dong }"</c:if>
						class="list-group-item list-group-item-action">
					<img src="/resources/icons/store.png" class="icons mr-1 mb-1" alt="...">
						지역 게시판<br><small>우리 동네 소식(가게 개폐업/행사 등)</small></a>
				<c:forEach var="b" items="${board3 }">
					<a href="board/boardRead?article_no=${b.article_no }&board_no=${b.board_no}" class="list-group-item list-group-item-action">
						<small>${b.title }</small></a>
				</c:forEach>
				</div>
			</div>
			<!-- 홍보게시판 -->
			<div class="col-md-3 mb-5">
				<div class="list-group">
				<a href=<c:if test="${empty log}">"/board/boardList?board_no=4&shi=${guest.shi}&gungu=${guest.gungu }&dong=${guest.dong }"</c:if>
						<c:if test="${!empty log}">"/board/boardList?board_no=4&shi=${log.zip.shi}&gungu=${log.zip.gungu }&dong=${log.zip.dong }"</c:if>
						class="list-group-item list-group-item-action">
						<img src="/resources/icons/bullhorn.png" class="icons mr-1 mb-1" alt="...">홍보 게시판<br><small>사장님들의 홍보공간(행사/알바구함 등)</small></a>
				<c:forEach var="b" items="${board4 }">
					<a href="board/boardRead?article_no=${b.article_no }&board_no=${b.board_no}" class="list-group-item list-group-item-action">
						<small>${b.title }</small></a>
				</c:forEach>
				</div>
			</div>
			<!-- 자유게시판 -->
			<div class="col-md-3 mb-5">
				<div class="list-group">
				<a href=<c:if test="${empty log}">"/board/boardList?board_no=5&shi=${guest.shi}&gungu=${guest.gungu }&dong=${guest.dong }"</c:if>
						<c:if test="${!empty log}">"/board/boardList?board_no=5&shi=${log.zip.shi}&gungu=${log.zip.gungu }&dong=${log.zip.dong }"</c:if>
						class="list-group-item list-group-item-action">
					<img src="/resources/icons/standup.png" class="icons mr-1 mb-1" alt="...">자유 게시판</a>
				<c:forEach var="b" items="${board5 }">
					<a href="board/boardRead?article_no=${b.article_no }&board_no=${b.board_no}" class="list-group-item list-group-item-action">
						<small>${b.title }</small></a>
				</c:forEach>
				</div>
			</div>
		</div>
	<!-- /.row -->
	</div>
  <!-- /.container -->	
  
	<!-- 로딩문제로 맨 아래 위치 -->
	<script>
		var selectedAddr = $(".selectedaddr").text();
		var container = document.getElementById('map');
		var options = {
			center : new daum.maps.LatLng(33.450701, 126.570667),
			level : 3
		};

		var map = new daum.maps.Map(container, options);
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new daum.maps.services.Geocoder();

		// 주소로 좌표를 검색합니다
		geocoder.addressSearch(selectedAddr, function(result, status) {

			// 정상적으로 검색이 완료됐으면 
			if (status === daum.maps.services.Status.OK) {

				var coords = new daum.maps.LatLng(result[0].y, result[0].x);

				// 결과값으로 받은 위치를 마커로 표시합니다
				var marker = new daum.maps.Marker({
					map : map,
					position : coords
				});

				// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
				map.setCenter(coords);
			}
		});
	</script>
	<script>
		$(function(){
			//공지
			$.getJSON({
				url:'main_notice',
				success:function(data){
					var str = "";
					$(data).each(function(i,obj){
						str+="<li><a href=''>" + encodeURIComponent(obj.title) + "</a></li>";			
					});			
						$("#notice-box").append(obj);
				}
			});
		});
	</script>

	<%@ include file="include/footer.jsp"%>