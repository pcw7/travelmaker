package com.ch.tm.model;

import java.sql.Date;

import lombok.Data;

@Data
public class Plan {
	private int plan_no;     // 플랜번호
	private Date plan_date;  //날짜
	private String name;     //장소이름
	private float map_x;     // 좌표x
	private float map_y;     // 좌표y
	private int bno;         // 게시글번호

}
