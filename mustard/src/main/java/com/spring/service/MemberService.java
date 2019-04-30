package com.spring.service;

import java.util.List;

import com.spring.domain.BoardVO;
import com.spring.domain.Criteria;
import com.spring.domain.LogOnVO;
import com.spring.domain.MemberVO;
import com.spring.domain.ZipVO;

public interface MemberService {
	
	public void checkMail(MemberVO vo)  throws Exception;
	public int updateAuthstatus(MemberVO vo);
	public MemberVO getEmail(int memNo);
	public int registMember(MemberVO vo);
	public MemberVO checkEmail(String email);	//이메일 중복체크시
	public LogOnVO signin(MemberVO vo);		//로그인
	public List<BoardVO> getScraps(int memNo);
	public List<BoardVO> getIWrote(int memNo);
	public List<BoardVO> getMyReplies(int memNo);
	public int changePwd(int memNo, String newpassword);
	public int changeLoc(int memNo, ZipVO zip);
	public int removeMember(int memNo);
	public List<MemberVO> getAllMembers();
	public int countPage(Criteria cri);
	public List<MemberVO> memberReported();
	public int controlDown(int memNo);
	public int controlUp(int memNo);
}
