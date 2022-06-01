package com.ch.tm.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ch.tm.model.Board;

@Repository
public class BoardDaoImpl implements BoardDao{
	@Autowired
	private SqlSessionTemplate sst;
	
//	@Override
//	public int getTotal() {
//		return sst.selectOne("boardns.getTotal");
//	}

//	@Override
//	public List<Board> list(int startRow, int endRow) {
//		Map<String, Integer> map = new HashMap<String, Integer>();
//		map.put("startRow", startRow);
//		map.put("endRow", endRow);
//		return sst.selectList("boardns.list", map);
//	}

	@Override
	public int getMaxNum() {
		return sst.selectOne("boardns.getMaxNum");
	}

	@Override
	public int insert(Board board) {
		return sst.insert("boardns.insert", board);
	}

	@Override
	public void updateReadCount(int bno) {
		sst.update("boardns.updateReadCount", bno);
	}

	@Override
	public Board select(int bno) {
		return sst.selectOne("boardns.select", bno);
	}

	@Override
	public int update(Board board) {
		return sst.update("boardns.update", board);
	}

	@Override
	public int delete(int bno) {
		return sst.update("boardns.delete", bno);
	}

	@Override
	public int getTotal(Board board) {
		return sst.selectOne("boardns.getTotal", board);
	}

	@Override
	public List<Board> list(Board board) {
		return sst.selectList("boardns.list", board);
	}

	@Override
	public List<Board> myLikeList(int mno, int startRow, int endRow) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("mno", mno);
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		return sst.selectList("boardns.myLikeList", map);
	}


}
