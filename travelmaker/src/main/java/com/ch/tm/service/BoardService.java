package com.ch.tm.service;

import java.util.List;

import com.ch.tm.model.Board;

public interface BoardService {

	int getMaxNum();

	int insert(Board board);

	void updateReadCount(int bno);

	Board select(int bno);

	int update(Board board);

	int delete(int bno);

	int getTotal(Board board);

	List<Board> list(Board board);

	List<Board> myLikeList(int mno, int startRow, int endRow);


}
