package com.spring.mapper;

import java.util.HashMap;
import java.util.List;

import com.spring.domain.BoardAttachVO;

public interface BoardAttachMapper {
	
	public int insert(BoardAttachVO attach);
	public List<BoardAttachVO> findByNo(HashMap<String, Integer> hash);
	public int delete(HashMap<String, Integer> hash);
	public List<BoardAttachVO> getOldFiles();
	public List<BoardAttachVO> getAttachs();
}
