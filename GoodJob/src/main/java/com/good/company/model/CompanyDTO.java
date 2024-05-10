package com.good.company.model;

import java.util.ArrayList;
import java.util.HashMap;

import lombok.Data;

@Data
public class CompanyDTO {
	//기업정보
	private String cp_seq;
	private String cp_name;
	private String cp_address;
	private String ceo;
	private String founded;
	private String image;
	private String idst_code;
	
	//기업고용정보
	private String hire_seq;
	private int hire_member;
	private int hire_new;
	private int hire_retired;
	private int hire_avr_year;
	private int hire_avr_salary;
	private String hire_regdate;
	
	//업계 평균 연봉(만원)
	private int idst_avg_salary;
	
	//기업재무정보
	private String fnc_seq;	
	private long fnc_sales;
	private long fnc_ebit;
	private long fnc_income;
	private String fnc_period;
	private String fnc_regdate;
    private String unit; // 금액 단위
	private ArrayList<CompanyDTO> fnc_list;
	
	//기업분야정보
	private String idst_name;
	
	//기업직무(기술)정보
	private HashMap<String,String> joblist;
	private String job_seq;
	private String job_name;	
	
	//채용 공고 수
	private int com_rcrt_cnt;
	
	//스크랩 수
	private int com_scrap_cnt;
	
	//리뷰 수
	private int com_rv_cnt;

	private ArrayList<String> tag_list;
	
	//기업 리뷰평점
	private String review_avg;
	

}
