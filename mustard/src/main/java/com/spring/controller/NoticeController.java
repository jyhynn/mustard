package com.spring.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.domain.AttachNoticeVO;
import com.spring.domain.BoardNoticeVO;
import com.spring.domain.BoardVO;
import com.spring.domain.Common;
import com.spring.domain.Paging;
import com.spring.service.BoardNoticeService;
import com.spring.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/board/*")
public class NoticeController {

	@Autowired
	BoardNoticeService service;
	@Autowired
	MemberService memberService;

	@RequestMapping("/noticeList")
	public String noticelist(Model model, String page) {
		log.info("공지사항 페이지 나와라");
		int nowPage = 1;
		if (page != null && !page.isEmpty()) {	
			nowPage = Integer.parseInt(page);
		} else {
			page = "1";
		}
		int row_total = service.countPage();
		String pageMenu = Paging.getPaging("/board/noticeList", nowPage, row_total,Common.Reply.BLOCKLIST, Common.Reply.BLOCKPAGE);
		model.addAttribute("page", page);
		model.addAttribute("pageMenu", pageMenu);
		List<BoardNoticeVO> list = service.getList();
		model.addAttribute("notice", list);
		return "/board/noticeList";
	}
	
	@RequestMapping("/getAttachs")
	@ResponseBody
	public List<AttachNoticeVO> getAttachs(){
		//첨부파일 전체목록
		List<AttachNoticeVO> attachList = service.getAttachs();
		//첨부파일 썸네일 경로만 편집해서 다시 리스트화
		List<AttachNoticeVO> filepath = new ArrayList<>();
		for(AttachNoticeVO attach : attachList) {
			AttachNoticeVO vo = new AttachNoticeVO();
			vo.setNotice_no(attach.getNotice_no());
			//uploadPath에는 확장자명까지 완전경로 들어가게됨
			vo.setUploadPath(attach.getUploadPath() + "\\thum_" + attach.getUuid() + "_" + attach.getFileName());
			filepath.add(vo);
		}
		return filepath;
	}

	@RequestMapping(value= {"/noticeRead", "noticeModify"})
	public void noticeRead(int notice_no, int board_no, Model model) {
		log.info(notice_no + "번째 공지사항 읽기 나와라");
		BoardNoticeVO notice = service.getNotice(notice_no, board_no);
		model.addAttribute("notice", notice);
	}
	
	@RequestMapping("/getAttachList")
	@ResponseBody
	public List<AttachNoticeVO> getAttList(int notice_no, int board_no) {
		List<AttachNoticeVO> list = service.attachList(notice_no, board_no);
		return list;
	}
	
	@RequestMapping("/noticeWrite")
	public void noticeWriteForm() {
		log.info("공지사항 글쓰기 폼 나와라");
	}

	@PostMapping("/noticeWrite")
	public String noticeWrite(BoardNoticeVO notice, RedirectAttributes rttr) {
		log.info("글 등록해줘라");
		service.insert(notice);
		rttr.addFlashAttribute("msg", "success");
		return "redirect:noticeList";
	}
	
	@PostMapping("/noticeModify")
	public String noticeUpdate(@ModelAttribute("notice")BoardNoticeVO notice, RedirectAttributes rttr) {
		//제목, 글번호 , 글쓴닉, 글쓴회원번호, 내용, 첨부파일들
		service.update(notice);
		if (notice.getNoticeAttach() != null) {
			for (AttachNoticeVO attach : notice.getNoticeAttach()) {
				log.info(" 첨부파일목록 : " + attach);
			}
		}
		rttr.addAttribute("notice_no", notice.getNotice_no());
		return "redirect:noticeRead";
	}
	
	@PostMapping("/remove")
	public String remove(int notice_no, int board_no, RedirectAttributes rttr) {
		
		//첨부된 파일 폴더에서 삭제하기
		List<AttachNoticeVO> attachList = service.attachList(notice_no,board_no);
		if(service.delete(notice_no,board_no)==1) {
			deleteFile(attachList);
			rttr.addFlashAttribute("result","success");
		}
		return "redirect:getAttachList";
	}
	
	// 첨부파일 삭제
		private void deleteFile(List<AttachNoticeVO> attach) {
			// type이 image라면 썸네일과 원본파일 삭제
			// type이 file이라면 원본파일만 삭제
			log.info("첨부파일 삭제요청...");
			if(attach.size()==0 || attach==null) {
				return;
			}
			for(AttachNoticeVO vo : attach) {
				Path file = Paths.get("d:\\upload\\" + vo.getUploadPath() + "\\" + vo.getUuid() + "_" + vo.getFileName());
			
				try {
					//일반파일 및 원본파일 삭제
					Files.deleteIfExists(file);
					
					//이미지 파일인 경우 썸네일 삭제
					if(Files.probeContentType(file).startsWith("image")) {
						Path thumbNail = Paths.get("d:\\upload\\"+vo.getUploadPath() + "\\thum_" + vo.getUuid() + "_" + vo.getFileName());
						Files.deleteIfExists(thumbNail);
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
}
