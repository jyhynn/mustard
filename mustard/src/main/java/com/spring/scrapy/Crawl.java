package com.spring.scrapy;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class Crawl {
	
	@RequestMapping("/testing")
	public String crawling() throws Exception {
		String url = "http://news.seoul.go.kr/culture/archives/502047";
		System.out.println("===============");
		System.out.println("url : " + url);
		
		Document doc = Jsoup.connect(url).get();
		
		Elements element = doc.select("#view_top");
		String title = element.select("h3").text();
		System.out.println("제목 : " + title);
		for(Element el : element.select("p")) {
			System.out.println(el.text());
		}
		for(Element el : doc.select("#post_content").select("p")) {
			System.out.println(el.text());
		}
		element = doc.select("#post_content");
		System.out.println(element.select("img > src").text());
		return "{\"l\":\"l\"}";
	}

	
}
