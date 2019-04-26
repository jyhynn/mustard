package com.spring.mapper;

import java.util.HashMap;
import java.util.List;

import com.spring.domain.AttachNoticeVO;

public interface AttachMapper {
	
	public int insert(AttachNoticeVO attach);
	public List<AttachNoticeVO> findByNo(HashMap<String, Integer> hash);
	public int delete(HashMap<String, Integer> hash);
	public List<AttachNoticeVO> getOldFiles();
	public List<AttachNoticeVO> getAttachs();
}
