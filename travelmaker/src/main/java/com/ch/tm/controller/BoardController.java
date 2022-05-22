package com.ch.tm.controller;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.ch.tm.model.Board;
import com.ch.tm.model.Member;
import com.ch.tm.service.BoardService;
import com.ch.tm.service.MemberService;
import com.ch.tm.service.PageBean;
@Controller
public class BoardController {
	@Autowired
	private BoardService bs;
	@Autowired
	private MemberService ms;
	
	@RequestMapping("home")
	public String home() {
		return "home";
	}
	
	@RequestMapping("board/bdInsertForm")
	public String insertForm(int bno, String pageNum, Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		Member member = ms.select(id);
		model.addAttribute("member", member);
		model.addAttribute("bno", bno);
		model.addAttribute("pageNum", pageNum);
		return "board/bdInsertForm";
	}
	
	// 하영
	@RequestMapping("board/bdInsertForm2")
	public String insertForm2(int bno, String pageNum, Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		Member member = ms.select(id);
		model.addAttribute("member", member);
		model.addAttribute("bno", bno);
		model.addAttribute("pageNum", pageNum);
		return "board/bdInsertForm2";
	}
	
	// 하영
	@RequestMapping("bdInsert2")
    public void bdInsert2(@RequestBody(required = false) MultipartFile courseImgFile,
                             Board board) {
        int result = 0;
        int number = bs.getMaxNum();
		board.setBno(number);
		
		if (courseImgFile != null) {
        	board.setCourseImg(courseImgFile.getOriginalFilename());
        }

        result = bs.insert(board);
        
//        try {
//            if (courseImgFile != null) {
//                fileUtil.courseImgSave(board.get), courseImgFile);
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
    }
	
	@RequestMapping("board/bdInsert")
	public String insert(Board board, String pageNum, Model model, HttpServletRequest request) {
		// num을 자동으로 1씩 증가
		int number = bs.getMaxNum();
		board.setBno(number);
		int result = bs.insert(board);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("result", result);
		return "board/bdInsert";
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
		model.addAttribute("id", id);
		model.addAttribute("board", board);
		model.addAttribute("pageNum", pageNum);
		return "board/bdView";
	}
	
	@RequestMapping("board/bdList")
	public String list(Board board, String pageNum, Model model, HttpServletRequest request) {
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
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		model.addAttribute("id", id);
		model.addAttribute("title", title);
		model.addAttribute("bno", bno);
		model.addAttribute("pb", pb);
		model.addAttribute("list", list);
		return "board/bdList";
	}
	
}