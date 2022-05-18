package com.ch.tm.controller;

import java.io.IOException;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
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
	@Autowired
	private JavaMailSender jMailSender;
	
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
			// 일치하는 회원 계정 존재
			result = 1;
			model.addAttribute("member", member2);
			
			// 임시 비밀번호 생성
			String msg = "";
			String code = "";
			Random random = new Random();
			for(int i=0; i<3; i++) {
				int index = random.nextInt(25)+65;  // A~Z까지 랜덤 알파멧 생성  
				code += (char) index;
			}
			int numIndex = random.nextInt(8999)+1000; // 4자리 랜덤 정수 생성
			code += numIndex;
			msg = (String)code;
			
			MimeMessage mm = jMailSender.createMimeMessage();
			try {
				MimeMessageHelper mmh = new MimeMessageHelper(mm, true, "utf-8");
				mmh.setSubject("트래블메이커 임시비밀번호 입니다.");
				mmh.setText("임시비밀번호 : " + msg);
				mmh.setTo(member2.getEmail());
				mmh.setFrom("jshee1028@naver.com");
				jMailSender.send(mm);
				
				// BCryptPasswordEncoder를 이용한 암호화
				String encPassword = passwordEncoder.encode(msg);
				// 이메일이 성공적으로 보내졌으면 멤버 비밀번호 임시 비밀번호로 변경
				member2.setPassword(encPassword);
				int resultUpdatePw = ms.updatePw(member2);
				model.addAttribute("resultUpdatePw", resultUpdatePw);
			} catch (Exception e) {
				result = 0;
				model.addAttribute("msg", e.getMessage());
			}			
		} else {
			result = -1;
		}
		model.addAttribute("result", result);
		return "/member/findPw";
	}
	
	// 로그아웃
	@RequestMapping("logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "/member/logout";
	}
	
	// 회원 정보 수정 입력
	@RequestMapping("myUpdateForm")
	public String myUpdateForm(Model model, HttpSession session) {
		String id = (String)session.getAttribute("id");
		Member member = ms.select(id);
		model.addAttribute("member", member);
		return "/mypage/myUpdateForm";
	}
	
	// 회원 정보 수정 결과
	@RequestMapping("myUpdate")
	public String myUpdate(Member member, Model model, HttpSession session) {
		int result = 0;
		String encPassword = passwordEncoder.encode(member.getPassword());
		member.setPassword(encPassword);
		result = ms.update(member);
		model.addAttribute("result", result);
		return "/mypage/myUpdate";
	}
	
	@RequestMapping("delete")
	public String delete(Model model, HttpSession session) {
		String id = (String)session.getAttribute("id");
		int result = ms.delete(id);
		if (result > 0) session.invalidate();
		model.addAttribute("result", result);
		return "/mypage/delete";
	}
	
	
}
