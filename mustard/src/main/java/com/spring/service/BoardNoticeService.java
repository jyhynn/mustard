package com.spring.service;

import java.util.List;

import com.spring.domain.BoardNoticeVO;

public interface BoardNoticeService {

	public List<BoardNoticeVO> getList(); 
	public BoardNoticeVO getNotice(int notice_no);
	public void insert(BoardNoticeVO notice);
}
