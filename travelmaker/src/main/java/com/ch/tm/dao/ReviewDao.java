package com.ch.tm.dao;

import java.util.List;

import com.ch.tm.model.Review;
import com.ch.tm.model.ReviewPhoto;

public interface ReviewDao {

	List<Review> list(int bno);

	void insert(Review rv);

	void delete(Review rv);

	void update(Review rv);

	void insert(ReviewPhoto rp);

	int getMaxRno();

	List<ReviewPhoto> listphoto(int bno);

}
