package com.spring.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class BoardNoticeVO {
	private int notice_no;
	private String title, writer, content;
	private Date notice_date, notice_updatedate;
	
	private List<AttachNoticeVO> noticeAttach;
}
