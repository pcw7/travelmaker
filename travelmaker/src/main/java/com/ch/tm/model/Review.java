package com.ch.tm.model;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class Review {
	private int rno;
	private String reply_content;
	private Date reg_date;	
	private Date update_date;	
	private String del;
	private int mno;	
	private int bno;
	
	// upload용
	// private MultipartFile file;
	
	// join용
	private String nickName;
}
