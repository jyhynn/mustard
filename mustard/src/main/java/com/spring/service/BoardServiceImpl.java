package com.spring.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.domain.BoardAttachVO;
import com.spring.domain.BoardVO;
import com.spring.domain.Criteria;
import com.spring.domain.QnaVO;
import com.spring.domain.ScrapVO;
import com.spring.domain.ZipVO;
import com.spring.mapper.BoardAttachMapper;
import com.spring.mapper.BoardMapper;
import com.spring.mapper.MemberMapper;
import com.spring.mapper.ZipMapper;

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
	@Autowired
	private ZipMapper zipmapper;

	@Override
	public List<BoardVO> getList(Criteria cri, int board_no, ZipVO zip) {
		HashMap<String, Object> hash = new HashMap<>();
		hash.put("code", zipmapper.getZip(zip).getCode());
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
		board.setCode(zipmapper.getZip(board.getZip()).getCode());
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
		board.setTitle("(수정)" + board.getTitle());
		return mapper.update(board);
	}

	@Transactional
	@Override
	public int delete(int article_no, int board_no) {
		HashMap<String, Integer> hash = new HashMap<>();
		hash.put("article_no", article_no);
		hash.put("board_no", board_no);
		hash.put("notice_no", article_no);
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
	public int countPage(Criteria cri, int board_no, ZipVO zip) {
		HashMap<String, Object> hash = new HashMap<>();
		hash.put("code", zipmapper.getZip(zip).getCode());
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
	public List<BoardVO> getReported() {
		return mapper.getReported();
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

	@Override
	public List<BoardVO> getListforMain(int board_no, ZipVO zip) {
		HashMap<String, Object> hash = new HashMap<>();
		hash.put("code", zipmapper.getZip(zip).getCode());
		hash.put("board_no", board_no);
		return mapper.getListforMain(hash);
	}

	@Override
	public List<QnaVO> getQnaList(Criteria cri) {
		return mapper.getQnaList(cri);
	}
	
	@Override
	public QnaVO getAsk(int qna_no) {
		return mapper.getAsk(qna_no);
	}
	
	@Override
	public int insertQna(QnaVO qna) {
		return mapper.insertQna(qna);
	}

	@Override
	public List<BoardVO> getTrends() {
		return mapper.getTrends();
	}

	@Override
	public int updateQna(QnaVO qna) {
		return mapper.updateQna(qna);
	}

	@Override
	public int deleteAsk(int qna_no) {
		return mapper.deleteAsk(qna_no);
	}

	@Override
	public List<QnaVO> getWatingList() {
		return mapper.getWatingList();
	}

	@Override
	public int count(Criteria cri, int board_no) {
		HashMap<String, Integer> hash = new HashMap<>();
		hash.put("board_no", board_no);
		hash.put("pageNum", cri.getPageNum());
		hash.put("amount", cri.getAmount());
		return mapper.count(hash);
	}

	@Override
	public List<BoardVO> getListforAdmin(int board_no, Criteria cri) {
		HashMap<String, Integer> hash = new HashMap<>();
		hash.put("board_no", board_no);
		hash.put("pageNum", cri.getPageNum());
		hash.put("amount", cri.getAmount());
		return mapper.getListforAdmin(hash);
	}
}
