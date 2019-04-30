package com.spring.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.domain.ZipVO;
import com.spring.mapper.ZipMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("zip")
public class ZipServiceImpl implements ZipService {

	@Autowired
	private ZipMapper mapper;
	
	@Override
	public List<ZipVO> getShi() {
		return mapper.getShi();
	}

	@Override
	public List<ZipVO> getGungu(String shi) {
		return mapper.getGungu(shi);
	}

	@Override
	public List<ZipVO> getDong(ZipVO vo) {
		return mapper.getDong(vo);
	}

	@Override
	public ZipVO getZip(ZipVO vo) {
		return mapper.getZip(vo);
	}

}
