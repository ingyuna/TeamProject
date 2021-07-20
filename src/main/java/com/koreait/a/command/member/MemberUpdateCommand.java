package com.koreait.a.command.member;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.a.dao.MemberDAO;
import com.koreait.a.dto.MemberDTO;
import com.koreait.a.utils.SecurityUtils;

public class MemberUpdateCommand implements MemberCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		// TODO Auto-generated method stub
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		
		long no = Long.parseLong(request.getParameter("no"));
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String tel = request.getParameter("tel");
		String addr = request.getParameter("addr");
		int age = Integer.parseInt(request.getParameter("age"));
		MemberDTO member = new MemberDTO();
		member.setMemberNo(no);
		member.setMemberPw(SecurityUtils.encodeBase64(pw));  // pw의 암호화
		member.setMemberName(SecurityUtils.xxs(name));  // name의 xxs처리
		member.setMemberTel(tel);
		member.setMemberAddr(addr);
		member.setMemberAge(age);
		
		MemberDAO memberDAO = sqlSession.getMapper(MemberDAO.class);
		memberDAO.updateMember(member);
		
	}

}
