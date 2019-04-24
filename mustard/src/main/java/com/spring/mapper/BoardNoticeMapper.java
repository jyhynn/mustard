package com.spring.mapper;

import java.util.List;

import com.spring.domain.BoardNoticeVO;

public interface BoardNoticeMapper {

	public List<BoardNoticeVO> getList(); 
	public BoardNoticeVO getNotice(int notice_no);
	public int insert(BoardNoticeVO notice);
}
