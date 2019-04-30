<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<ul class="list-group">
	<li class="list-group-item"><a href=
			<c:if test="${empty log}">
				"/board/boardList?board_no=2&shi=${guest.shi}&gungu=${guest.gungu }&dong=${guest.dong }"
			</c:if>
			<c:if test="${!empty log}">
				"/board/boardList?board_no=2&shi=${log.zip.shi }&gungu=${log.zip.gungu }&dong=${log.zip.dong }"
			</c:if> >정보게시판</a></li>
	<li class="list-group-item"><a href=
			<c:if test="${empty log}">
				"/board/boardList?board_no=3&shi=${guest.shi}&gungu=${guest.gungu }&dong=${guest.dong }"
			</c:if>
			<c:if test="${!empty log}">
				"/board/boardList?board_no=3&shi=${log.zip.shi}&gungu=${log.zip.gungu }&dong=${log.zip.dong }"
			</c:if>>지역 게시판</a></li>
	<li class="list-group-item"><a href=
			<c:if test="${empty log}">
				"/board/boardList?board_no=4&shi=${guest.shi}&gungu=${guest.gungu }&dong=${guest.dong }"
			</c:if>
			<c:if test="${!empty log}">
				"/board/boardList?board_no=4&shi=${log.zip.shi}&gungu=${log.zip.gungu }&dong=${log.zip.dong }"
			</c:if>>홍보게시판</a></li>
	<li class="list-group-item"><a href=
			<c:if test="${empty log}">
				"/board/boardList?board_no=5&shi=${guest.shi}&gungu=${guest.gungu }&dong=${guest.dong }"
			</c:if>
			<c:if test="${!empty log}">
				"/board/boardList?board_no=5&shi=${log.zip.shi}&gungu=${log.zip.gungu }&dong=${log.zip.dong }"
			</c:if> >자유게시판</a></li>
	<li class="list-group-item"><a href="/board/noticeList"	aria-disabled="true">공지사항</a></li>
</ul>
<ul class="list-group mt-4 trends">
	<li class="list-group-item" aria-disabled="true"><h4>실시간 인기글</h4></li>
</ul>

<script>
	$(function(){
		$.getJSON({
			url : '/board/getTrends',
			success : function(data){
				console.log(data);
				var str = "";
				$(data).each(function(i,obj){
					str += "<li class='list-group-item'><a href='/board/boardRead?board_no=" + obj.board_no + "&article_no=" + obj.article_no + "'>" + encodeURIComponent(obj.title) + "</a></li>";		
				});	
				$(".trends").append(str);
			}
		});
	});
</script>