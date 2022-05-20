package com.ch.tm.model;

import java.sql.Date;

import lombok.Data;

@Data
public class Board {
	private int bno;	
	private String title;
	private Date s_date;	
	private Date e_date;	
	private String loc;
	private String content;
	private Date reg_date;	
	private int readcount;	
	private String del;	
	private int mno;
	private String courseImg;
	// paging용
	private int startRow;
	private int endRow;
	// 검색용
	private String search;
	private String keyword;
}
