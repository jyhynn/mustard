package com.spring.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.domain.AttachNoticeVO;

import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnailator;

@Slf4j
@Controller
public class AjaxUploadController {
	
	@GetMapping("/uploadAjax")
	public void uploadAjax() {
		log.info("uploadAjaxForm 페이지 호출");
	}
	
	@PostMapping(value="/uploadAjax", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachNoticeVO>> uploadAjaxPost(MultipartFile[] uploadFile){
		log.info("ajax 파일 업로드 요청");
		
		String uploadForder = "d:\\upload";
		// 년/월/일 폴더 형태로 가져오기
		String uploadFolderPath = getFoler();
		File uploadPath = new File(uploadForder, uploadFolderPath);
		
		//폴더가 없으면 새로 생성하기
		if(!uploadPath.exists()) {
			uploadPath.mkdirs();
		}
		
		List<AttachNoticeVO> attList = new ArrayList<AttachNoticeVO>();
		String uploadFileName = "";
		
		for(MultipartFile f : uploadFile) {
			log.info("--------------------");
			log.info("File Name : " + f.getOriginalFilename());
			log.info("File Size : " + f.getSize());
			
			//uuid붙여서 저장
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString() + "_" + f.getOriginalFilename();
			File saveFile = new File(uploadPath,uploadFileName);
			
			//현재 파일의 저장경로와 파일명, 이미지 여부, uuid 값을 담는 객체 생성
			AttachNoticeVO attach = new AttachNoticeVO();
			attach.setUuid(uuid.toString());
			attach.setUploadPath(uploadFolderPath);
			attach.setFileName(f.getOriginalFilename());
			
			if(checkImageType(saveFile)) {
				attach.setFileType(true);
				// 썸네일작업하기
				try {
																						//s_를 붙여서 한번 더 저장해 썸네일이미지를 표시
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath,"s_"+uploadFileName));
					Thumbnailator.createThumbnail(f.getInputStream(),thumbnail,100,100);
					thumbnail.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
			// 파일저장
			try {
				f.transferTo(saveFile);
				attList.add(attach);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return new ResponseEntity<>(attList,HttpStatus.OK);
	}
	
	//썸네일 이미지를 보여주는 작업
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName){
		log.info("썸네일이미지 가져오기");
		File file = new File("d:\\upload\\" + fileName);
		ResponseEntity<byte[]> result = null;
		HttpHeaders header = new HttpHeaders();
		try {
			header.add("Content-Type", Files.probeContentType(file.toPath())); // probeContentType : MIME(text/html,image/jpeg 이런거) 타입 알아내는 역할
			result = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file),header,HttpStatus.OK);	//서버에 있는 걸 다시 복사해서 받아옴
		} catch (IOException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	//폴더 생성
	private String getFoler() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		return str.replace("-", File.separator);
	}
	
	//파일이 이미지인지 확인하는 메소드
	private boolean checkImageType(File file) {
		try {
			String contentType = Files.probeContentType(file.toPath());
			return contentType.startsWith("image");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	@GetMapping(value="/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody											//@RequestHeader("User-Agent") : web에 f12 > Network의 Header 내용
	public ResponseEntity<Resource> download(String fileName, @RequestHeader("User-Agent")String userAgent){
		log.info("download 요청 : " + fileName);
		
		Resource resource = new FileSystemResource("d:\\upload\\" + fileName);
		
		String resourceName = resource.getFilename();
		resourceName = resourceName.substring(resourceName.lastIndexOf('_')+1);
		HttpHeaders headers = new HttpHeaders();
		
		try {
			String downloadName = null;
			//접속브라우저 판단	Trident : explorer11
			if(userAgent.contains("Trident") || userAgent.contains("Edge")) {
							 //URLEncoder.encode()을 할 때 공백이 있으면 +로 변환시키기 때문에 그걸 찾아서 그냥 공백으로 바꾸기. 공백 유니코드 : %2B <이걸로도 가능		
				downloadName = URLEncoder.encode(resourceName, "UTF-8").replaceAll("\\+", " ");
			}else{
				downloadName = new String(resourceName.getBytes("utf-8"),"ISO-8859-1");
			}
			headers.add("Content-Disposition", "attachment;fileName=" + downloadName);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return new ResponseEntity<>(resource,headers,HttpStatus.OK);
	}
}
