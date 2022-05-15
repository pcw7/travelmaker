package com.ch.tm.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ch.tm.model.Review;
import com.ch.tm.model.ReviewPhoto;

@Repository
public class ReviewDaoImpl implements ReviewDao {
	@Autowired
	private SqlSessionTemplate sst;

	@Override
	public List<Review> list(int bno) {
		return sst.selectList("reviewns.list", bno);
	}

	@Override
	public void insert(Review rv) {
		sst.insert("reviewns.insert", rv);
	}

	@Override
	public void delete(Review rv) {
		sst.update("reviewns.delete", rv);
	}

	@Override
	public void update(Review rv) {
		sst.update("reviewns.update", rv);
	}

	@Override
	public void insert(ReviewPhoto rp) {
		sst.insert("reviewns.insertPhoto", rp);
	}

}
