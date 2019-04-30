package com.spring.domain;

import lombok.Data;

@Data
public class LogOnVO {
	private long code;
	private int memNo, memlevel;
	private String nick, password, email;
	private ZipVO zip;
}
