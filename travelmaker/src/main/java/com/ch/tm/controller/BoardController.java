package com.ch.tm.controller;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ch.tm.model.Board;
import com.ch.tm.model.Member;
import com.ch.tm.service.BoardService;
import com.ch.tm.service.LikesService;
import com.ch.tm.service.MemberService;
import com.ch.tm.service.PageBean;
@Controller
public class BoardController {
	@Autowired
	private BoardService bs;
	@Autowired
	private MemberService ms;
	@Autowired
	private LikesService ls;
	
	@RequestMapping("board/bdInsertForm")
	public String insertForm2(int bno, String pageNum, Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		Member member = ms.select(id);
		model.addAttribute("member", member);
		model.addAttribute("bno", bno);
		model.addAttribute("pageNum", pageNum);
		return "board/bdInsertForm";
	}
	
	
	@RequestMapping("board/bdInsert")
	public String bdInsert2(Board board, HttpSession session, String pageNum,
			Model model) throws IOException {
		int number = bs.getMaxNum();
		board.setBno(number);
        String fileName = board.getFile().getOriginalFilename();
        board.setCourseImg(fileName);
        String real = session.getServletContext().getRealPath("/resources/course");
        FileOutputStream fos = new FileOutputStream(new File(real+"/"+fileName));
		fos.write(board.getFile().getBytes());
		fos.close();        
        bs.insert(board);        
        return "board/rvList"; 
    }
		
	@RequestMapping("board/bdUpdateForm")
	public String updateForm(int bno, String pageNum, Model model) {
		Board board = bs.select(bno);
		model.addAttribute("board", board);
		model.addAttribute("pageNum", pageNum);
		return "board/bdUpdateForm";
	}
	
	@RequestMapping("board/bdUpdate")
	public String update(Board board, String pageNum, Model model) {
		int result = 0;
		Board board2 = bs.select(board.getBno());
		result = bs.update(board);
		model.addAttribute("result", result);
		model.addAttribute("pageNum", pageNum);
		return "board/bdUpdate";
	}
	
	@RequestMapping("board/bdDelete")
	public String delete(int bno, String pageNum, Model model) {
		int result = 0;
		Board board2 = bs.select(bno);
		result = bs.delete(bno);
		ls.deleteAll(bno);
		
		model.addAttribute("result", result);
		model.addAttribute("pageNum", pageNum);
		return "board/bdDelete";
	}
	
	@RequestMapping("board/bdView")
	public String view(int bno, String pageNum, Model model, HttpServletRequest request) {
		bs.updateReadCount(bno);
		Board board = bs.select(bno);
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		Member member = ms.select(id);
		model.addAttribute("member", member);
		model.addAttribute("id", id);
		model.addAttribute("board", board);
		model.addAttribute("pageNum", pageNum);
		return "board/bdView";
	}
	
	@RequestMapping("board/bdList")
	public String list(Board board, String pageNum, Model model, HttpServletRequest request) {
		if(pageNum == null || pageNum.equals("")) pageNum = "1";
		int rowPerPage = 4;
		int currentPage = Integer.parseInt(pageNum);
		int total = bs.getTotal(board);
		int startRow = (currentPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;
		board.setStartRow(startRow);
		board.setEndRow(endRow);
		List<Board> list = bs.list(board);
		PageBean pb = new PageBean(currentPage, rowPerPage, total);
		int bno = total - startRow + 1;
		String[] title = {"내용","작성자"};
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		model.addAttribute("id", id);
		model.addAttribute("title", title);
		model.addAttribute("bno", bno);
		model.addAttribute("pb", pb);
		model.addAttribute("list", list);
		return "board/bdList";
	}
	
	@RequestMapping("board/bdList2")
	public String list2(Board board, String pageNum, Model model, HttpServletRequest request) {
		if(pageNum == null || pageNum.equals("")) pageNum = "1";
		int rowPerPage = 4;
		int currentPage = Integer.parseInt(pageNum);
		int total = bs.getTotal(board);
		int startRow = (currentPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;
		board.setStartRow(startRow);
		board.setEndRow(endRow);
		List<Board> list = bs.list(board);
		PageBean pb = new PageBean(currentPage, rowPerPage, total);
		int bno = total - startRow + 1;
		String[] title = {"지역"};
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		model.addAttribute("id", id);
		model.addAttribute("title", title);
		model.addAttribute("bno", bno);
		model.addAttribute("pb", pb);
		model.addAttribute("list", list);
		return "board/bdList";
	}
	
	@RequestMapping("board/bdMyBoard")
	public String bdMyBoard(Board board, String pageNum, Model model, HttpServletRequest request) {
		if(pageNum == null || pageNum.equals("")) pageNum = "1";
		int rowPerPage = 4;
		int currentPage = Integer.parseInt(pageNum);
		int total = bs.getTotal(board);
		int startRow = (currentPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;
		board.setStartRow(startRow);
		board.setEndRow(endRow);
		List<Board> list = bs.list(board);
		PageBean pb = new PageBean(currentPage, rowPerPage, total);
		int bno = total - startRow + 1;
		String[] title = {"내용","글쓴이","지역"};
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		model.addAttribute("id", id);
		model.addAttribute("title", title);
		model.addAttribute("bno", bno);
		model.addAttribute("pb", pb);
		model.addAttribute("list", list);
		return "board/bdMyBoard";
	}
	
//	게시글 자동 입력	
//	@RequestMapping("insertBoard")
//	public String insertBoard(Model model) {
//		for (int i = 0; i<230; i++) {
//			Board board = new Board();
//			int number = bs.getMaxNum();
//			board.setBno(number);
//			board.setTitle("안녕"+i);
//			board.setS_date(Date.valueOf("2022-05-24"));
//			board.setE_date(Date.valueOf("2022-05-25"));
//			board.setLoc("서울");
//			board.setContent("안녕"+i);
//			board.setMno(1);
//			board.setCourseImg("courseImg_2022. 5. 26._756.png");
//			bs.insert(board);
//		}
//		model.addAttribute("pageNum", "1");
//		model.addAttribute("result", 1);
//		return "board/bdInsert";
//	}
	
}