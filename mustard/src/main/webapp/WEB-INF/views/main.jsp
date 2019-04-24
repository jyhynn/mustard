<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="include/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Hello, world!</title>
</head>
<body>
	<!-- Page Content -->
	<div class="container">

		<!-- Heading Row -->
		<div class="row align-items-center my-5">
			<div class="col-lg-7">
				<img class="img-fluid rounded mb-4 mb-lg-0"
					src="http://placehold.it/900x400" alt="지도">
			</div>

			<!-- /.col-lg-8 -->
			<div class="row my-5">
				<div class="col-md-5 mb-5">
					<div class="card h-100 event">
						<div class="card-body">
							<h2 class="card-title">이벤트 슬라이드창</h2>
						</div>
					</div>
				</div>
				<div class="col-lg-5">
					<h1 class="font-weight-light">Business Name or Tagline</h1>
					<p>이벤트 카드3개정도. 공지카드.</p>
					<a class="btn btn-primary" href="#">Call to Action!</a>
				</div>
			</div>
		</div>
		<!-- /.col-md-4 -->

		<!-- /.row -->

		<!-- Call to Action Well -->
		<div class="card text-white bg-secondary my-5 text-center" style="opacity:0.65">
			<div class="card-body">
				<ul class="navbar-nav ml-auto">
					<li class="nav-item"><a class="nav-link text-white m-0"
						href="#">정보게시판</a></li>
					<li class="nav-item"><a class="nav-link text-white m-0"
						href="#">지역게시판</a></li>
					<li class="nav-item"><a class="nav-link text-white m-0"
						href="#">홍보게시판</a></li>
					<li class="nav-item"><a class="nav-link text-white m-0"
						href="#">자유게시판</a></li>
				</ul>
			</div>
		</div>

		<!-- Content Row -->
		<div class="row">
			<div class="col-md-4 mb-5">
				<div class="card h-100">
					<div class="card-body">
						<h2 class="card-title"><a href="#">정보 게시판</a></h2>
						<p class="card-text">Lorem ipsum dolor sit amet, consectetur
							adipisicing elit. Rem magni quas ex numquam, maxime minus quam
							molestias corporis quod, ea minima accusamus.</p>
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
						<h2 class="card-title"><a href="#">지역 게시판</a></h2>
						<p class="card-text">Lorem ipsum dolor sit amet, consectetur
							adipisicing elit. Quod tenetur ex natus at dolorem enim! Nesciunt
							pariatur voluptatem sunt quam eaque, vel, non in id dolore
							voluptates quos eligendi labore.</p>
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
						<h2 class="card-title"><a href="#">홍보 게시판</a></h2>
						<p class="card-text">Lorem ipsum dolor sit amet, consectetur
							adipisicing elit. Rem magni quas ex numquam, maxime minus quam
							molestias corporis quod, ea minima accusamus.</p>
					</div>
					<div class="card-footer">
						<a href="#" class="btn btn-primary btn-sm">More Info</a>
					</div>
				</div>
			</div>
			<div class="col-md-4 mb-5">
				<div class="card h-100">
					<div class="card-body">
						<h2 class="card-title"><a href="#">자유 게시판</a></h2>
						<p class="card-text">Lorem ipsum dolor sit amet, consectetur
							adipisicing elit. Rem magni quas ex numquam, maxime minus quam
							molestias corporis quod, ea minima accusamus.</p>
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

<%@ include file="include/footer.jsp" %>