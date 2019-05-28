package com.spring.mapper;

import java.util.HashMap;
import java.util.List;

import com.spring.domain.BoardNoticeVO;
import com.spring.domain.BoardVO;
import com.spring.domain.QnaVO;
import com.spring.domain.ScrapVO;

public interface BoardMapper {

	public List<BoardVO> getList(HashMap<String, Object> hash); 
	public List<BoardVO> getListforMain(HashMap<String, Object> hash); 
	public List<BoardVO> getListforAdmin(HashMap<String, Integer> hash); 
	public BoardVO getBoard(HashMap<String, Integer> hash);
	public int insert(BoardVO board);
	public int update(BoardVO board);
	public int delete(HashMap<String, Integer> hash);
	public int countPage(HashMap<String, Object> hash);
	public int count(HashMap<String, Integer> hash);
	public int report(HashMap<String, Integer> hash);
	public List<BoardVO> getReported();
	public int updateReplyCnt(HashMap<String, Integer> hash);
	public int updateReadhit(HashMap<String, Integer> hash);
	public int likey(HashMap<String, Integer> hash);
	public int getLikeyamount(HashMap<String, Integer> hash);
	public int scrap(HashMap<String, Integer> hash);
	public BoardVO getScrapOne(HashMap<String, Integer> hash);
	public List<ScrapVO> getScraps(int memNo);
	public List<BoardVO> getIWrote(int memNo);
	public int updateReplyDeleted(HashMap<String, Integer> hash);
	public int getAllList(HashMap<String, Object> hash);
	public List<BoardVO> getListPaging(HashMap<String, Object> hash);
	//문의게시판
	public List<QnaVO> getQnaList();
	public int getQnaAmount();
	public QnaVO getAsk(int qna_no);
	public int insertQna(QnaVO qna);
	public int updateQna(QnaVO qna);
	public int deleteAsk(int qna_no);
	public List<QnaVO> getWatingList();
	public int getWatingAmount();
	public int updateAnswer(int qna_no);
	//실시간 인기글
	public List<BoardVO> getTrends(); 
	//검색
	public List<BoardVO> searching(HashMap<String, Object> hash);
	public int searchList(HashMap<String, Object> hash);
}
