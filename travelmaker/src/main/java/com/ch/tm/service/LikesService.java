package com.ch.tm.service;

import com.ch.tm.model.Likes;

public interface LikesService {

	void insert(int bno, int mno);

	void delete(int bno, int mno);

	Likes select(int bno, int mno);

	int getLikes(int bno);

	int likeTotal(int mno);

}
