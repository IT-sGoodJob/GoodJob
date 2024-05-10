package com.good.user.mypage;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.good.board.repository.StudyDAO;

@WebServlet("/user/mypage/main.do")
public class Mypage extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession();
		String id = (String)session.getAttribute("id");
		
		StudyDAO dao = new StudyDAO();
		int stdCnt = dao.getCount(id);
		dao.close();
		
		req.setAttribute("stdCnt", stdCnt);
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/user/mypage/mymain.jsp");
		dispatcher.forward(req, resp);

	}

}