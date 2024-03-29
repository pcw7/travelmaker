package com.ch.tm.dao;

import java.util.List;

import com.ch.tm.model.Board;

public interface BoardDao {
	
//	int getTotal();

//	List<Board> list(int startRow, int endRow);

	int getMaxNum();

	int insert(Board board);

	void updateReadCount(int bno);

	Board select(int bno);

	int update(Board board);

	int delete(int bno);

	int getTotal(Board board);

	List<Board> list(Board board);

	List<Board> myLikeList(int mno, int startRow, int endRow);

	int allMyBoard(int mno);

	List<Board> myBoardList(int mno, int startRow, int endRow);


}
