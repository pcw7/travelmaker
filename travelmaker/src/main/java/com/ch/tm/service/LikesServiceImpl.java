package com.ch.tm.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ch.tm.dao.LikesDao;
import com.ch.tm.model.Likes;

@Service
public class LikesServiceImpl implements LikesService {
	@Autowired
	private LikesDao ld;

	@Override
	public void insert(int bno, int mno) {
		ld.insert(bno, mno);		
	}

	@Override
	public void delete(int bno, int mno) {
		ld.delete(bno, mno);	
	}

	@Override
	public Likes select(int bno, int mno) {
		return ld.select(bno, mno);
	}

	@Override
	public int getLikes(int bno) {
		return ld.getLikes(bno);
	}

	@Override
	public int likeTotal(int mno) {
		return ld.likesTotal(mno);
	}

	@Override
	public void deleteAll(int bno) {
		ld.deleteAll(bno);
	}


	
	
}
