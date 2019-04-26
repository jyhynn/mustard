package com.spring.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.domain.ReplyVO;
import com.spring.mapper.ReplyMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("reply")
public class ReplyServiceImpl implements ReplyService{
	
	@Autowired
	ReplyMapper mapper;
	
	@Override
	public int insert(ReplyVO vo) {
		return mapper.insertReply(vo);
	}

	@Override
	public int update(ReplyVO vo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(int notice_no, int board_no, int reNo) {
		HashMap<String, Integer> hash = new HashMap<>();
		hash.put("notice_no", notice_no);
		hash.put("board_no", board_no);
		hash.put("reNo", reNo);
		return mapper.delete(hash);
	}

	@Override
	public List<ReplyVO> get(int board_no, int notice_no) {
		HashMap<String, Integer> hash = new HashMap<>();
		hash.put("board_no", board_no);
		hash.put("notice_no", notice_no);
		return mapper.get(hash);
	}

	@Override
	public ReplyVO selected(int notice_no, int board_no, int reNo) {
		HashMap<String, Integer> hash = new HashMap<>();
		hash.put("board_no", board_no);
		hash.put("notice_no", notice_no);
		hash.put("reNo", reNo);
		return mapper.selected(hash);
	}

	@Override
	public int replyCount(int notice_no, int board_no) {
		HashMap<String, Integer> hash = new HashMap<>();
		hash.put("board_no", board_no);
		hash.put("notice_no", notice_no);
		return mapper.replyCount(hash);
	}
	
}
