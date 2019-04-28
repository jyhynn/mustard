package com.spring.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.domain.BoardAttachVO;
import com.spring.domain.BoardVO;
import com.spring.domain.Criteria;
import com.spring.domain.ScrapVO;
import com.spring.mapper.BoardAttachMapper;
import com.spring.mapper.BoardMapper;
import com.spring.mapper.MemberMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("boardService")
public class BoardServiceImpl implements BoardService{

	@Autowired
	private BoardMapper mapper;
	@Autowired
	private BoardAttachMapper attachMapper;
	@Autowired
	private MemberMapper memberMapper;

	@Override
	public List<BoardVO> getList(Criteria cri, int board_no) {
		HashMap<String, Integer> hash = new HashMap<>();
		hash.put("board_no", board_no);
		hash.put("pageNum", cri.getPageNum());
		hash.put("amount", cri.getAmount());
		return mapper.getList(hash);
	}

	@Override
	public BoardVO getBaord(int article_no, int board_no) {
		HashMap<String, Integer> hash = new HashMap<>();
		hash.put("article_no", article_no);
		hash.put("board_no", board_no);
		return mapper.getBoard(hash);
	}
	
	@Transactional
	@Override
	public void insert(BoardVO board) {
		mapper.insert(board);
		if(board.getAttach()==null || board.getAttach().size()<=0) {
			return;
		}
		board.getAttach().forEach(attach -> {
			attach.setArticle_no(board.getArticle_no());
			attachMapper.insert(attach);
		});
	}

	@Transactional
	@Override
	public int update(BoardVO board) {
		HashMap<String, Integer> hash = new HashMap<>();
		hash.put("article_no", board.getArticle_no());
		hash.put("board_no", board.getBoard_no());
		attachMapper.delete(hash);
		int modifyResult = mapper.update(board);
		
		if(board.getAttach()==null || board.getAttach().size()<=0) {
			return 0;
		}
		if(modifyResult==1 && board.getAttach().size()>=0) {
			board.getAttach().forEach(attach->{
				attach.setArticle_no(board.getArticle_no());
				attachMapper.insert(attach);
			});
			return 0;
		}
		return mapper.update(board);
	}

	@Transactional
	@Override
	public int delete(int article_no, int board_no) {
		HashMap<String, Integer> hash = new HashMap<>();
		hash.put("article_no", article_no);
		hash.put("board_no", board_no);
		attachMapper.delete(hash);
		return mapper.delete(hash);
	}

	@Override
	public List<BoardAttachVO> attachList(int article_no, int board_no) {
		HashMap<String, Integer> hash = new HashMap<>();
		hash.put("article_no", article_no);
		hash.put("board_no", board_no);
		return attachMapper.findByNo(hash);
	}

	@Override
	public List<BoardAttachVO> getAttachs() {
		return attachMapper.getAttachs();
	}

	@Override
	public int countPage(Criteria cri, int board_no) {
		HashMap<String, Integer> hash = new HashMap<>();
		hash.put("board_no", board_no);
		hash.put("pageNum", cri.getPageNum());
		hash.put("amount", cri.getAmount());
		return mapper.countPage(hash);
	}
	
	@Transactional
	@Override
	public int report(int article_no, int board_no, int memNo) {
		memberMapper.report(memNo);
		HashMap<String, Integer> hash = new HashMap<>();
		hash.put("article_no", article_no);
		hash.put("board_no", board_no);
		return mapper.report(hash);
	}

	@Override
	public int updateReadhit(int article_no, int board_no) {
		HashMap<String, Integer> hash = new HashMap<>();
		hash.put("article_no", article_no);
		hash.put("board_no", board_no);
		return mapper.updateReadhit(hash);
	}

	@Override
	public int likey(int article_no, int board_no) {
		HashMap<String, Integer> hash = new HashMap<>();
		hash.put("article_no", article_no);
		hash.put("board_no", board_no);
		return mapper.likey(hash);
	}
	
	@Override
	public int scrap(int article_no, int board_no, int memNo) {
		HashMap<String, Integer> hash = new HashMap<>();
		hash.put("article_no", article_no);
		hash.put("board_no", board_no);
		hash.put("memNo",memNo);
		return mapper.scrap(hash);
	}

	@Override
	public int getLikeyamount(int article_no, int board_no) {
		HashMap<String, Integer> hash = new HashMap<>();
		hash.put("article_no", article_no);
		hash.put("board_no", board_no);
		return mapper.getLikeyamount(hash);
	}
}