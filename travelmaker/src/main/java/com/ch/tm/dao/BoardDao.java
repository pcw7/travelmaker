package com.ch.tm.dao;

import java.util.List;

import com.ch.tm.model.Board;

public interface BoardDao {
	
	int getTotal();

	List<Board> list(int startRow, int endRow);

	int getMaxNum();

	int insert(Board board);

	void updateReadCount(int bno);

	Board select(int bno);

	int update(Board board);

	int delete(int bno);

}
