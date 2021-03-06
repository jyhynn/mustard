package com.spring.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.domain.BoardNoticeVO;
import com.spring.domain.BoardVO;
import com.spring.domain.ZipVO;
import com.spring.service.BoardNoticeService;
import com.spring.service.BoardService;
import com.spring.service.ZipService;

import lombok.extern.slf4j.Slf4j;

/**
 * Handles requests for the application home page.
 */
@Slf4j
@Controller
public class HomeController {
	
	@Inject
	private ZipService service;
	@Autowired
	private BoardNoticeService noticeService;
	@Autowired
	private BoardService boardService;

	@RequestMapping(value= {"/","/boardMain"})
	public String boardMain(ZipVO zip, Model model, HttpSession session) {
		List<BoardNoticeVO> noticeMain = noticeService.getListforMain();
		log.info(zip.getDong());
		if(zip.getGungu()==null || zip.getShi()==null || zip.getDong()==null) {
			zip.setShi("서울특별시");
			zip.setGungu("중구");
			zip.setDong("을지로1가");
		}
		List<BoardVO> board2 = boardService.getListforMain((int)2, zip);
		List<BoardVO> board3 = boardService.getListforMain((int)3, zip);
		List<BoardVO> board4 = boardService.getListforMain((int)4, zip);
		List<BoardVO> board5 = boardService.getListforMain((int)5, zip);
		model.addAttribute("board2",board2);
		model.addAttribute("board3",board3);
		model.addAttribute("board4",board4);
		model.addAttribute("board5",board5);
		session.setAttribute("guest", zip);
		
		model.addAttribute("noticeMain",noticeMain);
		return "boardMain";
	}
		
	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		log.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "/home";
	}
	
	@RequestMapping("/main")
	public void mainTest() {
		log.info("메인화면 요청");
	}
	
	@RequestMapping("/getShi")
	@ResponseBody
	public List<ZipVO> getShi(){
		List<ZipVO> list = service.getShi();
		return list;
	}  
	@RequestMapping("/getGungu")
	@ResponseBody
	public List<ZipVO> getGungu(String shi){
		List<ZipVO> list = service.getGungu(shi);
		return list;
	}
	@RequestMapping("/getDong")
	@ResponseBody
	public List<ZipVO> getDong(ZipVO vo){
		List<ZipVO> list = service.getDong(vo);
		return list;
	}
	
	@RequestMapping("/mainTest")
	public void mainTest2() {
		log.info("메인화면 요청");
	}

}
