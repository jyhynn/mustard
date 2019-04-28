package com.spring.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemberVO {
	private int memNo, memlevel, memreport;
	private String email, name, nick, password;
	private long code;
	private String authkey;
	private int authstatus;
	private String shi, gungu, dong;
	private Date regdate;
	private List<MemberAuthVO> authList;
}
