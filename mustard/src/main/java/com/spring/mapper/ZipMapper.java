package com.spring.mapper;

import java.util.List;

import com.spring.domain.ZipVO;

public interface ZipMapper {
	public List<ZipVO> getShi();
	public List<ZipVO> getGungu(String shi);
	public List<ZipVO> getDong(ZipVO vo);
	public ZipVO getZip(ZipVO vo);
}
