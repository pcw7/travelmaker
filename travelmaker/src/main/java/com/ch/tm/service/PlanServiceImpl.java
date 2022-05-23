package com.ch.tm.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ch.tm.dao.PlanDao;

@Service
public class PlanServiceImpl implements PlanService {
	@Autowired
	private PlanDao pd;
}
