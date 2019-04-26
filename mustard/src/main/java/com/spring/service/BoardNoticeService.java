package com.spring.service;

import java.util.HashMap;
import java.util.List;

import com.spring.domain.AttachNoticeVO;
import com.spring.domain.BoardNoticeVO;

public interface BoardNoticeService {

	public List<BoardNoticeVO> getList(int board_no); 
	public BoardNoticeVO getNotice(int notice_no, int board_no);
	public void insert(BoardNoticeVO notice);
	public int update(BoardNoticeVO notice);
	public int delete(int notice_no, int board_no);
	//첨부파일 목록
	public List<AttachNoticeVO> attachList(int notice_no, int board_no);
	public List<AttachNoticeVO> getAttachs();
}
