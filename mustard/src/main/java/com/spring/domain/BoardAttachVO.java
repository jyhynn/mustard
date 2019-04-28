package com.spring.domain;

import lombok.Data;

@Data
public class BoardAttachVO {
	
	private String uuid, uploadPath, fileName;
	private boolean fileType;
	private int article_no, board_no;
}
