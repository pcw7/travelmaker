package com.ch.tm.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ch.tm.dao.MemberDao;
import com.ch.tm.model.Member;

@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	private MemberDao md;
	
	@Override
	public Member select(String id) {
		return md.select(id);
	}

	@Override
	public int insert(Member member) {
		return md.insert(member);
	}

	@Override
	public Member selectNickName(String nickName) {
		return md.selectNickName(nickName);
	}

	@Override
	public Member selectFindId(Member member) {
		return md.selectFindId(member);
	}

	@Override
	public Member selectFindPw(Member member) {
		return md.selectFindPw(member);
	}

	@Override
	public int updatePw(Member member) {
		return md.updatePw(member);
	}

	@Override
	public int update(Member member) {
		return md.update(member);
	}

	@Override
	public int delete(String id) {
		return md.delete(id);
	}

}
