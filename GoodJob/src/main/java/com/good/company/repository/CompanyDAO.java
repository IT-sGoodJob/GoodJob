package com.good.company.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.good.company.model.CompanyDTO;
import com.good.matching.model.MatchingDTO;
import com.test.util.DBUtil;

public class CompanyDAO {
	private Connection conn;
	private Statement stat;
	private PreparedStatement pstat;
	private ResultSet rs;

	public CompanyDAO() {
		this.conn = DBUtil.open();
	}
	public void close()  {

        try {
            this.conn.close();
        } catch (Exception e) {
            System.out.println("CompanyDAO.close 오류");
            e.printStackTrace();
        }
    }
	
	public ArrayList<CompanyDTO> rcrtCompany() {

		try {

			String sql = "select cp_seq, cp_name, image from tblCompany";

			stat = conn.createStatement();
			rs = stat.executeQuery(sql);

			ArrayList<CompanyDTO> listCompany = new ArrayList<CompanyDTO>();
			while (rs.next()) {

				CompanyDTO dto = new CompanyDTO();

				dto.setCp_seq(rs.getString("cp_seq"));
				dto.setCp_name(rs.getString("cp_name"));
				dto.setCp_address(rs.getString("cp_address"));

				listCompany.add(dto);

			}
			return listCompany;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;
	}

	public ArrayList<CompanyDTO> mainComList(HashMap<String,String> map){
		
		
		try {
			
			String sql ="select * from vwMainComList where score > 3.5";
			String where = " and com_rcrt_cnt > 0";
			
			//검색
			if(map.get("hiring").equals("y")) {
				
				sql += where;
			
			}
			System.out.println(sql);
			
			stat = conn.createStatement();
			rs = stat.executeQuery(sql);

			ArrayList<CompanyDTO> mainComInfo = new ArrayList<CompanyDTO>();
			
			while (rs.next()) {

				CompanyDTO dto = new CompanyDTO();

				dto.setCp_seq(rs.getString("cp_seq"));
				dto.setCp_name(rs.getString("cp_name"));
				
				dto.setImage(rs.getString("image"));
				dto.setReview_avg(rs.getString("score"));
				dto.setIdst_name(rs.getString("idst_name"));
				dto.setCom_rcrt_cnt(rs.getInt("com_rcrt_cnt"));
				mainComInfo.add(dto);

			}
			System.out.println(mainComInfo.size());
			return mainComInfo;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;
	}
	
	
	public List<CompanyDTO> searchCompany(String input) {
		try {
			String sql = "SELECT * FROM (SELECT * FROM tblcompany WHERE cp_name LIKE ? order by cp_name) WHERE ROWNUM <= 5";

			pstat = conn.prepareStatement(sql);
			String search = input + "%";
			pstat.setString(1, search);

			rs = pstat.executeQuery();

			List<CompanyDTO> list = new ArrayList<>();
			while (rs.next()) {
				CompanyDTO dto = new CompanyDTO();
				dto.setCp_name(rs.getString("cp_name"));
				dto.setCp_seq(rs.getString("cp_seq"));

				list.add(dto);
			}
			pstat.close();
			return list;

		} catch (Exception e) {
			System.out.println("CompanyDAO.searchCompany");
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 등록된 기업수 불러오는 메서드
	 * @return 기업수
	 */
	public int countCompanys() {
		
		try {

			String sql = "select count(*) as cnt from tblCompany";

			stat = conn.createStatement();
			rs = stat.executeQuery(sql);

			if (rs.next()) {
				return rs.getInt("cnt");
			}

		} catch (Exception e) {
			System.out.println("등록된 기업수 로드 실패");
			e.printStackTrace();
		}
		
		return 0;
		
	}
	
	/**
	 * 지유)기업 목록, 상세 최신 정보 불러오는 메서드
	 * @return 기업정보(일반/재무/고용)
	 */
	public ArrayList<CompanyDTO> comListInfo(HashMap<String, String> map) {
	    try {
	        String sql = "";
	        String where = "";

	        // 검색어 조건 추가
	        if (map.get("search").equals("y")) {
	            where += "cp_name LIKE '%" + map.get("word") + "%' AND ";
	        }

	        // 채용 중인 기업 조건 추가
	        if (map.get("hiring").equals("y")) {
	            where += "com_rcrt_cnt > 0 AND ";
	        }

	        // 연봉 조건 추가
	        if (map.get("salary_seq") != null && !map.get("salary_seq").isEmpty()) {
	            where += "hire_avr_salary >= " + map.get("salary_seq") + " AND ";
	        }

	        // 지역 조건 추가
	        if (map.get("cp_address") != null && !map.get("cp_address").isEmpty()) {
	            String[] locations = map.get("cp_address").split(",");
	            where += "(";
	            for (int i = 0; i < locations.length; i++) {
	                where += "cp_address LIKE '%" + locations[i] + "%'";
	                if (i < locations.length - 1) {
	                    where += " OR ";
	                }
	            }
	            where += ") AND ";
	        }

	        // 조건절 마지막의 AND 제거
	        if (where.endsWith("AND ")) {
	            where = where.substring(0, where.length() - 4);
	        }

	        // 정렬 기준 추가
	        String orderBy = "";
	        if (map.get("sort").equals("review")) {
	            orderBy = "com_rv_cnt DESC";
	        } else if (map.get("sort").equals("salary")) {
	            orderBy = "hire_avr_salary DESC";
	        }

	        sql = "SELECT * FROM (SELECT a.*, ROWNUM AS rnum FROM (SELECT * FROM vwNewComListInfo " +
	                (where.isEmpty() ? "" : "WHERE " + where) +
	                " ORDER BY " + orderBy + ") a) WHERE rnum BETWEEN " + map.get("begin") + " AND " + map.get("end");

	        stat = conn.createStatement();
	        rs = stat.executeQuery(sql);

	        ArrayList<CompanyDTO> listCompanyInfo = new ArrayList<CompanyDTO>();

	        while (rs.next()) {
	

				CompanyDTO dto = new CompanyDTO();

				dto.setCp_seq(rs.getString("cp_seq"));
				dto.setCp_name(rs.getString("cp_name"));
				dto.setCp_address(rs.getString("cp_address"));
				dto.setCeo(rs.getString("ceo"));
				dto.setFounded(rs.getString("founded"));
				dto.setImage(rs.getString("image"));
				
				dto.setIdst_code(rs.getString("idst_code"));
				dto.setIdst_name(rs.getString("idst_name"));
				
			
				dto.setHire_member(rs.getInt("hire_member"));
				dto.setHire_new(rs.getInt("hire_new"));
				dto.setHire_retired(rs.getInt("hire_retired"));
				dto.setHire_avr_year(rs.getInt("hire_avr_year"));
				dto.setHire_avr_salary(rs.getInt("hire_avr_salary"));
				//dto.setHire_regdate(rs.getString("hire_regdate"));
				
				
				dto.setFnc_sales(rs.getLong("fnc_sales"));
				dto.setFnc_ebit(rs.getLong("fnc_ebit"));
				dto.setFnc_income(rs.getLong("fnc_income"));
				dto.setFnc_period(rs.getString("fnc_period"));
				//dto.setFnc_regdate(rs.getString("fnc_regdate"));
				
				dto.setCom_rcrt_cnt(rs.getInt("com_rcrt_cnt"));
				dto.setCom_scrap_cnt(rs.getInt("com_scrap_cnt"));
				
				listCompanyInfo.add(dto);

			}
			return listCompanyInfo;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;
		
	}
	/**
	 * 채용 공고가 있는 기업 목록 조회 메서드
	 * @return
	 */
	public ArrayList<CompanyDTO> getCompaniesWithRecruitment() {
	    try {
	        LocalDate currentDate = LocalDate.now();
	        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	        String formatCurrentDate = currentDate.format(formatter);

	        String sql = "SELECT c.cp_seq, c.cp_name, c.cp_address, c.image " +
	                     "FROM tblCompany c " +
	                     "INNER JOIN tblRecruit r ON c.cp_seq = r.cp_seq " +
	                     "WHERE r.enddate >= ? " +
	                     "GROUP BY c.cp_seq, c.cp_name, c.cp_address, c.image " +
	                     "HAVING COUNT(r.rcrt_seq) > 0";

	        pstat = conn.prepareStatement(sql);
	        pstat.setString(1, formatCurrentDate);

	        rs = pstat.executeQuery();

	        ArrayList<CompanyDTO> companiesWithRecruitment = new ArrayList<>();

	        while (rs.next()) {
	            CompanyDTO dto = new CompanyDTO();

	            dto.setCp_seq(rs.getString("cp_seq"));
	            dto.setCp_name(rs.getString("cp_name"));
	            dto.setCp_address(rs.getString("cp_address"));
	            dto.setImage(rs.getString("image"));

	            companiesWithRecruitment.add(dto);
	        }

	        return companiesWithRecruitment;

	    } catch (Exception e) {
	        System.out.println("RecruitDAO.getCompaniesWithRecruitment");
	        e.printStackTrace();
	    }

	    return null;
	}
	/**
	 * 검색결과에 따른 기업수를 부러오는 메서드
	 * @param map
	 * @return
	 */
	public int searchCompanyCount(HashMap<String, String> map) {
		
		try {

			String where ="";
			String sql = "";
			
//			if (map.get("search").equals("y")) {
//				
//				where = String.format("where cp_name like '%%%s%%'",map.get("word"));
//				sql = String.format("select count(*) as search_cnt from vwComListInfo %s" , where);
//				
//			}
			
			if(map.get("search").equals("y") && map.get("hiring").equals("y")) {
				
				where = String.format("where cp_name like '%%%s%%' and com_rcrt_cnt > 0",map.get("word"));
				sql = String.format("select count(*) as search_cnt from vwNewComListInfo %s", where);
			
			}else if (map.get("search").equals("y") && map.get("hiring").equals("n")){
			
				where = String.format("where cp_name like '%%%s%%'",map.get("word"));
				sql = String.format("select count(*) as search_cnt from vwNewComListInfo %s", where);
			
			}else if (map.get("search").equals("n") && map.get("hiring").equals("y")){
			
				where = String.format("where com_rcrt_cnt > 0");
				sql = String.format("select count(*) as search_cnt from vwNewComListInfo %s", where);
			
			} else {
				
				sql = String.format("select count(*) as search_cnt from vwNewComListInfo");
			}
			
			
			pstat = conn.prepareStatement(sql);
			rs = pstat.executeQuery();

			if (rs.next()) {
				
				return rs.getInt("search_cnt");
			
			}

		} catch (Exception e) {
			System.out.println("CompanyDAO.searchCompanyCount");
			e.getStackTrace();
		}
		
		return 0;
	}
//TODO 수정해야함
	public CompanyDTO get(String cp_seq) {
		
		try {
		String sql = "select * from vwComDetailInfo where cp_seq = ?";
		
		pstat = conn.prepareStatement(sql);
		pstat.setString(1, cp_seq);
		
		rs = pstat.executeQuery();
		
		if (rs.next()) {
			
			CompanyDTO dto = new CompanyDTO();

			dto.setCp_seq(rs.getString("cp_seq"));
			dto.setCp_name(rs.getString("cp_name"));
			dto.setCp_address(rs.getString("cp_address"));
			dto.setCeo(rs.getString("ceo"));
			dto.setFounded(rs.getString("founded"));
			dto.setImage(rs.getString("image"));
			
			dto.setIdst_code(rs.getString("idst_code"));
			dto.setIdst_name(rs.getString("idst_name"));
			
		
			dto.setHire_member(rs.getInt("hire_member"));
			dto.setHire_new(rs.getInt("hire_new"));
			dto.setHire_retired(rs.getInt("hire_retired"));
			dto.setHire_avr_year(rs.getInt("hire_avr_year"));
			dto.setHire_avr_salary(rs.getInt("hire_avr_salary"));
			dto.setHire_regdate(rs.getString("hire_regdate"));
			
			dto.setHire_member(rs.getInt("hire_member"));
			dto.setHire_new(rs.getInt("hire_new"));
			dto.setHire_retired(rs.getInt("hire_retired"));
			dto.setHire_avr_year(rs.getInt("hire_avr_year"));
			dto.setHire_avr_salary(rs.getInt("hire_avr_salary"));
			dto.setHire_regdate(rs.getString("hire_regdate"));
			
			dto.setCom_rcrt_cnt(rs.getInt("com_rcrt_cnt"));
			dto.setCom_scrap_cnt(rs.getInt("com_scrap_cnt"));
		
			//재무정보
/*			sql = "select * from tblFinance where cp_seq = ?";
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, cp_seq);
			rs = pstat.executeQuery();
			
			ArrayList<CompanyDTO> flist = new ArrayList<CompanyDTO>();
			
			while(rs.next()) {
				
				dto.setFnc_sales(rs.getLong("fnc_sales"));
				dto.setFnc_ebit(rs.getLong("fnc_ebit"));
				dto.setFnc_income(rs.getLong("fnc_income"));
				dto.setFnc_period(rs.getString("fnc_period"));
				dto.setFnc_regdate(rs.getString("fnc_regdate"));
				
				
				flist.add(dto);

			
			}
			
			dto.setFnc_list(flist);*/
			
			return dto;				
		}
		
	} catch (Exception e) {
		e.printStackTrace();
	}
		
		return null;
	}
	

	
	

	public ArrayList<Long>[] getCompanyFinance(String cp_seq) {
		 	ArrayList<Long> salesList = new ArrayList<>();
	        ArrayList<Long> ebitList = new ArrayList<>();
	        ArrayList<Long> incomeList = new ArrayList<>();
	    String sql = "select * from tblFinance where cp_seq = ?";
	   
	 
	    try (PreparedStatement pstat = conn.prepareStatement(sql)) {
	        pstat.setString(1, cp_seq);
	        try (ResultSet rs = pstat.executeQuery()) {
	            while (rs.next()) {
	              
	               long sales = rs.getLong("fnc_sales");
	               long ebit = rs.getLong("fnc_ebit");
	               long income = rs.getLong("fnc_income");
	               
	               salesList.add(sales);
	               ebitList.add(ebit);
	               incomeList.add(income);	                
	            }
	        }
	    } catch (Exception e) {
	        System.out.println("getCompanyFinance");
	        e.printStackTrace();
	    }
	    
	    return new ArrayList[]{salesList, ebitList, incomeList};
	}
	
	/**
	 * 업계평균연봉 조회 메서드	
	 * @param idst_code
	 * @return
	 */
	public int getIdstSalary(String idst_code) {
		try {
			String sql = "select * from vwIdstAvgSalary where idst_code = ?";
			
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, idst_code);
			
			rs = pstat.executeQuery();
			 
				if (rs.next()) {
					
					int idst_avg_salary = rs.getInt("idst_avg_salary");
					
					return idst_avg_salary;
				
				}
			
			}catch (Exception e) {
				e.printStackTrace();
			}
				return 0;
			}
	
	//TODO job dao 만들기
	
	
	public CompanyDTO getMatchingInfo(MatchingDTO mdto) {
		
		try {
				
				String sql = "select * from vwCompanyInfo where cp_seq = ?";
				
				pstat = conn.prepareStatement(sql);
				pstat.setString(1, mdto.getCp_seq());
				
				rs = pstat.executeQuery();
				
				CompanyDTO dto = new CompanyDTO();
				
				if(rs.next()) {
					
					dto.setCp_name(rs.getString("cp_name"));
					dto.setReview_avg(rs.getString("score"));
					dto.setIdst_name(rs.getString("idst_name"));
					dto.setImage(rs.getString("image"));
					
					return dto;
					
				}
				
			} catch (Exception e) {
				System.out.println("기업 매칭 정보 로드 실패");
				e.printStackTrace();
			}
		
		return null;
		
	}
	
	public ArrayList<String> getTaglist(String cp_seq){
		
		try {	
				
				String sql = "select * from vwCompanyTag where cp_seq = ?";
				
				pstat = conn.prepareStatement(sql);
				pstat.setString(1, cp_seq);
				
				rs = pstat.executeQuery();
				
				ArrayList<String> list = new ArrayList<>();
				
				while(rs.next() && list.size() != 2) {
					
					list.add(rs.getString("tag_keyword"));
					
				}
				
				return list;
				
			} catch (Exception e) {
				System.out.println("CompanyDAO.getTaglist");
				e.printStackTrace();
			}
		
		return null;
		
	}
	public CompanyDTO getCompanyBySeq(String cp_seq) {
		try {
			
			String sql = "select * from tblCompany where cp_seq = ?";
			pstat = conn.prepareStatement(sql);
			pstat.setString(1,cp_seq);
			rs = pstat.executeQuery();
			
			if(rs.next()){
				CompanyDTO dto = new CompanyDTO();
				dto.setCp_name(rs.getString("cp_name"));
				dto.setCp_address(rs.getString("cp_address"));
				dto.setImage(rs.getString("image"));
			
				return dto;
			}
		}catch (Exception e) {
	            System.out.println("CompanyDAO.getCompanyByCpSeq");
	            e.printStackTrace();
	        }
	        return null;
	    }

	}
	
	
	
	
	
	
	
	
	
	





