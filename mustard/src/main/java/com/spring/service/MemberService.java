package com.spring.service;

import com.spring.domain.MemberVO;

public interface MemberService {
	
	public void checkMail(MemberVO vo)  throws Exception;
	public int updateAuthstatus(MemberVO vo);
	public MemberVO getEmail(int memNo);
	public int registMember(MemberVO vo);
	public MemberVO checkEmail(String email);	//이메일 중복체크시
	public MemberVO signin(MemberVO vo);		//로그인
}
