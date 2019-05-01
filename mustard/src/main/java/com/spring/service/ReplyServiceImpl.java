package com.spring.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.domain.ReplyVO;
import com.spring.mapper.BoardMapper;
import com.spring.mapper.MemberMapper;
import com.spring.mapper.ReplyMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("reply")
public class ReplyServiceImpl implements ReplyService{
	
	@Autowired
	ReplyMapper mapper;
	@Autowired
	MemberMapper memberMapper;
	@Autowired
	BoardMapper boardMapper;
	
	@Override
	public int insert(ReplyVO vo) {
		HashMap<String, Integer> hash = new HashMap<>();
		//해당 글 댓글수+1
		hash.put("article_no", vo.getArticle_no());
		hash.put("board_no", vo.getBoard_no());
		boardMapper.updateReplyCnt(hash);
		if(vo.getBoard_no()==6) {	//문의게시판
			//문의게시판에 단 댓글은 답변이므로, 답변완료로 상태변경
			boardMapper.updateAnswer(vo.getArticle_no());
		}
		return mapper.insertReply(vo);
	}

	@Override
	public int delete(int article_no, int board_no, int reNo) {
		HashMap<String, Integer> hash = new HashMap<>();
		hash.put("article_no", article_no);
		hash.put("board_no", board_no);
		boardMapper.updateReplyDeleted(hash);//해당 글 댓글수-1
		hash.put("reNo", reNo);
		return mapper.delete(hash);
	}

	@Override
	public List<ReplyVO> get(int board_no, int article_no) {
		HashMap<String, Integer> hash = new HashMap<>();
		hash.put("board_no", board_no);
		hash.put("article_no", article_no);
		return mapper.get(hash);
	}

	@Override
	public ReplyVO selected(int article_no, int board_no, int reNo) {
		HashMap<String, Integer> hash = new HashMap<>();
		hash.put("board_no", board_no);
		hash.put("article_no", article_no);
		hash.put("reNo", reNo);
		return mapper.selected(hash);
	}

	@Override
	public int replyCount(int article_no, int board_no) {
		HashMap<String, Integer> hash = new HashMap<>();
		hash.put("board_no", board_no);
		hash.put("article_no", article_no);
		return mapper.replyCount(hash);
	}

	@Override
	public int likeyReply(int article_no, int board_no, int reNo) {
		HashMap<String, Integer> hash = new HashMap<>();
		hash.put("board_no", board_no);
		hash.put("article_no", article_no);
		hash.put("reNo", reNo);
		return mapper.likeyReply(hash);
	}

	@Override
	public int reportReply(int article_no, int board_no, int reNo, int memNo) {
		memberMapper.report(memNo);
		HashMap<String, Integer> hash = new HashMap<>();
		hash.put("board_no", board_no);
		hash.put("article_no", article_no);
		hash.put("reNo", reNo);
		return mapper.reportReply(hash);
	}
	
}
