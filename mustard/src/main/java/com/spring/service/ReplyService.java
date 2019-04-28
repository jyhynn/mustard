package com.spring.service;

import java.util.HashMap;
import java.util.List;

import com.spring.domain.ReplyVO;

public interface ReplyService {

	public int insert(ReplyVO vo);
	public int delete(int article_no, int board_no, int reNo);
	public List<ReplyVO> get(int board_no, int notice_no);	
	public ReplyVO selected(int article_no, int board_no, int reNo);
	public int replyCount(int article_no, int board_no);
	public int likeyReply(int article_no, int board_no, int reNo);
	public int reportReply(int article_no, int board_no, int reNo, int memNo);
}
