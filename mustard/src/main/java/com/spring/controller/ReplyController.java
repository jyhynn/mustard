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
		vo.setMemNo(61);
		return service.insert(vo)==1 ? "ReplySuccess" : "ReplyFail";
	}
	
	//댓글목록
	@GetMapping("/getReplies")
	@ResponseBody
	public List<ReplyVO> getReply(int board_no, int article_no) {
		return service.get(board_no, article_no);
	}

	//댓글삭제
	@PostMapping("/deleteReply")
	@ResponseBody
	public String deleteReply(ReplyVO replyinfo) {
		return service.delete(replyinfo.getArticle_no(), replyinfo.getBoard_no(), replyinfo.getReNo())==1 ? "reDelSuccess" : "reDelFail";
	}
	
	//댓글좋아요
	@PostMapping("/likeyReply")
	@ResponseBody
	public String likeyReply(ReplyVO replyinfo) {
		return service.likeyReply(replyinfo.getArticle_no(), replyinfo.getBoard_no(), replyinfo.getReNo())==1 ? "reLikeSuccess" : "reLikeFail";
	}
	
	//댓글갯수
	@RequestMapping("/getReplyamount")
	@ResponseBody
	public int getReplyamount(int article_no, int board_no) {
		return service.replyCount(article_no, board_no);
	}
	
	//댓글신고
	@PostMapping("/reportReply")
	@ResponseBody
	public String reportReply(ReplyVO replyinfo) {
		return service.reportReply(replyinfo.getArticle_no(), replyinfo.getBoard_no(), replyinfo.getReNo(), replyinfo.getMemNo())==1 ? "reReportSuccess" : "reReportFail";
	}
}
