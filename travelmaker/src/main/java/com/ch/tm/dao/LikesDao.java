package com.ch.tm.dao;

import com.ch.tm.model.Likes;

public interface LikesDao {

	void insert(int bno, int mno);

	void delete(int bno, int mno);

	Likes select(int bno, int mno);

	int getLikes(int bno);

	int likesTotal(int mno);

}
