package com.spring.service;

import java.util.HashMap;
import java.util.List;

import com.spring.domain.ReplyVO;

public interface ReplyService {

	public int insert(ReplyVO vo);
	public int update(ReplyVO vo);
	public int delete(int notice_no, int board_no, int reNo);
	public List<ReplyVO> get(int board_no, int notice_no);	
	public ReplyVO selected(int notice_no, int board_no, int reNo);
	public int replyCount(int notice_no, int board_no);
}
