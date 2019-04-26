package com.spring.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.domain.ReplyVO;
import com.spring.service.ReplyService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/replies/*")
@Controller
public class ReplyController {

	@Autowired
	ReplyService service;
	
	//댓글입력
	@PostMapping("/insertReply")
	@ResponseBody
	public String insertReply(ReplyVO vo) {
		vo.setMemNo(26);
		return service.insert(vo)==1 ? "ReplySuccess" : "ReplyFail";
	}
	
	//댓글목록
	@GetMapping("/getReplies")
	@ResponseBody
	public List<ReplyVO> getReply(int board_no, int notice_no) {
		return service.get(board_no, notice_no);
	}
	
/*	//선택된 댓글 정보
	@GetMapping("selectReply")
	public String selectReply(int board_no, int notice_no, int reNo, Model model) {
		ReplyVO vo = service.selected(notice_no, board_no, reNo);
		model.addAttribute("replyinfo", vo);
		return "redirect:deleteReply";
	}*/
	
	//댓글삭제
	@PostMapping("/deleteReply")
	@ResponseBody
	public String deleteReply(ReplyVO replyinfo, Model model) {
		return service.delete(replyinfo.getNotice_no(), replyinfo.getBoard_no(), replyinfo.getReNo())==1 ? "reDelSuccess" : "reDelFail";
	}
}
