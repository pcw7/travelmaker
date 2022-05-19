package com.ch.tm.controller;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ch.tm.model.Board;
import com.ch.tm.service.PageBean;
import com.ch.tm.service.BoardService;
@Controller
public class BoardController {
	@Autowired
	private BoardService bs;
	
	@RequestMapping("home")
	public String home() {
		return "home";
	}
	
	@RequestMapping("board/insertForm")
	public String insertForm(int bno, String pageNum, Model model) {
		model.addAttribute("bno", bno);
		model.addAttribute("pageNum", pageNum);
		return "board/insertForm";
	}
	
	@RequestMapping("board/insert")
	public String insert(Board board, String pageNum, Model model, HttpServletRequest request) {
		// num을 자동으로 1씩 증가
		int number = bs.getMaxNum();

		board.setBno(number);
		int result = bs.insert(board);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("result", result);
		return "board/insert";
	}
	
	@RequestMapping("board/updateForm")
	public String updateForm(int bno, String pageNum, Model model) {
		Board board = bs.select(bno);
		model.addAttribute("board", board);
		model.addAttribute("pageNum", pageNum);
		return "board/updateForm";
	}
	
	@RequestMapping("board/update")
	public String update(Board board, String pageNum, Model model) {
		int result = 0;
		Board board2 = bs.select(board.getBno());
		result = bs.update(board);
		model.addAttribute("result", result);
		model.addAttribute("pageNum", pageNum);
		return "board/update";
	}
	
	@RequestMapping("board/deleteForm")
	public String deleteForm(int bno, String pageNum, Model model) {
		Board board = bs.select(bno);
		model.addAttribute("board", board);
		model.addAttribute("pageNum", pageNum);
		return "board/deleteForm";
	}
	
	@RequestMapping("board/delete")
	public String delete(int bno, String pageNum, Model model) {
		int result = 0;
		Board board2 = bs.select(bno);
		result = bs.delete(bno);
		model.addAttribute("result", result);
		model.addAttribute("pageNum", pageNum);
		return "board/delete";
	}
	
	@RequestMapping("board/view")
	public String view(int bno, String pageNum, Model model) {
		bs.updateReadCount(bno);
		Board board = bs.select(bno);
		model.addAttribute("board", board);
		model.addAttribute("pageNum", pageNum);
		return "board/view";
	}
	
	@RequestMapping("board/bdList")
	public String list(Board board, String pageNum, Model model) {
		if(pageNum == null || pageNum.equals("")) pageNum = "1";
		int rowPerPage = 10;
		int currentPage = Integer.parseInt(pageNum);
		int total = bs.getTotal(board);
		int startRow = (currentPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;
		board.setStartRow(startRow);
		board.setEndRow(endRow);
		List<Board> list = bs.list(board);
		PageBean pb = new PageBean(currentPage, rowPerPage, total);
		int bno = total - startRow + 1;
		String[] title = {"내용"};
		model.addAttribute("title", title);
		model.addAttribute("bno", bno);
		model.addAttribute("pb", pb);
		model.addAttribute("list", list);
		return "board/bdList";
	}
	
}