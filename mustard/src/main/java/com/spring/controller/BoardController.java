package com.spring.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.server.ServletServerHttpResponse;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.domain.BoardAttachVO;
import com.spring.domain.BoardVO;
import com.spring.domain.Common;
import com.spring.domain.Criteria;
import com.spring.domain.LinkVO;
import com.spring.domain.PageDTO;
import com.spring.domain.Paging;
import com.spring.domain.QnaVO;
import com.spring.domain.ZipVO;
import com.spring.service.BoardService;
import com.spring.service.MemberService;
import com.spring.service.ZipService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/board/*")
public class BoardController {

	@Autowired
	BoardService service;
	@Autowired
	MemberService memberService;
	@Autowired
	ZipService zipservice;

	@RequestMapping(value="/boardList", produces="text/html;charset=UTF-8")
	public String boardlist(int board_no, Model model, ZipVO zip, @ModelAttribute("cri")Criteria cri, String page/*, HttpServletRequest request*/, HttpServletResponse response) throws IOException {
		log.info("게시판 페이지 나와라 + " + zip.getShi());
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		//request.setCharacterEncoding("UTF-8");
		long code = zipservice.getZip(zip).getCode();
		//정보게시판 호출시
		if(board_no==2) {
			String classify = Long.toString(code);
			String url = "";
			List<LinkVO> link = new ArrayList<LinkVO>();
			Document doc = null;
			Elements element = null;
			switch (classify.substring(0, 2)) {
			case "11"://서울
				url = "http://www.seoul.go.kr/thismteventfstvl/list.do";
				doc = Jsoup.connect(url).get();
				element = doc.select("div.news-lst");
				for(Element el : element.select("div.item")) {
					LinkVO vo = new LinkVO();
					vo.setHref(el.select("a").attr("href"));
					vo.setTitle(el.select("em.subject").text());
					link.add(vo);
				}
				break;
			case "26"://부산
				url = "http://www.busan.go.kr/nbnews";
				doc = Jsoup.connect(url).get();
				element = doc.select("tbody");
				for(Element el : element.select("tr")) {
					LinkVO vo = new LinkVO();
					vo.setHref("http://www.busan.go.kr/" + el.select("td.title > a").attr("href"));
					vo.setTitle(el.select("td.title > a").text());
					link.add(vo);
				}
				break;
			case "27"://대구
				url = "http://www.daegu.go.kr/index.do?menu_id=00000854";
				//바로 주소이동
				out.println("<script>location.href='" + url + "';</script>");
				out.flush();
				break;
			case "28"://인천
				url = "http://www.incheon.go.kr/posts/incheon-news/";
				/*doc = Jsoup.connect(url).get();
				element = doc.select("div.cms_content");
				for(Element el : element.select("div.post_list")) {
					LinkVO vo = new LinkVO();
					vo.setHref("http://www.incheon.go.kr/posts/incheon-news/" + el.select("a").attr("href"));
					vo.setTitle(el.select("a").text());
					link.add(vo);
				}*/
				//바로 주소이동
				out.println("<script>location.href='" + url + "';</script>");
				out.flush();
				break;
			case "29"://광주
				url = "https://www.gwangju.go.kr/BD_0000000022/boardList.do?menuId=gwangju0306000000";
				doc = Jsoup.connect(url).get();
				element = doc.select("tbody");
				for(Element el : element.select("th.title")) {
					LinkVO vo = new LinkVO();
					vo.setHref(" https://www.gwangju.go.kr/" + el.select("a").attr("href"));
					vo.setTitle(el.select("div").text());
					link.add(vo);
				}
				break;
			case "30"://대전
				url = "https://www.daejeon.go.kr/drh/board/boardNormalList.do;jsessionid=lzu87aJcEQcabAUEKFVCNUfyh7fxEKOhRhXSgZV8bi8vutOKUb3Bg0KkFX1Gddk0.WEB1_servlet_engine1?boardId=normal_0096&menuSeq=1631";	
				doc = Jsoup.connect(url).get();
				element = doc.select("tbody");
				for(Element el : element.select("tr")) {
					//https://www.daejeon.go.kr
					LinkVO vo = new LinkVO();
					vo.setHref("https://www.daejeon.go.kr"+el.select("td.subject > a").attr("href"));
					vo.setTitle(el.select("td.subject > a").text());
					link.add(vo);
				}
				break;
			case "31"://울산
				url = "http://www.ulsan.go.kr/rep/notice";
				//바로 주소이동
				out.println("<script>location.href='" + url + "';</script>");
				out.flush();
				break;
			case "36"://세종
				url = "https://www.sejong.go.kr/cop/bbs/BBSMSTR_000000000080/selectBoardList.do";	
				doc = Jsoup.connect(url).get();
				element = doc.select("tbody");
				for(Element el : element.select("tr")) {
					//https://www.sejong.go.kr
					LinkVO vo = new LinkVO();
					vo.setHref("https://www.sejong.go.kr"+el.select("span.link > a").attr("href"));
					vo.setTitle(el.select("span.link > a").text());
					link.add(vo);
				}
				break;
			case "41"://경기
				url = "https://www.gg.go.kr/integrated-board";
				doc = Jsoup.connect(url).get();
				element = doc.select("tbody");
				for(Element el : element.select("td")) {
					LinkVO vo = new LinkVO();
					vo.setHref("https://www.gg.go.kr/" + el.select("a").attr("href"));
					vo.setTitle(el.select("a").text());
					link.add(vo);
				}
				break;
			case "42"://강원
				url = "http://www.provin.gangwon.kr/gw/portal/sub05_01";
				doc = Jsoup.connect(url).get();
				element = doc.select("tbody");
				for(Element el : element.select("td")) {
					//경로가 2개임. 나중꺼는 문서다운로드링크.
					LinkVO vo = new LinkVO();
					vo.setHref("http://www.provin.gangwon.kr/gw/portal/sub05_01" + el.select("a").attr("href"));
					vo.setTitle(el.select("a").text());
					link.add(vo);
				}
				break;
			case "43"://충북
				url = "http://www.chungbuk.go.kr/www/selectBbsNttList.do?bbsNo=3260&key=1552";
				doc = Jsoup.connect(url).get();
				element = doc.select("tbody.tb");
				for(Element el : element.select("tr")) {
					LinkVO vo = new LinkVO();
					vo.setHref("http://www.chungbuk.go.kr/www/" + el.select("td.subject > a").attr("href"));
					vo.setTitle(el.select("td.subject > a").text());
					link.add(vo);
				}
				break;
			case "44"://충남
				url = "http://www.chungnam.go.kr/cnnet/board.do?mnu_cd=CNNMENU00148#view";
				//바로 주소이동
				out.println("<script>location.href='" + url + "';</script>");
				out.flush();
				break;
			case "45"://전북
				url = "http://www.jeonbuk.go.kr/board/list.jeonbuk;jsessionid=gmRrtTH19RR8aYmD7vjIz2hcZTeOLVscDJGmAbH9YU2CHNAhUl2vRMt8eF3baG7J.was01_se";
				//바로 주소이동
				out.println("<script>location.href='" + url + "';</script>");
				out.flush();
				break;
			case "46"://전남
				url = "http://www.jeonnam.go.kr/M7124/boardList.do?menuId=jeonnam0201000000";
				doc = Jsoup.connect(url).get();
				element = doc.select("tbody");
				for(Element el : element.select("tr")) {
					LinkVO vo = new LinkVO();
					vo.setHref("http://www.jeonnam.go.kr/" + el.select("td.title > a").attr("href"));
					vo.setTitle(el.select("td.title > a").text());
					link.add(vo);
				}
				break;
			case "47"://경북
				url = "http://www.gb.go.kr/Main/page.do?mnu_uid=2076&BD_CODE=bbs_gongji";		
				doc = Jsoup.connect(url).get();
				element = doc.select("tbody");
				for(Element el : element.select("tr")) {
					//http://www.gb.go.kr/Main   .없애야함
					LinkVO vo = new LinkVO();
					vo.setHref("http://www.gb.go.kr/Main"+(el.select("td.b_subject > a").attr("href")).substring(1));
					vo.setTitle(el.select("td.b_subject > a").text());
					link.add(vo);
				}
				break;
			case "48"://경남
				url = "http://www.gyeongnam.go.kr/board/list.gyeong?boardId=BBS_0000057&menuCd=DOM_000000104001001000&contentsSid=717&cpath=";
				//바로 주소이동
				out.println("<script>location.href='" + url + "';</script>");
				out.flush();
				break;
			case "50"://제주
				url = "https://www.jeju.go.kr/news/news/news.htm";		
				doc = Jsoup.connect(url).get();
				element = doc.select("tbody");
				for(Element el : element.select("tr")) {
					LinkVO vo = new LinkVO();
					//https://www.jeju.go.kr
					vo.setHref("https://www.jeju.go.kr"+el.select("td.title > a").attr("href"));
					vo.setTitle(el.select("td.title > a").text());
					link.add(vo);
				}
				break;
			}
			model.addAttribute("link",link);
		}else {
			
			//페이징
			int nowPage = 1; // 기본으로 보여질 페이지
			if (page != null && !page.isEmpty()) {	//페이지값이 안넘어 왔을때
				nowPage = Integer.parseInt(page);
			} else {
				page = "1";
			}
			// 전체게시물 수 구하기
			int row_total = service.getAllList(board_no, zip);
			// 현재 페이지 메뉴 생성
			String pageMenu = Paging.getPaging("/board/boardList?board_no=" + board_no + "&shi=" + zip.getShi() + "&gungu=" + zip.getGungu() + "&dong=" + zip.getDong(), nowPage, row_total,
					Common.Reply.BLOCKLIST, Common.Reply.BLOCKPAGE);
			
			model.addAttribute("page", page);
			model.addAttribute("pageMenu", pageMenu);
			List<BoardVO> list = service.getListPaging(nowPage, board_no, code);
			model.addAttribute("board", list);
		}
		
		model.addAttribute("bno", board_no);
		return "/board/boardList";
	}

	//게시글 읽기
	@RequestMapping("/boardRead")
	public String boardRead(int article_no, Integer board_no, Model model, HttpServletResponse response) {
		log.info(article_no + "번째 글 읽기 나와라");
		
		//조회수
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		Cookie cookies[] = request.getCookies();
		Map<String, String> map = new HashMap<>();
		if(request.getCookies()!=null) {
			for(int i=0; i<cookies.length; i++) {
				Cookie obj = cookies[i];
				map.put(obj.getName(), obj.getValue());
			}
		}
		String readCount = (String)map.get("readhit");
		String newReadCount = "|" + article_no;
		//저장된 쿠키에 새로운 쿠키값 존재하는지 검사
		if(StringUtils.indexOfIgnoreCase(readCount, newReadCount)==-1) {
			Cookie cookie = new Cookie("readhit", readCount+newReadCount);
			response.addCookie(cookie);
			service.updateReadhit(article_no, board_no);
		}
		
		BoardVO board = service.getBaord(article_no, board_no);
		model.addAttribute("bno", board_no);
		model.addAttribute("board", board);
		return "/board/boardRead";
	}
	
	//수정
	@RequestMapping("/boardModify")
	public void boardModify(int article_no, Integer board_no, Model model) {
		log.info(article_no + "번째 글 수정 나와라");
		BoardVO board = service.getBaord(article_no, board_no);
		model.addAttribute("bno", board_no);
		model.addAttribute("board", board);
	}
	
	@RequestMapping("/BoardgetAttachList")
	@ResponseBody
	public List<BoardAttachVO> getAttList(int article_no, int board_no, Model model) {
		List<BoardAttachVO> list = service.attachList(article_no, board_no);
		model.addAttribute("bno", board_no);
		return list;
	}
	
	@RequestMapping("/boardWrite")
	public void boardWriteForm(int board_no, Model model) {
		log.info("게시판 글쓰기 폼 나와라");
		model.addAttribute("bno", board_no);
	}

	@PostMapping(value="/goboardWrite", produces="text/plain;charset=UTF-8")
	public String boardWrite(BoardVO board, RedirectAttributes rttr, HttpServletResponse response) {
		response.setContentType("text/html;charset=UTF-8");
		log.info("글 등록해줘라");
		service.insert(board);
		log.info("글쓰기 시 : " + board.getZip().getShi());
		rttr.addAttribute("shi", board.getZip().getShi());
		rttr.addAttribute("gungu", board.getZip().getGungu());
		rttr.addAttribute("dong", board.getZip().getDong());
		return "redirect:boardList?board_no=" + board.getBoard_no();
	}
	
	@PostMapping("/boardModify")
	public String boardUpdate(@ModelAttribute("board")BoardVO board, RedirectAttributes rttr) {
		//제목, 글번호 , 글쓴닉, 글쓴회원번호, 내용, 첨부파일들
		service.update(board);
		if (board.getAttach() != null) {
			for (BoardAttachVO attach : board.getAttach()) {
				log.info(" 첨부파일목록 : " + attach);
			}
		}
		rttr.addAttribute("article_no", board.getArticle_no());
		rttr.addAttribute("board_no", board.getBoard_no());
		return "redirect:boardRead";
	}
	
	@PostMapping("/removeBoard")
	public String remove(BoardVO board, RedirectAttributes rttr) {
		//첨부된 파일 폴더에서 삭제하기
		List<BoardAttachVO> attachList = service.attachList(board.getArticle_no(), board.getBoard_no());
		if(service.delete(board.getArticle_no(), board.getBoard_no())==1) {
			deleteFile(attachList);
			rttr.addFlashAttribute("result","success");
			rttr.addAttribute("board_no", board.getBoard_no());
			rttr.addAttribute("shi", board.getZip().getShi());
			rttr.addAttribute("gungu", board.getZip().getGungu());
			rttr.addAttribute("dong", board.getZip().getDong());
			
		}
		return "redirect:boardList?board_no=" + board.getBoard_no();
	}
	
	//문의
	@GetMapping("/askList")
	public void askList(Model model, @ModelAttribute("cri")Criteria cri, ZipVO zip) {
		log.info("문의 페이지 나와라");
		List<QnaVO> list = service.getQnaList(cri);
		model.addAttribute("ask", list);
		model.addAttribute("pageMaker", new PageDTO(cri,service.countPage(cri,6, zip)));
	}
	
	@RequestMapping(value= {"/askRead","/askModify"})
	public void askRead(int qna_no, Model model) {
		log.info(qna_no + "번째 문의글 나와라");
		QnaVO ask = service.getAsk(qna_no);
		model.addAttribute("ask", ask);
	}
	
	@GetMapping("/askWrite")
	public void ask() {
		log.info("게시판 글쓰기 폼 나와라");
	}

	@PostMapping("/askWrite")
	public String askWrite(QnaVO qna, ZipVO zip, RedirectAttributes rttr) {
		log.info("글 등록해줘라");
		service.insertQna(qna);
		rttr.addAttribute("shi", zip.getShi());
		rttr.addAttribute("gungu", zip.getGungu());
		rttr.addAttribute("dong", zip.getDong());
		return "redirect:askList";
	}
	
	@PostMapping("/askModify")
	public String askUpdate(@ModelAttribute("board")QnaVO qna, RedirectAttributes rttr) {
		//제목, 글번호 , 글쓴닉, 글쓴회원번호, 내용, 첨부파일들
		service.updateQna(qna);
		rttr.addAttribute("qna_no", qna.getQna_no());
		rttr.addAttribute("board_no", qna.getBoard_no());
		return "redirect:askRead";
	}
	
	@PostMapping("/removeAsk")
	public String askRemove(int qna_no, int board_no, RedirectAttributes rttr) {
		service.deleteAsk(qna_no);
		return "/board/askList";
	}
	
	//실시간인기글
	@GetMapping("/getTrends")
	@ResponseBody
	public List<BoardVO> getTrends(){
		return service.getTrends();
	}
	//신고
	@PostMapping("/reportBoard")
	@ResponseBody
	public String reportBoard(int article_no, int board_no, int memNo ) {
		return service.report(article_no,board_no,memNo)==1?"boardReportSuccess" : "boardReportFail";
	}
	
	//좋아요
	@PostMapping("/likeyBoard")
	@ResponseBody
	public String likeyBoard(int article_no, int board_no ) {
		return service.likey(article_no,board_no)==1?"boardLikeySuccess" : "boardLikeyFail";
	}
	
	//좋아요 갯수
	@RequestMapping("/getLikeyamount")
	@ResponseBody
	public int getLikeyamount(int article_no, int board_no) {
		return service.getLikeyamount(article_no, board_no);
	}
	
	//스크랩
	@PostMapping("/scrapBoard")
	@ResponseBody
	public String scrapBoard(int article_no, int board_no, int memNo ) {
		return service.scrap(article_no,board_no,memNo)==1?"boardScrapSuccess" : "boardScrapFail";
	}
	
	//검색리스트
	@RequestMapping("/searching")
	public void searching(int board_no, String keyword, ZipVO zip, Criteria cri, Model model) {
		log.info(board_no + "-" + keyword + "-" + zip.getShi());
		List<BoardVO> list = service.searching(board_no, keyword, zip, cri);
		model.addAttribute("bno", board_no);
		model.addAttribute("search", list);
		model.addAttribute("pageMaker", new PageDTO(cri,service.countPage(cri,6, zip)));
	}
	
	
	// 첨부파일 삭제
		private void deleteFile(List<BoardAttachVO> attach) {
			// type이 image라면 썸네일과 원본파일 삭제
			// type이 file이라면 원본파일만 삭제
			log.info("첨부파일 삭제요청...");
			if(attach.size()==0 || attach==null) {
				return;
			}
			for(BoardAttachVO vo : attach) {
				Path file = Paths.get("d:\\upload\\" + vo.getUploadPath() + "\\" + vo.getUuid() + "_" + vo.getFileName());
			
				try {
					//일반파일 및 원본파일 삭제
					Files.deleteIfExists(file);
					
					//이미지 파일인 경우 썸네일 삭제
					if(Files.probeContentType(file).startsWith("image")) {
						Path thumbNail = Paths.get("d:\\upload\\"+vo.getUploadPath() + "\\thum_" + vo.getUuid() + "_" + vo.getFileName());
						Files.deleteIfExists(thumbNail);
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
}
