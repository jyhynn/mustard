package com.spring.mapper;

import java.util.List;

import com.spring.domain.AttachNoticeVO;

public interface AttachMapper {
	
	public int insert(AttachNoticeVO attach);
	public List<AttachNoticeVO> findByNo(int notice_no);
	public int delete(int notice_no);
	public List<AttachNoticeVO> getOldFiles();
	
}
