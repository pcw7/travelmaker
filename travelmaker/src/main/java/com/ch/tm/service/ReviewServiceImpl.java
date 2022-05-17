package com.ch.tm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ch.tm.dao.ReviewDao;
import com.ch.tm.model.Review;
import com.ch.tm.model.ReviewPhoto;

@Service
public class ReviewServiceImpl implements ReviewService {
	@Autowired
	private ReviewDao rd;

	@Override
	public List<Review> list(int bno) {
		return rd.list(bno);
	}

	@Override
	public void insert(Review rv) {
		rd.insert(rv);
	}

	@Override
	public void delete(Review rv) {
		rd.delete(rv);
	}

	@Override
	public void update(Review rv) {
		rd.update(rv);
	}

	@Override
	public void insertPhoto(List<ReviewPhoto> photos) {
		for (ReviewPhoto rp : photos) {
			rd.insert(rp);
		}
	}

	@Override
	public int getMaxRno() {
		return rd.getMaxRno();
	}

	@Override
	public List<ReviewPhoto> listphoto(int bno) {
		return rd.listphoto(bno);
	}
}
