package com.good.company.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.good.company.model.CompanyDTO;
import com.test.util.DBUtil;

public class CompanyDAO {
	private Connection conn;
	private Statement stat;
	private PreparedStatement pstat;
	private ResultSet rs;

	public CompanyDAO() {
		this.conn = DBUtil.open();
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

	public List<CompanyDTO> searchCompany(String input) {
		try {
			String sql = "SELECT * FROM (SELECT * FROM tblcompany WHERE cp_name LIKE ?) WHERE ROWNUM <= 5";

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

	/* 만드시다가 도중에 잠깐 두신거 같아서 오류 막기 위해 주석 처리 해놓습니다.
	 * public ArrayList<CompanyDTO> listCompany() {
	 * 
	 * try { String sql = "sql";
	 * 
	 * pstat = conn.prepareStatement(sql); pstat.setString(1, value);
	 * 
	 * rs = pstat.executeQuery(); ArrayList<dto> list = new ArrayList<dto>();
	 * 
	 * while (rs.next()) { dto dto = new dto(); setter list.add(dto); } return list;
	 * 
	 * } catch (Exception e) { e.printStackTrace(); }
	 * 
	 * }
	 */
	
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
	
	
	

}
