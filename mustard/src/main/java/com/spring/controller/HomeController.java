package com.spring.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.domain.BoardNoticeVO;
import com.spring.domain.ZipVO;
import com.spring.service.ZipService;

import lombok.extern.slf4j.Slf4j;

/**
 * Handles requests for the application home page.
 */
@Slf4j
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	@Inject
	private ZipService service;

	@RequestMapping("/")
	public String boardMain(@ModelAttribute("zip")ZipVO zip) {
		return "boardMain";
	}
		
	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		log.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
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

	/*@RequestMapping("/testing")
	public void testing() {
		log.info("testing 나와라");
	}*/
	
	@RequestMapping("/main_notice")
	@ResponseBody
	public List<BoardNoticeVO> main_notice() {
		
		return null;
	}
}
