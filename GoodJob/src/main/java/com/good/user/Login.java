package com.good.user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.good.user.model.UserDTO;
import com.good.user.repository.UserDAO;
/**
 * Login 서블릿은 사용자 로그인 기능을 제공합니다.
 */
@WebServlet("/user/signin.do")
public class Login extends HttpServlet {
    /**
     * GET 요청을 처리하여 로그인 페이지로 이동합니다.
     * 
     * @param req HttpServletRequest 객체로 클라이언트로부터 전송된 요청을 나타냅니다.
     * @param resp HttpServletResponse 객체로 클라이언트로 응답을 보냅니다.
     * @throws ServletException 서블릿 관련 예외가 발생할 경우 던져집니다.
     * @throws IOException 입출력 관련 예외가 발생할 경우 던져집니다.
     */
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String cp_seq = req.getParameter("cp_seq"); // j
		req.setAttribute("cp_seq", cp_seq); // j

		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/user/signin.jsp");
		dispatcher.forward(req, resp);

	}
	
    /**
     * POST 요청을 처리하여 사용자의 로그인을 시도합니다.
     * 
     * @param req HttpServletRequest 객체로 클라이언트로부터 전송된 요청을 나타냅니다.
     * @param resp HttpServletResponse 객체로 클라이언트로 응답을 보냅니다.
     * @throws ServletException 서블릿 관련 예외가 발생할 경우 던져집니다.
     * @throws IOException 입출력 관련 예외가 발생할 경우 던져집니다.
     */
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String id = req.getParameter("id");
		String pw = req.getParameter("pw");
		String cp_seq = req.getParameter("cp_seq"); //

		UserDTO dto = new UserDTO();
		UserDAO dao = new UserDAO();

		dto.setId(id);
		dto.setPw(pw);

		UserDTO result = dao.login(dto);

		dao.close();

		if (result != null) {
			// 인증 처리

			HttpSession session = req.getSession();

			session.setAttribute("id", id); // 인증 티켓
			session.setAttribute("name", result.getName());
			session.setAttribute("lv", result.getLv());
			session.setAttribute("wish", result.getWish());
			session.setAttribute("prefer", result.getPrefer());

			// 접속 기록 추가하기

			if (result.getLv().equals("2")) {
				resp.sendRedirect("/good/admin/main.do");
				return;
			}

			if (cp_seq != null && !cp_seq.equals("")) {
				// 기업 번호가 전달된 경우 리뷰 작성 페이지로 리다이렉트
				resp.sendRedirect("/good/user/company/review/addreview.do?cp_seq=" + cp_seq);
			} else {
				// 기업 번호가 전달되지 않은 경우 메인 페이지로 리다이렉트
				resp.sendRedirect("/good/main.do");
			}

		} else {
			// 실패 처리

			resp.setContentType("text/html; charset=UTF-8");
			resp.setCharacterEncoding("UTF-8");
			PrintWriter writer = resp.getWriter();
			writer.print("<script>alert('로그인을 실패했습니다.'); location.href='/good/user/signin.do';</script>");
			writer.close();

		}

	}
}