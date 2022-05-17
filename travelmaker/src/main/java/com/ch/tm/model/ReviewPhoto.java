package com.ch.tm.model;

import lombok.Data;

@Data
public class ReviewPhoto {
	private int rpno;
	private int mno;
	private int rno;
	private String imgName;
	
	private Review review = new Review();
}
