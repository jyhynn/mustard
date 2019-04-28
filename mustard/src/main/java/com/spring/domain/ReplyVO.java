package com.spring.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyVO {
	private int reNo, board_no, article_no, memNo, likey, report;
	private String reply, writer;
	private Date replyDate;
}
