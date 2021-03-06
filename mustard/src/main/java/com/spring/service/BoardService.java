package com.spring.service;

import java.util.HashMap;
import java.util.List;

import com.spring.domain.BoardAttachVO;
import com.spring.domain.BoardVO;
import com.spring.domain.QnaVO;
import com.spring.domain.ZipVO;

public interface BoardService {

	public List<BoardVO> getList(int board_no, ZipVO zip); 
	public List<BoardVO> getListforMain(int board_no, ZipVO zip); 
	public List<BoardVO> getListforAdmin(int board_no); //관리자페이지용 게시물 리스트
	public BoardVO getBaord(int article_no, int board_no);
	public void insert(BoardVO board);
	public int update(BoardVO board);
	public int delete(int article_no, int board_no);
	public int report(int article_no, int board_no, int memNo);
	public List<BoardVO> getReported();
	public int likey(int article_no, int board_no);
	public int getLikeyamount(int article_no, int board_no);
	public int scrap(int article_no, int board_no, int memNo);
	//첨부파일 목록
	public List<BoardAttachVO> attachList(int notice_no, int board_no);
	public List<BoardAttachVO> getAttachs();
	//페이지 카운팅
	public int getAllList(int board_no, ZipVO zip);
	public List<BoardVO> getListPaging(int nowPage, int board_no, long code);
	public int count(int board_no);
	public int countPage(int board_no, ZipVO zip);
	public int updateReadhit(int article_no, int board_no);
	//문의게시판
	public List<QnaVO> getQnaList();
	public int getQnaAmount();
	public QnaVO getAsk(int qna_no);
	public int insertQna(QnaVO qna);
	public int updateQna(QnaVO qna);
	public int deleteAsk(int qna_no);
	public List<QnaVO> getWatingList();
	public int getWatingAmount();
	//실시간 인기글
	public List<BoardVO> getTrends(); 
	//검색
	public List<BoardVO> searching(int board_no, String keyword, ZipVO zip, int nowPage);
	public int searchList(int board_no, String keyword, ZipVO zip);
}
