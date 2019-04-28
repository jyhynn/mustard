package com.spring.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {
	private int startPage, endPage;
	private boolean prev, next;
	private int total;
	private Criteria cri;
	
	public PageDTO(Criteria cri, int total) {
		this.total = total;
		this.cri = cri;
		
		//endPage 계산
		this.endPage = (int)(Math.ceil(cri.getPageNum()/10.0))*10;
		//startPage 계산
		this.startPage = this.endPage-9;
		
		//endPage가 totalPage를 넘어가지 못하도록 계산
		int realEnd = (int)(Math.ceil((this.total/1.0)/cri.getAmount()));
		if(realEnd<this.endPage) {
			this.endPage = realEnd;
		}
		
		this.prev = this.startPage > 1;
		this.next = this.endPage < realEnd;
	
	}
}
