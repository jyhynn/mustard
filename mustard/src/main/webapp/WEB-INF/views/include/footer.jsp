<%@page import="com.spring.domain.LogOnVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% LogOnVO log = (LogOnVO)request.getAttribute("log"); %>
<address class="links white mb-0">
	<ul class="links mb-0">
		<li class="copyright"><a href="#">&copy; 우리동네</a></li>
		<% if(log==null){ %>
			<li><a href="/board/askList?shi=${guest.shi }&gungu=${guest.gungu}&dong=${guest.dong}">문의하기</a></li>
		<%} %>
		<% if(log!=null){ %>
			<li><a href="/board/askList?shi=${log.zip.shi }&gungu=${log.zip.gungu}&dong=${log.zip.dong}">문의하기</a></li>
		<%} %>
	</ul>
</address>
</body>
</html>