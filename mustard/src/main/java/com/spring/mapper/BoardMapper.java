package com.spring.mapper;

import java.util.HashMap;
import java.util.List;

import com.spring.domain.BoardNoticeVO;
import com.spring.domain.BoardVO;
import com.spring.domain.ScrapVO;

public interface BoardMapper {

	public List<BoardVO> getList(HashMap<String, Integer> hash); 
	public BoardVO getBoard(HashMap<String, Integer> hash);
	public int insert(BoardVO board);
	public int update(BoardVO board);
	public int delete(HashMap<String, Integer> hash);
	public int countPage(HashMap<String, Integer> hash);
	public int report(HashMap<String, Integer> hash);
	public int updateReplyCnt(HashMap<String, Integer> hash);
	public int updateReadhit(HashMap<String, Integer> hash);
	public int likey(HashMap<String, Integer> hash);
	public int getLikeyamount(HashMap<String, Integer> hash);
	public int scrap(HashMap<String, Integer> hash);
	public ScrapVO getScrapOne(HashMap<String, Integer> hash);
}
