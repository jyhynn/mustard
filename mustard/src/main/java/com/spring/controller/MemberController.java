package com.spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.domain.LogOnVO;
import com.spring.domain.MemberVO;
import com.spring.service.MemberService;

import lombok.extern.slf4j.Slf4j;
import oracle.net.aso.l;

@Slf4j
@Controller
@RequestMapping("/member/*")
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
		log.info("회원가입요청" + vo.getEmail() + vo.getDong());
		service.registMember(vo);
		return "redirect:signin";
	}
	
	@RequestMapping("/signin")
	public void showSignin() {
		log.info("signin page 나와라");
	}
	
	@PostMapping("/goSignin")
	public String goSignin(MemberVO vo, Model model) {
		log.info("로그인하러 가요~~");
		LogOnVO logon = service.signin(vo);
		model.addAttribute("logon",logon);
		return "/";
	}
}
