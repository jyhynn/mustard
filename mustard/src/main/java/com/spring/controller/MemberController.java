package com.spring.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.domain.BoardVO;
import com.spring.domain.LogOnVO;
import com.spring.domain.MemberVO;
import com.spring.domain.ScrapVO;
import com.spring.domain.ZipVO;
import com.spring.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/member/*")
@SessionAttributes("log")
public class MemberController {

	@Autowired
	private MemberService service;
	
	@RequestMapping("/register")
	public void showRegister(@ModelAttribute("email")String email) {
		log.info("regist page 나와라");
	}
	
	@PostMapping("/dupEmail")
	@ResponseBody
	public String dupEmail(String email) {
		log.info("이메일 중복체크");
		String str = "notexist";
		MemberVO vo = service.checkEmail(email);
		if(vo!=null) {
			str = "exist";	//사용불가
		}
		return str;
	}
	
	@PostMapping("/checkEmail")
	@ResponseBody
	public String checkemail(MemberVO vo) throws Exception {
		log.info("이메일 인증 요청");
		//중복검사먼저
		String str = "notexist";
		MemberVO check = service.checkEmail(vo.getEmail());
		if(check!=null) {
			if(check.getAuthstatus()==1) {
				str = "exist";	//사용불가
			}else if(check.getAuthstatus()==0) {
				str = "notyetauth";
			}
			return str;
		}else {
			service.checkMail(vo);
			log.info("이메일 인증 요청 성공");
			return "requestCheckEmailSuccess";
		}
	}
	
	@RequestMapping("/emailConfirm")
	public String emailConfirm(MemberVO vo, RedirectAttributes rttr) throws Exception {
		log.info("메일인증확인");
		vo.setAuthstatus(1);	// authstatus를 1로,, 권한 업데이트
		int result = service.updateAuthstatus(vo);
		if(result>0) {
			vo = service.getEmail(vo.getMemNo());
			log.info("메일인증확인완료");
			rttr.addFlashAttribute("email", vo.getEmail());
		}
		return "redirect:register";
	}
	
	@PostMapping("/reigstMember")
	public String registMember(MemberVO vo) {
		log.info("회원가입요청");
		if(vo.getNick()==null) {
			vo.setNick("익명");
		}
		service.registMember(vo);
		return "redirect:signin";
	}
	
	@RequestMapping("/signin")
	public String showSignin(String error) {
		log.info("signin page 나와라");
		return "/member/signin";
	}
	
	@PostMapping("/signin")
	public String goSignin(MemberVO vo, RedirectAttributes rttr,Model model, HttpSession session) {
		log.info("로그인하러 가요~~");
			//session.invalidate();	//게스트모드 세션 삭제(위치정보 담겨있음)
			LogOnVO logon = service.signin(vo);
			if(logon==null) {
				log.info("로그인실패");
				rttr.addFlashAttribute("error", "LogFailed");
				//rttr.addFlashAttribute("error", "LogFailed");
				return "/member/signin";
			}else {
				model.addAttribute("log", logon);				
				rttr.addAttribute("shi", logon.getZip().getShi());
				rttr.addAttribute("gungu", logon.getZip().getGungu());
				rttr.addAttribute("dong", logon.getZip().getDong());
				
				return "redirect:/boardMain";
			}	
	}
	
	@GetMapping("/forgot")
	public void forgot() {
		
	}
	
	@GetMapping("/signout")
	public String signout(MemberVO vo, Model model, HttpSession session) {
		log.info("로그아웃~");
		session.invalidate();
		return "redirect:/home";
	}
	
	@GetMapping("/mypage/mylist")
	public void myList(int memNo, int mylistno, Model model) {
		List<BoardVO> list = new ArrayList<>();
		if(mylistno==1) {	// 내가쓴글
			list = service.getIWrote(memNo);
		}else if(mylistno==2){	//댓글단글
			list = service.getMyReplies(memNo);
		}else if(mylistno==3) {	//스크랩글
			list = service.getScraps(memNo);
		}
		model.addAttribute("mylist", list);	
		model.addAttribute("mylistno", mylistno);
		model.addAttribute("memNo", memNo);
	}
	
	@GetMapping("/mypage/myInfo")
	public void myInfo() {}
	
	@GetMapping("/mypage/changeMyInfo")
	public void changeMyInfo() {}
	
	@PostMapping("/changePwd")
	@ResponseBody
	public String changePwd(int memNo, String newPassword, HttpSession session) {
		log.info("새비번 : " + newPassword);
		String str = "";
		if(service.changePwd(memNo, newPassword)==1) {
			session.invalidate();
			str = "changeSuccess";
		}else {
			str = "changeFail";
		}
		return str;
	}
	
	@PostMapping("/changeLoc")
	@ResponseBody
	public String changeLoc(int memNo, ZipVO zip, String email, String password, HttpSession session) {
		String str = "";
		if(service.changeLoc(memNo, zip)==1) {
			MemberVO vo = new MemberVO();
			vo.setEmail(email);
			vo.setPassword(password);
			LogOnVO logon = service.signin(vo);
			str = "changeSuccess";
			session.removeAttribute("log");
			session.setAttribute("log", logon);
		}else {
			str = "changeFail";
		}
		return str;
	}
	
	@GetMapping("/mypage/removeMember")
	public void removeMemberPage() {}
	
	@PostMapping("/removeMember")
	@ResponseBody
	public String removeMember(int memNo, String reason, HttpSession session) {
		String str = "";		
		if(service.removeMember(memNo)==1) {
			session.invalidate();
			str = "removeSuccess";
		}else {
			str = "removeFail";
		}
		return str; 
	}
}
