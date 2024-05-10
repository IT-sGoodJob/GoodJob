package com.good.matching;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.good.alert.Alert;
import com.good.company.repository.CompanyDAO;
import com.good.matching.model.MatchingDTO;
import com.good.matching.repository.MatchingDAO;
import com.good.user.repository.UserDAO;

@WebServlet("/user/matching.do")
public class Matching extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession();
		String id = (String) session.getAttribute("id");
		String wish = (String) session.getAttribute("wish");
		String prefer = (String) session.getAttribute("prefer");

		if (id == null || id.equals("")) {
			Alert.needLogin(resp, "/good/user/signin.do");
		} else if (prefer.equals("0")) {
			PrintWriter writer = resp.getWriter();
			writer.println("<html><head><meta charset=\"UTF-8\"><title>Access Denied</title></head><body>");
			writer.println("<script type='text/javascript'>");
			writer.println("alert('설문조사 후 이용 가능합니다.');");
			writer.println("location.href = \"/good/user/matching/viewsurvey.do\";");
			writer.println("</script>");
			writer.println("</body></html>");
			writer.close();
		} else if (wish.equals("0") && prefer.equals("1")) {
			PrintWriter writer = resp.getWriter();
			writer.println("<html><head><meta charset=\"UTF-8\"><title>Access Denied</title></head><body>");
			writer.println("<script type='text/javascript'>");
			writer.println("alert('선호근무조사 후 이용 가능합니다.');");
			writer.println("location.href = \"/good/user/matching/viewwish.do\";");
			writer.println("</script>");
			writer.println("</body></html>");
			writer.close();
		} else if (wish.equals("1") && prefer.equals("1")) {
			
			MatchingDAO dao = new MatchingDAO();
			UserDAO userDAO = new UserDAO();

			String name = userDAO.getName(id);

			HashMap<Integer, String> scoreMap = dao.getColumn(id);

			MatchingAlgo algo = new MatchingAlgo();

			String[] columnNames = algo.sort(scoreMap);

			ArrayList<MatchingDTO> list = dao.getMatching(columnNames, id);

			CompanyDAO companyDAO = new CompanyDAO();

			for (MatchingDTO mdto : list) {

				mdto.setDto(companyDAO.getMatchingInfo(mdto));
				mdto.getDto().setTag_list(companyDAO.getTaglist(mdto.getCp_seq()));

			}

			MatchingDTO dto = dao.getScore(id);
			ScoreMatcher.calculateMatchingRate(list, dto);
			Collections.sort(list, Comparator.reverseOrder());

			for (MatchingDTO dto1 : list) {

				System.out.println(dto1.toString());

			}

			ArrayList<MatchingDTO> top3 = new ArrayList<>(list.subList(0, 3));
			list.subList(0, 3).clear();

			req.setAttribute("name", name);
			req.setAttribute("top3", top3);
			req.setAttribute("list", list);
			req.setAttribute("dto", dto);

			RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/user/matching/matching.jsp");
			dispatcher.forward(req, resp);

		}

	}

}
