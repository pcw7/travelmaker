package com.ch.tm.model;

import java.sql.Date;

import lombok.Data;

@Data
public class Member {
	private int mno;          // 회원번호
	private String id;        // 아이디
	private String password;  // 비밀번호
	private String name;      // 이름
	private String email;     // 이메일
	private String tel;       // 전화번호
	private String nickName;  // 별명
	private Date reg_date;    // 가입일
	private String del;       // 탈퇴여부
}
