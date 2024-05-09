package com.good.board.interview;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.good.alert.Alert;
import com.good.board.qna.AuthQna;
import com.good.board.repository.InterviewDAO;

@WebServlet("/board/interview/itvDel.do")
public class DelInterview extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		
		if(AuthQna.check(req, resp)) {
			return;
		}
		
		String itv_seq = req.getParameter("itv_seq");
		
		InterviewDAO dao = new InterviewDAO();
		int result = dao.delQna(itv_seq);
		
		if(result == 1) {
			
			resp.sendRedirect("면접후기 리스트");
			
			
		} else {
			
			Alert.fail(resp);
			resp.sendRedirect("/itvWrite.do?itv_seq=" + itv_seq);
			
		}
		
		
		
	}
	
}
