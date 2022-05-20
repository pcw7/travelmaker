drop table board cascade constraints;
create table board (
	bno	NUMBER primary key,						-- 게시글번호	
	title VARCHAR2(50) not null,				-- 제목
	s_date DATE not null,						-- 출발일	
	e_date DATE not null,						-- 도착일	
	loc	VARCHAR2(20) not null,					-- 지역
	content VARCHAR2(1000),						-- 내용
	reg_date DATE not null,						-- 작성일	
	readcount NUMBER default 0 not null,		-- 조회수	
	del	CHAR(1) default 'n' not null,		 	-- 삭제여부	
	mno NUMBER not null							-- 회원번호 
);

-- references member(mno) 

drop table plan cascade constraints;
create table plan (
	plan_no NUMBER primary key,							-- 플랜번호
	plan_date DATE not null,							-- 날짜
	name VARCHAR2(50) not null,							-- 장소이름
	map_x NUMBER not null,								-- 좌표x
	map_y NUMBER not null,								-- 좌표y
	bno	NUMBER references board(bno) not null			-- 게시글번호
);

select * from plan;

drop table review cascade constraints;
create table review ( 
	rno	NUMBER primary key,								-- 리뷰번호
	reply_content VARCHAR2(500) not null,			 	-- 리뷰내용
	reg_date DATE not null,								-- 작성일	
	update_date DATE not null,							-- 수정일	
	del	CHAR(1) default 'n' not null,					-- 삭제여부
	mno NUMBER not null,								-- 회원번호	
	bno	NUMBER references board(bno) not null			-- 게시글번호
);

-- references member(mno)

drop table reviewphoto cascade constraints;
create table reviewphoto (
	rpno NUMBER primary key,							-- 리뷰사진번호
	mno NUMBER not null,								-- 회원번호
	rno NUMBER references review(rno) not null,			-- 리뷰번호
	imgName varchar2(50)								-- 이미지이름
);

-- references member(mno)

drop sequence reviewphoto_seq;
create sequence reviewphoto_seq;

drop table member cascade constraints;
create table member (
	mno number primary key,          -- 회원번호
	id varchar2(20) not null,        -- 아이디
	password varchar2(300) not null, -- 비밀번호
	name varchar2(20) not null,      -- 이름
	email varchar2(50) not null,     -- 이메일
	tel varchar2(20) not null,       -- 전화번호
	nickName varchar2(20) not null,  -- 별명
	reg_date date not null,          -- 가입일
	del char(1) default 'n' not null -- 탈퇴여부
)

drop sequence seq_member_mno;
create sequence seq_member_mno;

select * from board;
select * from review;
select * from reviewphoto;
select * from member;

insert into review values (1,'야',sysdate,sysdate,'n',1,2);
