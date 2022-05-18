package com.ch.tm.dao;

import com.ch.tm.model.Member;

public interface MemberDao {

	Member select(String id);

	int insert(Member member);

	Member selectNickName(String nickName);

	Member selectFindId(Member member);

	Member selectFindPw(Member member);

	int updatePw(Member member);

	int update(Member member);

	int delete(String id);

}
