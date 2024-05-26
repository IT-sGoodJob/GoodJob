package com.good.user.mypage;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.good.board.model.StudyDTO;
import com.good.board.repository.StudyDAO;
import com.good.company.model.ReviewDTO;
import com.good.company.repository.ReviewDAO;

/**
 * 내 리뷰 페이지를 처리하는 서블릿 클래스
 */
@WebServlet("/user/mypage/myreview.do")
public class MyReview extends HttpServlet {

	/**
	 * GET 요청을 처리하는 메서드
	 *
	 * @param req  HTTP 요청 객체
	 * @param resp HTTP 응답 객체
	 * @throws ServletException 서블릿 예외
	 * @throws IOException      입출력 예외
	 */
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession();
		String id = (String) session.getAttribute("id");

		// 페이징
		String page = req.getParameter("page");
		int nowPage = 0; // 현재 페이지 번호
		int totalCount = 0; // 총 게시물 수
		int pageSize = 5; // 한 페이지에서 출력할 게시물 수
		int totalPage = 0; // 총 페이지 수
		int begin = 0; // 페이징 시작 위치
		int end = 0; // 페이징 끝 위치
		int n = 0; //
		int loop = 0; //
		int blockSize = 3; // 페이지 개수

		if (page == null || page.equals("")) {
			nowPage = 1;
		} else {
			nowPage = Integer.parseInt(page);
		}
		begin = ((nowPage - 1) * pageSize) + 1;
		end = begin + pageSize - 1;

		HashMap<String, String> map = new HashMap<>();

		map.put("begin", begin + "");
		map.put("end", end + "");
		map.put("id", id);

		ReviewDAO dao = new ReviewDAO();

		ArrayList<ReviewDTO> list = dao.myReview(map);

		for (ReviewDTO dto : list) {
			// 한줄평 자르기
			String line = dto.getLinereview();
			if (line.length() > 15) {
				line = line.substring(0, 15) + "..";
			}
			dto.setLinereview(line);

			// 날짜 자르기
			String regdate = dto.getCp_rv_regdate().substring(0, 10);
			dto.setCp_rv_regdate(regdate);
		}

		// 총 게시물 수
		totalCount = dao.getCount(id);
		totalPage = (int) Math.ceil((double) totalCount / pageSize);

		// 페이지 바 작업
		StringBuilder sb = new StringBuilder();

		loop = 1; // 루프 변수(10바퀴)
		n = ((nowPage - 1) / blockSize) * blockSize + 1; // 페이지 번호 역할

		// 이전 3페이지
		if (n == 1) {
			sb.append(
					"<li class='page-item disabled'><a class='page-link' href='#' aria-label='Previous'> <span aria-hidden='true'>&laquo;</span> <span class='sr-only'>이전페이지</span> </a></li>");
		} else if (n > 3) {
			sb.append(String.format(
					"<li class='page-item'><a class='page-link' href='/good/user/mypage/myreview.do?page=%d' aria-label='Previous'> <span aria-hidden='true'>&laquo;</span> <span class='sr-only'>이전페이지</span> </a></li>",
					n - 1));
		}

		while (!(loop > blockSize || n > totalPage)) {
			if (n == nowPage) {
				sb.append(String.format("<li class='page-item active'><a class='page-link' href='#'>%d</a></li>", n));
			} else {
				sb.append(String.format(
						"<li class='page-item'><a class='page-link' href='/good/user/mypage/myreview.do?page=%d'>%d</a></li>",
						n, n));
			}
			loop++;
			n++;
		}

		// 다음 3페이지
		if (n >= totalPage) {
			sb.append(
					"<li class='page-item disabled'><a class='page-link' href='#' aria-label='Next'> <span aria-hidden='true'>&raquo;</span> <span class='sr-only'>다음페이지</span> </a></li>");
		} else {
			sb.append(String.format(
					"<li class='page-item'><a class='page-link' href='/good/user/mypage/myreview.do?page=%d' aria-label='Next'> <span aria-hidden='true'>&raquo;</span> <span class='sr-only'>다음페이지</span> </a></li>",
					n));
		}
		req.setAttribute("list", list);
		req.setAttribute("map", map);
		req.setAttribute("nowPage", nowPage);
		req.setAttribute("totalCount", totalCount);
		req.setAttribute("totalPage", totalPage);
		req.setAttribute("pagebar", sb.toString());
		dao.close();

		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/user/mypage/myreview.jsp");
		dispatcher.forward(req, resp);

	}

}