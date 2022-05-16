package com.ch.tm.controller;

import java.io.IOException;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ch.tm.model.Member;
import com.ch.tm.service.MemberService;

@Controller
public class MemberController {
	@Autowired
	private MemberService ms;
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	// 로그인 입력
	@RequestMapping("loginForm")
	public String loginForm() {
		return "/member/loginForm";
	}
	
	// 로그인 결과
	@RequestMapping("login")
	public String login(Member member, Model model, HttpSession session) {
		int result = 0; // 암호가 다름
		Member member2 = ms.select(member.getId());
		if (member2 == null || member2.getDel().equals("y"))
			result = -1;  // 없는 아이디
		else 
			if (passwordEncoder.matches(member.getPassword(), member2.getPassword())) {
				result = 1; // 로그인 성공
				session.setAttribute("id", member.getId());
			}
		model.addAttribute("result", result);
		return "/member/login";
	}
	
	// 회원가입 입력
	@RequestMapping("joinForm")
	public String joinForm() {
		return "/member/joinForm";
	}
	
	// 아이디 중복체크
	@RequestMapping(value= "idChk", produces = "text/html;charset=utf-8")
	@ResponseBody  // jsp를 통하지않고 직접 문자를 전달
	public String idChk(String id) {
		String msg = "";
		Member member = ms.select(id);
		if (member == null) msg = "사용가능한 아이디입니다";
		else msg = "이미 사용 중인 아이디입니다";
		return msg;		
	}
	
	// 별명 중복체크
	@RequestMapping(value= "nickNameChk", produces = "text/html;charset=utf-8")
	@ResponseBody
	public String nickNameChk(String nickName) {
		String msg = "";
		Member member = ms.selectNickName(nickName);
		if (member == null) msg = "사용가능한 별명입니다";
		else msg = "이미 사용 중인 별명입니다.";
		return msg;		
	}
	
	// 회원가입 결과
	@RequestMapping("join")
	public String join(Member member, Model model, HttpSession session) throws IOException {
		int result = 0;
		Member member2 = ms.select(member.getId());
		if (member2 == null) {
			// BCryptPasswordEncoder를 이용한 암호화
			String encPassword = passwordEncoder.encode(member.getPassword());
			member.setPassword(encPassword);
			result = ms.insert(member);
		} else result = -1; // 이미 가입된 아이디
		model.addAttribute("result", result);
		return "/member/join";
	}
	
	// 아이디 찾기 입력
	@RequestMapping("findIdForm")
	public String findIdForm() {
		return "/member/findIdForm";
	}
	
	// 아이디 찾기 결과
	@RequestMapping("findId")
	public String findId(Member member, Model model) {
		int result = 0;
		Member member2 = ms.selectFindId(member);
		if (member2 != null) {
			result = 1;
			model.addAttribute("member", member2);
		} else {
			result = -1;
		}
		model.addAttribute("result", result);
		return "/member/findId";
	}
	
	// 비밀번호 찾기 입력
	@RequestMapping("findPwForm")
	public String findPwForm() {
		return "/member/findPwForm";
	}
	
	// 비밀번호 찾기 결과
	@RequestMapping("findPw")
	public String findPw(Member member, Model model) {
		int result = 0;
		Member member2 = ms.selectFindPw(member);
		if (member2 != null) {
			result = 1;
			model.addAttribute("member", member2);
			
			String msg = "";
			String code = "";
			Random random = new Random();
			for(int i=0; i<3; i++) {
				int index = random.nextInt(25)+65;  // A~Z까지 랜덤 알파멧 생성  
				code += (char) index;
			}
			int numIndex = random.nextInt(9999)+1000; // 4자리 랜덤 정수 생성
			code += numIndex;
			msg = code;
			
			
			
		} else {
			result = -1;
		}
		model.addAttribute("result", result);
		return "/member/findPw";
	}
	
}
