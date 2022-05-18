package com.ch.tm.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ch.tm.model.Member;
@Repository
public class MemberDaoImpl implements MemberDao {
	@Autowired
	private SqlSessionTemplate sst;
	
	@Override
	public Member select(String id) {
		return sst.selectOne("memberns.select", id);
	}

	@Override
	public int insert(Member member) {
		return sst.insert("memberns.insert", member);
	}

	@Override
	public Member selectNickName(String nickName) {
		return sst.selectOne("memberns.selectNickName", nickName);
	}

	@Override
	public Member selectFindId(Member member) {
		return sst.selectOne("memberns.selectFindId", member);
	}

	@Override
	public Member selectFindPw(Member member) {
		return sst.selectOne("memberns.selectFindPw", member);
	}

	@Override
	public int updatePw(Member member) {
		return sst.update("memberns.updatePw", member);
	}

	@Override
	public int update(Member member) {
		return sst.update("memberns.update", member);
	}

	@Override
	public int delete(String id) {
		return sst.update("memberns.delete", id);
	}

}
