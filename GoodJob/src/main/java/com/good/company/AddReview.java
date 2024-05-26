package com.good.company;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import com.good.company.model.CompanyDTO;
import com.good.company.model.ReviewDTO;
import com.good.company.repository.CompanyDAO;
import com.good.company.repository.ReviewDAO;
import com.good.company.repository.TagDAO;

/**
 * 리뷰 추가 서블릿 클래스
 * 이 클래스는 사용자가 기업 리뷰를 작성하고 제출할 수 있는 기능을 제공합니다.
 * GET 요청 시 리뷰 작성 페이지를 로드하고, POST 요청 시 사용자가 입력한 리뷰 데이터를 처리하여 데이터베이스에 저장합니다.
 */
@WebServlet("/user/company/review/addreview.do")
public class AddReview extends HttpServlet {

    /**
     * GET 요청 처리 메서드
     * 사용자가 리뷰 작성 페이지를 요청할 때 호출됩니다.
     * 로그인 상태를 확인하고, 필요한 데이터를 조회하여 JSP 페이지로 전달합니다.
     * 
     * @param req  HttpServletRequest 객체
     * @param resp HttpServletResponse 객체
     * @throws ServletException 서블릿 예외 발생 시
     * @throws IOException      입출력 예외 발생 시
     */
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		String id = (String)session.getAttribute("id");
		
		if(id == null || id.equals("")) {
			// 로그인되어 있지 않은 경우 로그인 페이지로 이동
			resp.sendRedirect("/good/user/signin.do"); 
			return;
		}
		
		String cp_seq = req.getParameter("cp_seq");
		String page = req.getParameter("page");

		CompanyDAO dao = new CompanyDAO();
		CompanyDTO dto = dao.get(cp_seq);

		ReviewDAO rdao = new ReviewDAO();
		ArrayList<String> showTagList = rdao.showTagList();
		ArrayList<String> showComTagList = rdao.showComTagList();


		req.setAttribute("cp_seq", cp_seq);
		req.setAttribute("page", page);
		req.setAttribute("dto", dto);
		req.setAttribute("showTagList", showTagList);
		req.setAttribute("showComTagList", showComTagList);


		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/user/company/review/addreview.jsp");
		dispatcher.forward(req, resp);
	}

    /**
     * POST 요청 처리 메서드
     * 사용자가 리뷰 작성 폼을 제출할 때 호출됩니다.
     * 폼 데이터를 받아와 ReviewDTO 객체에 저장하고, 태그 정보를 처리한 후 데이터베이스에 리뷰를 저장합니다.
     * 
     * @param req  HttpServletRequest 객체
     * @param resp HttpServletResponse 객체
     * @throws ServletException 서블릿 예외 발생 시
     * @throws IOException      입출력 예외 발생 시
     */
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		String id = (String) session.getAttribute("id");
		
		double salary_score = Double.parseDouble(req.getParameter("salary_score"));
		double welfare_score = Double.parseDouble(req.getParameter("welfare_score"));
		double stability_score = Double.parseDouble(req.getParameter("stability_score"));
		double culture_score = Double.parseDouble(req.getParameter("culture_score"));
		double growth_score = Double.parseDouble(req.getParameter("growth_score"));

		String linereview = req.getParameter("linereview");
		String good = req.getParameter("good");
		String bad = req.getParameter("bad");
		
		ReviewDAO rdao = new ReviewDAO();
		
		ReviewDTO dto = new ReviewDTO();
		
		//String cp_rv_seq = rdao.getCp_rv_seq();
		String cp_seq = req.getParameter("cp_seq");
		if (cp_seq == null || cp_seq.isEmpty()) {
		    
		    resp.setContentType("text/html; charset=UTF-8");
		    PrintWriter out = resp.getWriter();
		    out.println("<script>alert('잘못된 접근입니다. 기업 정보가 선택되지 않았습니다.'); location.href='/good/user/company/review/addreview.do';</script>");
		    out.flush();
		    return;
		}
		

		
		dto.setSalary_score(salary_score);
		dto.setWelfare_score(welfare_score);
		dto.setStability_score(stability_score);
		dto.setCulture_score(culture_score);
		dto.setGrowth_score(growth_score);
		dto.setLinereview(linereview);
		dto.setGood(good);
		dto.setBad(bad);
		dto.setId(id);
		dto.setCp_rv_confirm(0);
		dto.setCp_seq(cp_seq);
		
		//태그등록
		TagDAO tdao = new TagDAO();
		String tag_keyword = req.getParameter("tag_keyword");
		String cp_rv_seq = tdao.getCp_rv_seq();
		if (tag_keyword != null && !tag_keyword.equals("")&& !tag_keyword.equals("[]")) {
			try {
				
				
				JSONParser parser = new JSONParser();				
				JSONArray arr = (JSONArray)parser.parse(tag_keyword); 
				
				for (Object obj : arr) { 
					JSONObject tagObj = (JSONObject)obj;
					String tagKeyword = (String)tagObj.get("value");
					
					
					//해시태그 추가
					if(tdao.existHashtag(tagKeyword)) {					
					   tdao.addHashtag(tagKeyword);
					} 
					//해시태그번호
					String tag_seq = tdao.getHseq(tagKeyword);
					
					
					//관계추가
					HashMap<String,String> map = new HashMap<String,String>();
					map.put("cp_rv_seq", cp_rv_seq);
					map.put("tag_seq", tag_seq);
					tdao.addTagging(map);
					
				}
			} catch (Exception e) {
				e.getStackTrace();
			}
		}
		
		
		
		
		// 리뷰 등록
		int result = rdao.addReview(dto);
		
		if (result == 1) {
	
			resp.sendRedirect("/good/user/company/companyview.do?cp_seq=" + cp_seq);
		} else {
			resp.setCharacterEncoding("UTF-8");
			PrintWriter writer = resp.getWriter();
			writer.println("<script>alert('리뷰 등록에 실패했습니다.'); location.href='/good/user/company/review/addreview.do?cp_seq=" + cp_seq + "';</script>");
			writer.close();
		}
	}
}
