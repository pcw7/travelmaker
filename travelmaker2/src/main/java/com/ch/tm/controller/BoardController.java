package com.ch.tm.controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ch.tm.service.BoardService;
@Controller
public class BoardController {
	@Autowired
	private BoardService bs;
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	@RequestMapping("home")
	public String home() {
		return "home";
	}
}