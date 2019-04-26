package com.spring.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.domain.AttachNoticeVO;
import com.spring.domain.BoardNoticeVO;
import com.spring.domain.MemberVO;
import com.spring.mapper.AttachMapper;
import com.spring.mapper.BoardNoticeMapper;
import com.spring.mapper.MemberMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("boardNotice")
public class BoardNoticeServiceImpl implements BoardNoticeService{
	
	@Autowired
	private BoardNoticeMapper mapper;
	@Autowired
	private AttachMapper attachMapper;
	@Autowired
	private MemberMapper memberMapper;
	
	@Override
	public List<BoardNoticeVO> getList(int board_no) {
		return mapper.getList(board_no);
	}
	
	@Override
	public BoardNoticeVO getNotice(int notice_no, int board_no) {
		HashMap<String, Integer> hash = new HashMap<>();
		hash.put("notice_no", notice_no);
		hash.put("board_no", board_no);
		return mapper.getNotice(hash);
	}

	@Transactional
	@Override
	public void insert(BoardNoticeVO notice) {
		mapper.insert(notice);
		if(notice.getNoticeAttach()==null || notice.getNoticeAttach().size()<=0) {
			return;
		}
		notice.getNoticeAttach().forEach(attach -> {
			attach.setNotice_no(notice.getNotice_no());
			attachMapper.insert(attach);
		});
	}

	@Override
	public List<AttachNoticeVO> attachList(int notice_no, int board_no) {
		HashMap<String, Integer> hash = new HashMap<>();
		hash.put("notice_no", notice_no);
		hash.put("board_no", board_no);
		return attachMapper.findByNo(hash);
	}

	@Transactional
	@Override
	public int update(BoardNoticeVO notice) {
		HashMap<String, Integer> hash = new HashMap<>();
		hash.put("notice_no", notice.getNotice_no());
		hash.put("board_no", notice.getBoard_no());
		attachMapper.delete(hash);
		int modifyResult = mapper.update(notice);
		
		if(notice.getNoticeAttach()==null || notice.getNoticeAttach().size()<=0) {
			return 0;
		}
		if(modifyResult==1 && notice.getNoticeAttach().size()>=0) {
			notice.getNoticeAttach().forEach(attach->{
				attach.setNotice_no(notice.getNotice_no());
				attachMapper.insert(attach);
			});
			return 0;
		}
		return mapper.update(notice);
	}

	@Override
	public int delete(int notice_no, int board_no) {
		HashMap<String, Integer> hash = new HashMap<>();
		hash.put("notice_no", notice_no);
		hash.put("board_no", board_no);
		attachMapper.delete(hash);
		return mapper.delete(notice_no, board_no);
	}

	@Override
	public List<AttachNoticeVO> getAttachs() {
		return attachMapper.getAttachs();
	}

}
