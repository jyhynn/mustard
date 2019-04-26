<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="include/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Mustard</title>
<link rel="stylesheet" type="text/css" href="/resources/css/boardmain.css" />
<link rel="stylesheet" type="text/css" href="/resources/css/small-business.css" />
<!-- Bootstrap core JavaScript -->
<script src="/resources/vendor/jquery/jquery.min.js"></script>
<script src="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d00c419e88d4d82746a22e3671354977&libraries=services"></script>

</head>
<body>
	<!-- Page Content -->
	<div class="container">

		<!-- Heading Row -->
		<div class="row align-items-center my-5">
			<div class="col-lg-7 map_wrap">
				<div id="map"></div>
				<div class="hAddr">
					<span class="map-title">우리 동네</span> <span id="centerAddr"></span>
					<div class="bAddr">
						<span class="title">${zip.shi } ${zip.gungu } ${zip.dong }</span>
					</div>
				</div>
			</div>
			<!-- 슬라이드 이미지 -->
			<div class="col-md-5">
				<div id="carouselExampleCaptions" class="carousel slide w-100 mb-3" data-ride="carousel">
					<ol class="carousel-indicators">
						<li data-target="#carouselExampleCaptions" data-slide-to="0" class="active"></li>
						<li data-target="#carouselExampleCaptions" data-slide-to="1"></li>
						<li data-target="#carouselExampleCaptions" data-slide-to="2"></li>
					</ol>
					<div class="carousel-inner">
						<div class="carousel-item active">
							<img src="http://placehold.it/900x400" class="d-block w-100" alt="...">
							<div class="carousel-caption d-none d-md-block">
								<h5>First slide label</h5>
								<p>Nulla vitae elit libero, a pharetra augue mollis
									interdum.</p>
							</div>
						</div>
						<div class="carousel-item">
							<img src="http://placehold.it/900x400" class="d-block w-100" alt="...">
							<div class="carousel-caption d-none d-md-block">
								<h5>Second slide label</h5>
								<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
							</div>
						</div>
						<div class="carousel-item">
							<img src="http://placehold.it/900x400" class="d-block w-100" alt="...">
							<div class="carousel-caption d-none d-md-block">
								<h5>Third slide label</h5>
								<p>Praesent commodo cursus magna, vel scelerisque nisl
									consectetur.</p>
							</div>
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
				<div id="notice-box">
				<h5 class="font-weight-light">사이트 공지사항 
					<a class="btn btn-primary" href="/board/noticeList">+</a></h5>
					<ul></ul>
				</div>
			</div>
		</div>
		<!-- /.col-md-4 -->
	</div>
	<!-- /.row -->

	<!-- Call to Action Well -->
	<nav class="navbar navbar-expand-lg navbar-light bg-mustard rounded">
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExample10" aria-controls="navbarsExample10" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse bg-mustard justify-content-md-center" id="navbarsExample10">
      <ul class="navbar-nav">
        <li class="nav-item active">
          <a class="nav-link" href="#">정보게시판<span class="sr-only">(current)</span></a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">지역게시판</a>
        </li>
        <li class="nav-item active">
          <a class="nav-link" href="#">홍보게시판</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">자유게시판</a>
        </li>
        <li class="nav-item active">
          <a class="nav-link" href="#">공지사항</a>
        </li>
      </ul>
    </div>
  </nav>
	<!-- <div class="navbar-collapse collapse text-white bg-secondary py-4 text-center w-75">
		<div class="card-body">
		<ul class="navbar-nav ml-auto">
			<li class="nav-item"><a class="nav-link" href="#">정보게시판</a></li>
			<li class="nav-item"><a class="nav-link" href="#">지역게시판</a></li>
			<li class="nav-item"><a class="nav-link" href="#">홍보게시판</a></li>
			<li class="nav-item"><a class="nav-link" href="#">자유게시판</a></li>
			<li class="nav-item"><a class="nav-link" href="/board/noticeList">공지사항</a></li>
		</ul>
		</div>
	</div> -->

	<!-- Content Row -->
	<div class="row">
		<div class="col-md-4 mb-5">
			<div class="card h-100">
				<div class="card-body">
					<h2 class="card-title">
						<a href="#">정보 게시판</a>
					</h2>
					<p class="card-text">시청/군구청/읍면동사무소에서 발행한 공지사항</p>
				</div>
				<div class="card-footer">
					<a href="#" class="btn btn-primary btn-sm">More Info</a>
				</div>
			</div>
		</div>
		<!-- /.col-md-4 -->
		<div class="col-md-4 mb-5">
			<div class="card h-100">
				<div class="card-body">
					<h2 class="card-title">
						<a href="#">지역 게시판</a>
					</h2>
					<p class="card-text">우리 동네 소식(가게 개폐업/행사 등)</p>
				</div>
				<div class="card-footer">
					<a href="#" class="btn btn-primary btn-sm">More Info</a>
				</div>
			</div>
		</div>
		<!-- /.col-md-4 -->
		<div class="col-md-4 mb-5">
			<div class="card h-100">
				<div class="card-body">
					<h2 class="card-title">
						<a href="#">홍보 게시판</a>
					</h2>
					<p class="card-text">사장님들의 홍보공간(행사/알바구함 등)</p>
				</div>
				<div class="card-footer">
					<a href="#" class="btn btn-primary btn-sm">More Info</a>
				</div>
			</div>
		</div>
		<div class="col-md-4 mb-5">
			<div class="card h-100">
				<div class="card-body">
					<h2 class="card-title">
						<a href="#">자유 게시판</a>
					</h2>
					<p class="card-text">우리동네 자유게시판(전국/동네 선택가능)</p>
				</div>
				<div class="card-footer">
					<a href="#" class="btn btn-primary btn-sm">More Info</a>
				</div>
			</div>
		</div>
		<!-- /.col-md-4 -->

	</div>
	<!-- /.row -->

	</div>
	<!-- /.container -->

	<!-- Footer -->
	<footer class="py-5 bg-dark">
		<div class="container">
			<p class="m-0 text-center text-white">Copyright &copy; Your
				Website 2019</p>
		</div>
		<!-- /.container -->
	</footer>
	<!-- 로딩문제로 맨 아래 위치 -->
	<script>
		var selectedAddr = "${zip.shi}" + " ${zip.gungu}" + " ${zip.dong}";
		var container = document.getElementById('map');
		var options = {
			center : new daum.maps.LatLng(33.450701, 126.570667),
			level : 3
		};

		var map = new daum.maps.Map(container, options);
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new daum.maps.services.Geocoder();

		// 주소로 좌표를 검색합니다
		geocoder.addressSearch('서울특별시 양천구 목2동', function(result, status) {

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
			$.getJSON({
				url:'main_notice',
				success:function(data){
					var str = "";
					$(data).each(i,obj){
						str+="<li><a href=''>" + encodeURIComponent(obj.title) + "</a></li>";			
					}			
						$("#notice-box").append(obj);
				}
			});
		});
	</script>

	<%@ include file="include/footer.jsp"%>