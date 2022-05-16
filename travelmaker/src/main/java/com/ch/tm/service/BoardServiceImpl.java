package com.ch.tm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ch.tm.model.Board;
import com.ch.tm.dao.BoardDao;

@Service
public class BoardServiceImpl implements BoardService {
	@Autowired
	private BoardDao bd;
	
	@Override
	public int getTotal() {
		return bd.getTotal();
	}

	@Override
	public List<Board> list(int startRow, int endRow) {
		return bd.list(startRow, endRow);
	}

	@Override
	public int getMaxNum() {
		return bd.getMaxNum();
	}

	@Override
	public int insert(Board board) {
		return bd.insert(board);
	}

	@Override
	public void updateReadCount(int bno) {
		bd.updateReadCount(bno);
	}

	@Override
	public Board select(int bno) {
		return bd.select(bno);
	}

	@Override
	public int update(Board board) {
		return bd.update(board);
	}

	@Override
	public int delete(int bno) {
		return bd.delete(bno);
	}

}