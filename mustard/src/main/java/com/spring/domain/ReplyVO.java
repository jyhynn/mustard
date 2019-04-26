package com.spring.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyVO {
	private int reNo, board_no, notice_no, memNo;
	private String reply, writer;
	private Date replyDate;
}
