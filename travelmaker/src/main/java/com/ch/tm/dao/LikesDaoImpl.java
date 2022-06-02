package com.ch.tm.dao;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ch.tm.model.Likes;

@Repository
public class LikesDaoImpl implements LikesDao {
	@Autowired
	private SqlSessionTemplate sst;

	@Override
	public void insert(int bno, int mno) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("bno", bno);
		map.put("mno", mno);
		sst.insert("likesns.insert", map);
	}

	@Override
	public void delete(int bno, int mno) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("bno", bno);
		map.put("mno", mno);
		sst.delete("likesns.delete", map);
	}

	@Override
	public Likes select(int bno, int mno) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("bno", bno);
		map.put("mno", mno);
		return sst.selectOne("likesns.select", map);		
	}

	@Override
	public int getLikes(int bno) {
		return sst.selectOne("likesns.getLikes", bno);
	}

	@Override
	public int likesTotal(int mno) {
		return sst.selectOne("likesns.likesTotal", mno);
	}

	@Override
	public void deleteAll(int bno) {
		sst.delete("likesns.deleteAll", bno);		
	}
	

}
