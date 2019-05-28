package com.spring.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.domain.BoardVO;
import com.spring.domain.Common;
import com.spring.domain.MemberVO;
import com.spring.domain.Paging;
import com.spring.domain.QnaVO;
import com.spring.domain.ZipVO;
import com.spring.service.BoardService;
import com.spring.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin/*")
public class AdminController {
	
	@Autowired
	private MemberService memberservice;
	@Autowired
	private BoardService boardservice;
	
	@RequestMapping(value= {"/adminQna", "/adminMain"})
	public String adminQna(Model model, String page) {
		//전체 문의
		int nowPage = 1;
		if (page != null && !page.isEmpty()) {
			nowPage = Integer.parseInt(page);
		} else {
			page = "1";
		}
		int row_total = boardservice.getQnaAmount();
		String pageMenu = Paging.getPaging("/admin/adminQna", nowPage, row_total,Common.Reply.BLOCKLIST, Common.Reply.BLOCKPAGE);
		model.addAttribute("page", page);
		model.addAttribute("pageMenu", pageMenu);
		List<QnaVO> qnas = boardservice.getQnaList();
		model.addAttribute("qnas", qnas);
		
		return "/admin/adminQna";
	}
	
	@RequestMapping("/adminWatingAnswer")
	public String adminWatingAnswer(Model model, String page) {
		//답변대기중인 문의들
		int nowPage = 1;
		if (page != null && !page.isEmpty()) {
			nowPage = Integer.parseInt(page);
		} else {
			page = "1";
		}
		int row_total = boardservice.getWatingAmount();
		String pageMenu = Paging.getPaging("/admin/adminQna", nowPage, row_total,Common.Reply.BLOCKLIST, Common.Reply.BLOCKPAGE);
		model.addAttribute("page", page);
		model.addAttribute("pageMenu", pageMenu);
		List<QnaVO> qnas = boardservice.getWatingList();
		model.addAttribute("qnas", qnas);
	
		return "/admin/adminQna";
	}
	
	@RequestMapping("/adminBoard")
	public String adminBoard(Model model, ZipVO zip, String page, int board_no) {
		//게시판별 전체 목록
		int nowPage = 1;
		if (page != null && !page.isEmpty()) {
			nowPage = Integer.parseInt(page);
		} else {
			page = "1";
		}
		int row_total = boardservice.count(board_no);
		String pageMenu = Paging.getPaging("/admin/adminBoard?board_no=" + board_no, nowPage, row_total,Common.Admin.BLOCKLIST, Common.Admin.BLOCKPAGE);
		model.addAttribute("page", page);
		model.addAttribute("pageMenu", pageMenu);
		List<BoardVO> board = boardservice.getListforAdmin(board_no);
		model.addAttribute("board", board);
		model.addAttribute("board_no", board_no);
		return "/admin/adminBoard";
	}
	
	@RequestMapping("/adminMember") //회원 전체 목록
	public String adminMember(Model model, String page) {
		int nowPage = 1;
		if (page != null && !page.isEmpty()) {
			nowPage = Integer.parseInt(page);
		} else {
			page = "1";
		}
		
		int row_total = memberservice.MemberAmount();
		String pageMenu = Paging.getPaging("/admin/adminMember", nowPage, row_total,Common.Reply.BLOCKLIST, Common.Reply.BLOCKPAGE);
		
		model.addAttribute("page", page);
		model.addAttribute("pageMenu", pageMenu);
		List<MemberVO> members = memberservice.getAllMembers();
		model.addAttribute("members", members);
		
		return "/admin/adminMember";
	}
	
	@RequestMapping("/adminReports")
	public void adminReports(Model model) {
		//신고된 게시글 목록
		List<BoardVO> boardReported = boardservice.getReported();
		//신고당한 사용자 목록
		List<MemberVO> memberReported = memberservice.memberReported();
		
		model.addAttribute("br", boardReported);
		model.addAttribute("mr", memberReported);
	}
	
	@GetMapping("/adminControlMember")
	public void controlMember(@ModelAttribute("board")BoardVO board, int memNo, Model model) {
		MemberVO m = new MemberVO();
		if(board==null) {
			m = memberservice.getEmail(memNo);
		}
		m = memberservice.getEmail(board.getMemNo());
		model.addAttribute("m", m);
	}
	
	@PostMapping("/control")
	public String control(int memNo, int how, Model model) throws Exception {
		//개별회원등급관리
		log.info(""+memNo);
		switch (how) {
		case 0:
			 memberservice.controlDown(memNo);
			break;
		case 1:
			 memberservice.controlUp(memNo);
			break;
		case 2:
			 memberservice.removeMember(memNo);
			break;
		}
		model.addAttribute("memNo", memNo);
		return "redirect:adminControlMember";
	}
}
