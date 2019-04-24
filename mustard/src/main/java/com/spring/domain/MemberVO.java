package com.spring.domain;

import lombok.Data;

@Data
public class MemberVO {
	private int memNo;
	private String email, name, nick, password;
	private long code;
	private String authkey;
	private int authstatus;
	private String shi, gungu, dong;
}
