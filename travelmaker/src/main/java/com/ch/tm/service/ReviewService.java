package com.ch.tm.service;

import java.util.List;

import com.ch.tm.model.Review;
import com.ch.tm.model.ReviewPhoto;

public interface ReviewService {

	List<Review> list(int bno);

	void insert(Review rv);

	void delete(Review rv);

	void update(Review rv);

	void insertPhoto(List<ReviewPhoto> photos);

	int getMaxRno();

	List<ReviewPhoto> listphoto(int bno);

}
