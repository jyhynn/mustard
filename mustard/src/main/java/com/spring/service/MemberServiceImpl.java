package com.spring.service;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.domain.BoardVO;
import com.spring.domain.LogOnVO;
import com.spring.domain.MailUtils;
import com.spring.domain.MemberVO;
import com.spring.domain.ScrapVO;
import com.spring.domain.TempKey;
import com.spring.domain.ZipVO;
import com.spring.mapper.BoardMapper;
import com.spring.mapper.MemberMapper;
import com.spring.mapper.ReplyMapper;
import com.spring.mapper.ZipMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("member")
public class MemberServiceImpl implements MemberService{

	@Inject
	private JavaMailSender mailSender;
	@Autowired
	private MemberMapper mapper;
	@Autowired
	private ZipMapper zipMapper;
	@Autowired
	private BoardMapper boardMapper;
	@Autowired
	private ReplyMapper replyMapper;
	
	@Override
	@Transactional
	public void checkMail(MemberVO email) throws Exception {
		
		//db에 회원번호와 이메일 먼저 등록
		email.setPassword("1111");
		email.setName("username");
		mapper.registEmail(email);
		MemberVO vo = mapper.getMno(email.getEmail());
		// 임의의 authkey 생성
		String authkey = new TempKey().getKey(50, false);
		//db에 authkey 부여
		vo.setAuthkey(authkey);
		mapper.updateAuthKey(vo);
		
		//보낼 mail내용 
		MailUtils sendMail = new MailUtils(mailSender);

		sendMail.setSubject("[Mustard] 회원가입 이메일 인증");
		sendMail.setText(new StringBuffer().append("<h1>[이메일 인증]</h1>")
				.append("<p>아래 링크를 클릭하시면 이메일 인증이 완료됩니다.</p>")
				.append("<a href='http://localhost:8083/member/emailConfirm?memNo=")
				.append(vo.getMemNo())
				.append("&authkey=")
				.append(authkey)
				.append("' target='_blenk'>이메일 인증 확인</a>")
				.toString());
		sendMail.setFrom("mustard ", "MUSTARD");
		sendMail.setTo(vo.getEmail());
		sendMail.send();
	}

	@Override
	public int updateAuthstatus(MemberVO vo) {
		return mapper.updateAuthstatus(vo);
	}

	@Override
	public MemberVO getEmail(int memNo) {
		return mapper.getEmail(memNo);
	}

	@Override
	public int registMember(MemberVO vo) {
		//선택지역코드 zip에서 불러와서 member에 넣기
		ZipVO zip = new ZipVO();
		zip.setShi(vo.getShi());
		zip.setGungu(vo.getGungu());
		zip.setDong(vo.getDong());;
		int code = zipMapper.getZip(zip).getCode();
		vo.setCode((long)code);
		return mapper.registMember(vo);
	}

	@Override
	public MemberVO checkEmail(String email) {
		return mapper.checkEmail(email);
	}

	@Override
	public LogOnVO signin(MemberVO vo) {
		return mapper.signin(vo);
	}
	
	@Override
	public List<BoardVO> getScraps(int memNo) {
		HashMap<String, Integer> hash = new HashMap<>();
		hash.put("memNo", memNo);
		List<ScrapVO> scarpList = boardMapper.getScraps(memNo);
		List<BoardVO> list = new ArrayList<>();
		for(ScrapVO scrap : scarpList) {
			BoardVO boardvo = new BoardVO();
			hash.put("board_no", scrap.getBoard_no());
			hash.put("article_no",scrap.getArticle_no());
			boardvo = boardMapper.getScrapOne(hash);
			list.add(boardvo);
		}
		return list;
	}
	
	@Override
	public List<BoardVO> getIWrote(int memNo) {
		return boardMapper.getIWrote(memNo);
	}
	
	@Override
	public List<BoardVO> getMyReplies(int memNo) {
		return replyMapper.getMyReplies(memNo);
	}
}
