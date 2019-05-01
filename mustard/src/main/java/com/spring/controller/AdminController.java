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
import com.spring.domain.Criteria;
import com.spring.domain.MemberVO;
import com.spring.domain.PageDTO;
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
	public void adminQna(Model model, @ModelAttribute("cri") Criteria cri) {
		//새로 올라온 문의
		//답변한 문의 필터링 기능
		List<QnaVO> qnas = boardservice.getQnaList(cri);
		model.addAttribute("qnas", qnas);
		model.addAttribute("pageMaker", new PageDTO(cri, boardservice.count(cri, 6)));
	}
	
	@RequestMapping("/adminWatingAnswer")
	public void adminWatingAnswer(Model model, @ModelAttribute("cri") Criteria cri) {
		//답변대기중인 문의들
		List<QnaVO> qnas = boardservice.getWatingList();
		model.addAttribute("qnas", qnas);
		model.addAttribute("pageMaker", new PageDTO(cri, boardservice.count(cri, 6)));
	}
	
	@RequestMapping("/adminBoard")
	public void adminBoard(Model model, @ModelAttribute("cri") Criteria cri, ZipVO zip) {
		//게시판별 전체 목록
		List<BoardVO> board3 = boardservice.getListforAdmin(3, cri);
		List<BoardVO> board4 = boardservice.getListforAdmin(4, cri);
		List<BoardVO> board5 = boardservice.getListforAdmin(5, cri);
		model.addAttribute("board3", board3);
		model.addAttribute("board4", board4);
		model.addAttribute("board5", board5);
		model.addAttribute("pageMaker3", new PageDTO(cri, boardservice.count(cri, 3)));
		model.addAttribute("pageMaker4", new PageDTO(cri, boardservice.count(cri, 4)));
		model.addAttribute("pageMaker5", new PageDTO(cri, boardservice.count(cri, 5)));
	}
	
	@RequestMapping("/adminMember")
	public void adminMember(Model model, @ModelAttribute("cri") Criteria cri) {
		//회원 전체 목록
		List<MemberVO> members = memberservice.getAllMembers(cri);
		model.addAttribute("members", members);
		model.addAttribute("pageMaker", new PageDTO(cri, memberservice.countPage(cri)));
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
