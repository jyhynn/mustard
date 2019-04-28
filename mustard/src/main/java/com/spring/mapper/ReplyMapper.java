package com.spring.mapper;

import java.util.HashMap;
import java.util.List;

import com.spring.domain.BoardVO;
import com.spring.domain.ReplyVO;

public interface ReplyMapper {
	public int insertReply(ReplyVO vo);
	public List<ReplyVO> get(HashMap<String, Integer> hash);
	public int delete(HashMap<String, Integer> hash);
	public ReplyVO selected(HashMap<String, Integer> hash);
	public int replyCount(HashMap<String, Integer> hash);
	public int likeyReply(HashMap<String, Integer> hash);
	public int reportReply(HashMap<String, Integer> hash);
	public List<BoardVO> getMyReplies(int memNo);
}
