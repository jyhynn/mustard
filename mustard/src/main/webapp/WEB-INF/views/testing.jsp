<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/resources/vendor/bootstrap/css/bootstrap.min.css" />
<script src="/resources/vendor/jquery/jquery.min.js"></script>
<script>
	var request = require('request');
	var cheerio = require('cheerio');
	var url = "https://www.seoul.go.kr/thismteventfstvl/list.do";
	request(url, function (err, res, html) {
	    if (!err) {	//에러 안나면 정보 가져오기
	        var $ = cheerio.load(html);
	    
	        $(".news-lst > .item").each(function () {
	            var post = {"link": "", "image": "", "subject": "", "date": ,"txt" : ""};
	            var data = $(this);
	            
	            post["subject"] = data.text();
	          	console.log(post["subject"].val());
	            post["link"] = data.attr("href");
	        });
	    }
	})
	
</script>
</head>
<!-- https://www.seoul.go.kr/thismteventfstvl/list.do -->
<body>
	<div class="list-group">
  <a href="#" class="list-group-item list-group-item-action active">
    Cras justo odio
  </a>
  <a href="#" class="list-group-item list-group-item-action">Dapibus ac facilisis in</a>
  <a href="#" class="list-group-item list-group-item-action">Morbi leo risus</a>
  <a href="#" class="list-group-item list-group-item-action">Porta ac consectetur ac</a>
  <a href="#" class="list-group-item list-group-item-action disabled" tabindex="-1" aria-disabled="true">Vestibulum at eros</a>
</div>
</body>
</html>