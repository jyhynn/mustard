package com.spring.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.domain.BoardNoticeVO;
import com.spring.service.BoardNoticeService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/board/*")
public class BoardController {
	
	@Autowired
	BoardNoticeService service;
	
	@RequestMapping("/noticeList")
	public void noticelist(Model model) {
		log.info("공지사항 페이지 나와라");
		List<BoardNoticeVO> list = service.getList();
		model.addAttribute("notice", list);
	}
	
	@RequestMapping("/noticeRead")
	public void noticeRead(int notice_no, Model model) {
		log.info(notice_no + "번째 공지사항 읽기 나와라");
		BoardNoticeVO notice = service.getNotice(notice_no);
		model.addAttribute("notice", notice);
	}
	
	@RequestMapping("/noticeWrite")
	public void noticeWriteForm() {
		log.info("공지사항 글쓰기 폼 나와라");
	}
	
	@PostMapping("/noticeWrite")
	public void noticeWrite(BoardNoticeVO notice, RedirectAttributes rttr) {
		log.info("글 등록해줘라");
		service.insert(notice);
		rttr.addFlashAttribute("msg", "success");
	}
}
