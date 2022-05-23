package com.ch.tm.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class PlanDaoImpl implements PlanDao {
	@Autowired
	private SqlSessionTemplate sst;

}
