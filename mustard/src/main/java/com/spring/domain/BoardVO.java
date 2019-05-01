package com.spring.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class BoardVO {
	private long code;
	private int board_no, article_no, memNo, replycnt, readhit, likey, report;
	private String title, writer, content;
	private Date notice_date, notice_updatedate;
	private ZipVO zip;
	private List<BoardAttachVO> attach;
}
