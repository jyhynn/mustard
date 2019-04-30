package com.spring.domain;

import java.util.Date;

import lombok.Data;

@Data
public class QnaVO {
	private int qna_no, board_no, memNo, classify;
	private String title, writer, content;
	private Date qna_date;
}
