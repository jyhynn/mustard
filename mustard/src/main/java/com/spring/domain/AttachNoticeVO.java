package com.spring.domain;

import lombok.Data;

@Data
public class AttachNoticeVO {
	
	private String uuid, uploadPath, fileName;
	private boolean fileType;
	private int notice_no;
}
