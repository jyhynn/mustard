package com.spring.mapper;

import java.util.HashMap;
import java.util.List;

import com.spring.domain.BoardNoticeVO;

public interface BoardNoticeMapper {

	public List<BoardNoticeVO> getList(int board_no); 
	public BoardNoticeVO getNotice(HashMap<String, Integer> hash);
	public int insert(BoardNoticeVO notice);
	public int update(BoardNoticeVO notice);
	public int delete(int notice_no, int board_no);
}
