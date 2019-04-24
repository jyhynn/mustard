package com.spring.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.domain.BoardNoticeVO;
import com.spring.mapper.AttachMapper;
import com.spring.mapper.BoardNoticeMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("boardNotice")
public class BoardNoticeServiceImpl implements BoardNoticeService{
	
	@Autowired
	private BoardNoticeMapper mapper;
	@Autowired
	private AttachMapper attachMapper;
	
	@Override
	public List<BoardNoticeVO> getList() {
		return mapper.getList();
	}

	@Override
	public BoardNoticeVO getNotice(int notice_no) {
		return mapper.getNotice(notice_no);
	}

	@Transactional
	@Override
	public void insert(BoardNoticeVO notice) {
		mapper.insert(notice);
		if(notice.getNoticeAttach()!=null || notice.getNoticeAttach().size()<=0) {
			return;
		}
		notice.getNoticeAttach().forEach(attach -> {
			attach.setNotice_no(notice.getNotice_no());
			attachMapper.insert(attach);
		});
	}

}
