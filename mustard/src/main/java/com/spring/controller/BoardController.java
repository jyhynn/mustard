package com.spring.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.server.ServletServerHttpResponse;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.domain.BoardAttachVO;
import com.spring.domain.BoardVO;
import com.spring.domain.Criteria;
import com.spring.domain.PageDTO;
import com.spring.service.BoardService;
import com.spring.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/board/*")
public class BoardController {

	@Autowired
	BoardService service;
	@Autowired
	MemberService memberService;

	@RequestMapping("/boardList")
	public void boardlist(int board_no, Model model, @ModelAttribute("cri")Criteria cri) {
		log.info("게시판 페이지 나와라");
		List<BoardVO> list = service.getList(cri,board_no);
		model.addAttribute("board", list);
		model.addAttribute("bno", board_no);
		model.addAttribute("pageMaker", new PageDTO(cri,service.countPage(cri,1)));
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
		return "board/boardRead";
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

	@PostMapping("/boardWrite")
	public String boardWrite(BoardVO board, Model model) {
		log.info("글 등록해줘라");
		service.insert(board);
		model.addAttribute("bno", board.getBoard_no());
		return "/board/boardList";
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
	public String remove(int article_no, int board_no, RedirectAttributes rttr) {
		
		//첨부된 파일 폴더에서 삭제하기
		List<BoardAttachVO> attachList = service.attachList(article_no, board_no);
		if(service.delete(article_no, board_no)==1) {
			deleteFile(attachList);
			rttr.addFlashAttribute("result","success");
			rttr.addAttribute("board_no", board_no);
		}
		return "redirect:getAttachList";
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
	public String likeyBoard(int article_no, int board_no, int memNo ) {
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
