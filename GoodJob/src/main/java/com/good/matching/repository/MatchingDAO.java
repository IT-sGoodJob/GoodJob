package com.good.matching.repository;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

import com.good.matching.model.MatchingDTO;
import com.test.util.DBUtil;



public class MatchingDAO {

	private Connection conn;
	private Statement stat;
	private PreparedStatement pstat;
	private ResultSet rs;
	private CallableStatement cstmt;

	public MatchingDAO() {
		this.conn = DBUtil.open();
	}


	public HashMap<Integer, String> getColumn(String id) {

		try {	
			String sql = "select * from vwUserSurvey where id = ?";

			pstat = conn.prepareStatement(sql);

			pstat.setString(1, id);

			rs = pstat.executeQuery();

			HashMap<Integer, String> map = new HashMap<>();

			if(rs.next()) {

				map.put(rs.getInt("welfare"),"welfare");
				map.put(rs.getInt("stability"),"stability");
				map.put(rs.getInt("culture"),"culture");
				map.put(rs.getInt("potential"),"potential");

			}

			return map;

		} catch (Exception e) {
			System.out.println("MatchingDAO.getScore");
			e.printStackTrace();
		}

		return null;

	}
	
	

	public ArrayList<MatchingDTO> getMatching(String[] columnNames, String id) {
		ArrayList<MatchingDTO> list = new ArrayList<>();

		try {

			String sql = "BEGIN procMatching(?, ?, ?, ?, ?); END;";

			pstat = conn.prepareStatement(sql);

			pstat.setString(1, id);

			for (int i = 0; i < columnNames.length; i++) {
				pstat.setString(i + 2, columnNames[i]);
			}
			pstat.execute();


			sql = "select * from tempResults";
			stat = conn.createStatement();
			
			rs = stat.executeQuery(sql);
			
			System.out.println(rs == null);
			if (rs != null) {
				while (rs.next()) {
				
					MatchingDTO dto = new MatchingDTO();
					dto.setCp_seq(rs.getString("cp_seq"));
					dto.setCulture(rs.getInt("culture"));
					dto.setPotential(rs.getInt("potential"));
					dto.setStability(rs.getInt("stability"));
					dto.setWelfare(rs.getInt("welfare"));
					dto.setSalary(rs.getInt("salary"));
					list.add(dto);
				}
			}

		} catch (Exception e) {
			System.out.println("MatchingDAO.getMatching - Exception");
			e.printStackTrace();
		}

	return list;
}


	public MatchingDTO getScore(String id) {
		
		try {	
			
			String sql = "select * from vwUserSurvey where id = ?";

			pstat = conn.prepareStatement(sql);

			pstat.setString(1, id);

			rs = pstat.executeQuery();
			
			MatchingDTO dto = new MatchingDTO();

			if(rs.next()) {

				dto.setWelfare((int)Math.round(rs.getDouble("welfare")));
				dto.setCulture((int)Math.round(rs.getDouble("culture")));
				dto.setPotential((int)Math.round(rs.getDouble("potential")));
				dto.setStability((int)Math.round(rs.getDouble("stability")));
				dto.setSalary((int)Math.round(rs.getDouble("salary")));
				
			}
			
			return dto;
				
			} catch (Exception e) {
				System.out.println("MatchingDAO.getScore");
				e.printStackTrace();
			}
		
		return null;
		
	}


}
