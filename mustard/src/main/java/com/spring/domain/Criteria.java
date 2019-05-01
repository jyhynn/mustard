package com.spring.domain;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class Criteria {
	private int pageNum, amount, board_no;
	private String keyword; // 검색

	public Criteria() {
		this(1, 10); // page1 띄우고 10개씩 보여줄것
	}

	public Criteria(int pageNum, int amount) {
		super();
		this.pageNum = pageNum;
		this.amount = amount;
	}

	/*public String[] getTypeArr() {
		return type == null ? new String[] {} : type.split("");
	}*/
}
