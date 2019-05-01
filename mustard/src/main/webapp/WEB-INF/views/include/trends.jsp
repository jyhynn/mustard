<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="list-group">
	<a href=
		<c:if test="${empty log}">"/board/boardList?board_no=2&shi=${guest.shi}&gungu=${guest.gungu }&dong=${guest.dong }"</c:if>
		<c:if test="${!empty log}">"/board/boardList?board_no=2&shi=${log.zip.shi }&gungu=${log.zip.gungu }&dong=${log.zip.dong }"</c:if> 
			class="list-group-item list-group-item-action">
		<img src="/resources/icons/web.png" class="icons mr-1 mb-1" alt="...">정보게시판</a>
	<a href=
		<c:if test="${empty log}">"/board/boardList?board_no=3&shi=${guest.shi}&gungu=${guest.gungu }&dong=${guest.dong }"</c:if>
		<c:if test="${!empty log}">"/board/boardList?board_no=3&shi=${log.zip.shi}&gungu=${log.zip.gungu }&dong=${log.zip.dong }"</c:if>
			class="list-group-item list-group-item-action">
		<img src="/resources/icons/store.png" class="icons mr-1 mb-1" alt="...">지역 게시판</a>
	<a href=
		<c:if test="${empty log}">"/board/boardList?board_no=4&shi=${guest.shi}&gungu=${guest.gungu }&dong=${guest.dong }"</c:if>
		<c:if test="${!empty log}">"/board/boardList?board_no=4&shi=${log.zip.shi}&gungu=${log.zip.gungu }&dong=${log.zip.dong }"</c:if>
			class="list-group-item list-group-item-action">
		<img src="/resources/icons/bullhorn.png" class="icons mr-1 mb-1" alt="...">홍보게시판</a>
	<a href=
		<c:if test="${empty log}">"/board/boardList?board_no=5&shi=${guest.shi}&gungu=${guest.gungu }&dong=${guest.dong }"</c:if>
		<c:if test="${!empty log}">"/board/boardList?board_no=5&shi=${log.zip.shi}&gungu=${log.zip.gungu }&dong=${log.zip.dong }"</c:if> 
			class="list-group-item list-group-item-action">
		<img src="/resources/icons/standup.png" class="icons mr-1 mb-1" alt="...">자유게시판</a>
	<a href="/board/noticeList"	aria-disabled="true" class="list-group-item list-group-item-action">
		<img src="/resources/icons/info.png" class="icons mr-1 mb-1" alt="...">공지사항</a>
</div>
<div class="list-group mt-4 trends">
	<a href="#" class="list-group-item disabled">실시간 인기글</a>
</div>
<script>
	$(function(){
		$.getJSON({
			url : '/board/getTrends',
			success : function(data){
				console.log(data);
				var str = "";
				$(data).each(function(i,obj){
					str += "<a href='/board/boardRead?board_no=" + obj.board_no + "&article_no=" + obj.article_no + "' class='list-group-item list-group-item-action'><small>" + obj.title + "</small></a></li>";		
				});	
				$(".trends").append(str);
			}
		});
	});
</script>