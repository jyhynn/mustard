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
		<div class="row align-items-center my-5">
			<div class="col-lg-7 map_wrap">
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
				<div id="notice-box">
					<h5 class="font-weight-light">
						사이트 공지사항 <a class="btn" href="/board/noticeList">+</a>
					</h5>
					<c:forEach var="n" items="${noticeMain }">
					<a href="board/boardRead?article_no=${n.notice_no }&board_no=${n.board_no}" class="list-group-item list-group-item-action">
						<div class="d-flex w-100 justify-content-between">
							<input class="article_no" type="hidden" name="notice_no" value="${n.notice_no }"/>
							<h4 class="mb-1">${n.title }</h4>
						</div>
					</a>
				</c:forEach>
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
        <li class="nav-item">
          <a class="nav-link" href=
         	<c:if test="${empty log}">
				"board/boardList?board_no=2&shi=${guest.shi}&gungu=${guest.gungu }&dong=${guest.dong }"
			</c:if>
			<c:if test="${!empty log}">
				"board/boardList?board_no=2&shi=${log.zip.shi }&gungu=${log.zip.gungu }&dong=${log.zip.dong }"
			</c:if> >정보게시판</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href=
          	<c:if test="${empty log}">
				"/board/boardList?board_no=3&shi=${guest.shi}&gungu=${guest.gungu }&dong=${guest.dong }"
			</c:if>
			<c:if test="${!empty log}">
				"/board/boardList?board_no=3&shi=${log.zip.shi}&gungu=${log.zip.gungu }&dong=${log.zip.dong }"
			</c:if>>지역게시판</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href=
          	<c:if test="${empty log}">
				"/board/boardList?board_no=4&shi=${guest.shi}&gungu=${guest.gungu }&dong=${guest.dong }"
			</c:if>
			<c:if test="${!empty log}">
				"/board/boardList?board_no=4&shi=${log.zip.shi}&gungu=${log.zip.gungu }&dong=${log.zip.dong }"
			</c:if>>홍보게시판</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href=
			<c:if test="${empty log}">
				"/board/boardList?board_no=5&shi=${guest.shi}&gungu=${guest.gungu }&dong=${guest.dong }"
			</c:if>
			<c:if test="${!empty log}">
				"/board/boardList?board_no=5&shi=${log.zip.shi}&gungu=${log.zip.gungu }&dong=${log.zip.dong }"
			</c:if> >자유게시판</a>
        </li>
        <li class="nav-item active">
          <a class="nav-link" href="/board/boardList?board_no=1">공지사항</a>
        </li>
      </ul>
    </div>
  </nav>
	<div class="row">
		<div class="col-md-3 mb-5">
			<div class="card h-100">
				<div class="card-body">
					<h2 class="card-title">
						<a href=
							<c:if test="${empty log}">
								"board/boardList?&board_no=2&shi=${guest.shi}&gungu=${guest.gungu }&dong=${guest.dong }"
							</c:if>
							<c:if test="${!empty log}">
								"board/boardList?&board_no=2&zip=${log.zip.shi}&gungu=${log.zip.gungu }&dong=${log.zip.dong }"
							</c:if>	>정보 게시판</a>
					</h2>
					<p class="card-text">시/도청 발행 소식</p>
				</div>
			</div>
		</div>
		<!-- /.col-md-4 -->
		<div class="col-md-3 mb-5">
			<div class="card h-100">
				<div class="card-body">
					<h2 class="card-title">
						<a href=
							<c:if test="${empty log}">
								"/board/boardList?board_no=3&shi=${guest.shi}&gungu=${guest.gungu }&dong=${guest.dong }"
							</c:if>
							<c:if test="${!empty log}">
								"/board/boardList?board_no=3&shi=${log.zip.shi}&gungu=${log.zip.gungu }&dong=${log.zip.dong }"
							</c:if>	>지역 게시판</a>
					</h2>
					<p class="card-text">우리 동네 소식(가게 개폐업/행사 등)</p>
					<c:forEach var="b" items="${board3 }">
					<a href="board/boardRead?article_no=${b.article_no }&board_no=${b.board_no}" class="list-group-item list-group-item-action">
						<div class="d-flex w-100 justify-content-between">
							<input class="article_no" type="hidden" name="article_no" value="${b.article_no }"/>
							<h4 class="mb-1">${b.title }</h4>
						</div>
					</a>
				</c:forEach>
			</div>
		</div>
		<!-- /.col-md-4 -->
		<div class="col-md-3 mb-5">
			<div class="card h-100">
				<div class="card-body">
					<h2 class="card-title">
						<a href=
							<c:if test="${empty log}">
								"/board/boardList?board_no=4&shi=${guest.shi}&gungu=${guest.gungu }&dong=${guest.dong }"
							</c:if>
							<c:if test="${!empty log}">
								"/board/boardList?board_no=4&shi=${log.zip.shi}&gungu=${log.zip.shi }&dong=${log.zip.dong }"
							</c:if>	>홍보 게시판</a>
					</h2>
					<p class="card-text">사장님들의 홍보공간(행사/알바구함 등)</p>
					<c:forEach var="b" items="${board4 }">
					<h6 class="mb-1">
						<a href="board/boardRead?article_no=${b.article_no }&board_no=${b.board_no}">${b.title }</a>
					</h6>
					
				</c:forEach>
			</div>
		</div>
		<div class="col-md-3 mb-5">
			<div class="card h-100">
				<div class="card-body">
					<h2 class="card-title">
						<a href=
							<c:if test="${empty log}">
								"/board/boardList?board_no=5&shi=${guest.shi}&gungu=${guest.gungu }&dong=${guest.dong }"
							</c:if>
							<c:if test="${!empty log}">
								"/board/boardList?board_no=5&shi=${log.zip.shi}&gungu=${log.zip.shi }&dong=${log.zip.dong }"
							</c:if>	>자유 게시판</a>
					</h2>
					<p class="card-text">우리동네 자유게시판</p>
				</div>
				<c:forEach var="b" items="${board5 }">
					<a href="board/boardRead?article_no=${b.article_no }&board_no=${b.board_no}" class="list-group-item list-group-item-action">
						<div class="d-flex w-100 justify-content-between">
							<input class="article_no" type="hidden" name="article_no" value="${b.article_no }"/>
							<h4 class="mb-1">${b.title }</h4>
						</div>
					</a>
				</c:forEach>
			</div>
		</div>
		<!-- /.col-md-4 -->

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
			$.getJSON({
				url:'main_notice',
				success:function(data){
					var str = "";
					$(data).each(i,obj){
						str+="<li><a href=''>" + encodeURIComponent(obj.title) + "</a></li>";			
					};			
						$("#notice-box").append(obj);
				}
			});
		});
	</script>

	<%@ include file="include/footer.jsp"%>