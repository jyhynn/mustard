package com.spring.mapper;

import com.spring.domain.LogOnVO;
import com.spring.domain.MemberVO;

public interface MemberMapper {

	public int registEmail(MemberVO vo);
	public MemberVO getMno(String email);		
	public int updateAuthKey(MemberVO vo);		//이메일인증키 부여
	public int updateAuthstatus(MemberVO vo);	//이메일인증확인
	public MemberVO getEmail(int memNo);
	public int registMember(MemberVO vo);
	public MemberVO checkEmail(String email);	//이메일 중복체크시
	public LogOnVO signin(MemberVO vo);		//로그인
	public int report(int memNo);
	public MemberVO read(String email);
}
