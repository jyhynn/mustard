package com.spring.scrapy;

import java.util.ArrayList;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.domain.LinkVO;

@Controller
public class Crawl {
	//크롤링 테스트
	@RequestMapping("/testing")
	public void crawling() throws Exception {
		//int code 파라미터로 받고
		int code = 1111010400;
		//code.toString해서 subString으로 앞에 2자만 짤라
		String classify = Integer.toString(code);
		System.out.println(classify.substring(0, 2));
		//그 두자로 url 연결해서 크롤러 실행.
		//받아온 String aUrl과 String title를 리스트로 받아서 model에 담아서 리턴
		//뷰단에서 리스트로만 뿌려주고 클릭시 해당링크로 이동
		
		
//서울시		String url = "http://www.seoul.go.kr/thismteventfstvl/list.do";
//광주		String url = "https://www.gwangju.go.kr/BD_0000000022/boardList.do?menuId=gwangju0306000000";
//경기도		String url = "https://www.gg.go.kr/integrated-board";
//강원도		String url = "http://www.provin.gangwon.kr/gw/portal/sub05_01";		//42
		String url = "http://www.incheon.go.kr/posts/incheon-news/";	
//부산		String url = "http://www.busan.go.kr/nbnews";	
//충남(보류)	String url = "http://www.chungnam.go.kr/cnnet/board.do?mnu_cd=CNNMENU00148#view";
//충북		String url = "http://www.chungbuk.go.kr/www/selectBbsNttList.do?bbsNo=3260&key=1552";
//전남		String url = "http://www.jeonnam.go.kr/M7124/boardList.do?menuId=jeonnam0201000000";
//대구		String url = "http://www.daegu.go.kr/index.do?menu_id=00000854";
//		String url = "http://www.gyeongnam.go.kr/board/list.gyeong?boardId=BBS_0000057&menuCd=DOM_000000104001001000&contentsSid=717&cpath=";
		System.out.println("===============");
		System.out.println("url : " + url);
		
		Document doc = Jsoup.connect(url).get();
		//일단 타이틀 띄우고 클릭하면 링크연결되게 해야겟음..
		

		//강원도
	/*		Elements element = doc.select("tbody");
		for(Element el : element.select("td")) {
			//경로가 2개임. 나중꺼는 문서다운로드링크.
			//http://www.provin.gangwon.kr/gw/portal/sub05_01 경로앞에.
			System.out.println(el.select("a").attr("href"));
			System.out.println(el.select("a").text());
		}*/
		
		//인천
		Elements element = doc.select("div.cms_content");
		for(Element el : element.select("div.post_list")) {
			//http://www.incheon.go.kr/posts/incheon-news/ 
			System.out.println(el.select("a").attr("href"));
			System.out.println(el.select("a").text());
		}
		//tr:nth-child(2)
		
		//부산
/*		Elements element = doc.select("tbody");
		for(Element el : element.select("tr")) {
			//http://www.busan.go.kr/ 
			System.out.println(el.select("td.title > a").attr("href"));
			System.out.println(el.select("td.title > a").text());
		}*/
		
		//충남 >> 직링으로 빼기
		/*Elements element = doc.select("tbody");
		for(Element el : element.select("tr")) {
			//http://www.chungnam.go.kr/cnnet/board.do?mnu_url=/cnbbs/view.do
			//?mnu_cd=CNNMENU00148
			//&board_seq=
			//&code=
			//&menuTitle=
			//http://www.chungnam.go.kr/cnnet/board.do?mnu_url=CNNMENU00148&board_seq=242081
			//http://www.chungnam.go.kr/cnnet/board.do?mnu_cd=CNNMENU00148
			System.out.println(el.select("td.title_comm > a").attr("onclick"));
			//return fn_egov_select('242081','2019년 작은 브랜드 100개 찾기 사업 참여기업 모집','36')
		}*/
		
		//충북
		/*Elements element = doc.select("tbody.tb");
		for(Element el : element.select("tr")) {
			http://www.chungbuk.go.kr/www/	//href 맨 앞에 .하나 잇음
			System.out.println(el.select("td.subject > a").attr("href"));
			System.out.println(el.select("td.subject > a").text());
		}*/
		
		//전남
		/*Elements element = doc.select("tbody");
		for(Element el : element.select("tr")) {
			//http://www.jeonnam.go.kr/
		System.out.println(el.select("td.title > a").attr("href"));
		System.out.println(el.select("td.title > a").text());
		}*/
		
		//대구 >> 직링으로 빼기
/*		Elements element = doc.select("tbody");
		for(Element el : element.select("tr")) {
			//http://www.gyeongnam.go.kr/
		System.out.println(el.select("td.title > a").attr("href"));
		System.out.println(el.select("td.title > a").text());
		}
		*/
		
		/*Elements element = doc.select("#view_top");
		String title = element.select("h3").text();
		System.out.println("제목 : " + title);
		for(Element el : element.select("p")) {
			System.out.println(el.text());
		}
		for(Element el : doc.select("#post_content").select("p")) {
			System.out.println(el.text());
		}
		element = doc.select("#post_content");
		System.out.println(element.select("img > src").text());*/
	
	}

	
}
