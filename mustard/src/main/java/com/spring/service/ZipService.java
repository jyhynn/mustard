package com.spring.service;

import java.util.List;

import com.spring.domain.ZipVO;

public interface ZipService {
	public List<ZipVO> getShi();
	public List<ZipVO> getGungu(String shi);
	public List<ZipVO> getDong(ZipVO vo);
}
