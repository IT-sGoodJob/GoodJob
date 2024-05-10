<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<%@include file="/WEB-INF/views/inc/asset.jsp"%>
<style>
</style>

</head>
<%@include file="/WEB-INF/views/inc/header.jsp"%>

<body>
	<section class="integration-single section pt-0">
		<div class="container">
			<div class="row justify-center">

				<div class="lg:col-10 mt-16">
					<div
						class="integration-single-container rounded-xl bg-white py-16 px-5 shadow-lg md:px-10 tab"
						data-tab-group="service-tab">
						<div class="px-4 text-center">
							<h1 class="mt-3 gradiTitle">
								<span>선호근무조건</span>
							</h1>
							<p class="mt-6">
								굿잡forU 추천은 고객님이 선호하는 근무 환경, 위치 등 다양한 요소를 고려합니다.<br> 고객님의
								선호사항을 자세히 알려주시면, 그에 맞춰 최적의 기업을 추천드리겠습니다.
							</p>
						</div>

						<div class="mt-8 border-y border-border py-10" id="userDetail">
							<div>
								<h6 class="text-left preferTitle">
									<i class="fa-solid fa-user-graduate"></i> 학력 선택
								</h6>
								<select>
									<option value="0">학력무관</option>
									<option value="1">고등학교졸업</option>
									<option value="2">대학교(2,3년)</option>
									<option value="3">대학교졸업(4년)</option>
									<option value="4">석사졸업</option>
									<option value="5">박사졸업</option>
									<option value="6">고등학교졸업이상</option>
									<option value="7">대학교(2,3년)이상</option>
									<option value="8">대학교졸업(4년)이상</option>
									<option value="9">석사졸업이상</option>
								</select>
							</div>
							<div>
								<h6 class="text-left preferTitle">
									<i class="fa-solid fa-briefcase"></i> 경력 선택
								</h6>
								<input type="number" min="0" max="40" step="1"
									placeholder="숫자만 입력(0 ~)" required>
							</div>
							<div>
								<h6 class="text-left preferTitle">
									<i class="fa-solid fa-hand-holding-dollar"></i> 희망연봉
								</h6>
								<select>
									<option value="0">회사내규에 따름</option>
									<option value="9">2,600만원 이상</option>
									<option value="10">2,800만원 이상</option>
									<option value="11">3,000만원 이상</option>
									<option value="12">3,200만원 이상</option>
									<option value="13">3,400만원 이상</option>
									<option value="14">3,600만원 이상</option>
									<option value="15">3,800만원 이상</option>
									<option value="16">4,000만원 이상</option>
									<option value="17">5,000만원 이상</option>
									<option value="18">6,000만원 이상</option>
									<option value="19">7,000만원 이상</option>
									<option value="20">8,000~9,000만원</option>
									<option value="21">9,000~1억원</option>
									<option value="22">1억원 이상</option>
									<option value="99">면접후 결정</option>
								</select>
							</div>

						</div>

						<!-- 선호근무지역 Start -->
						<div class="border-b border-border py-10">
							<h5 class="text-left preferTitle">
								<i class="fa-solid fa-location-dot"></i> 선호근무지역(최대 3개)
							</h5>
							<div class="optionRegion">
								<div class="region-list wish">
									<ul>
										<li onclick="showLocations('서울')">서울</li>
										<li onclick="showLocations('경기')">경기</li>
										<li onclick="showLocations('인천')">인천</li>
										<li onclick="showLocations('부산')">부산</li>
										<li onclick="showLocations('대구')">대구</li>
										<li onclick="showLocations('광주')">광주</li>
										<li onclick="showLocations('대전')">대전</li>
										<li onclick="showLocations('울산')">울산</li>
										<li onclick="showLocations('세종')">세종</li>
										<li onclick="showLocations('강원')">강원</li>
										<li onclick="showLocations('경남')">경남</li>
										<li onclick="showLocations('경북')">경북</li>
										<li onclick="showLocations('전남')">전남</li>
										<li onclick="showLocations('전북')">전북</li>
										<li onclick="showLocations('충남')">충남</li>
										<li onclick="showLocations('충북')">충북</li>
										<li onclick="showLocations('제주')">제주</li>
									</ul>
								</div>

								<div class="location-list">
									<div id="locationCheckboxes"></div>
								</div>
							</div>
							<div class="tag-group">
								<span id="lctag"> </span> <span class="clear"
									onclick="clearLocations()"><i
									class="fa-solid fa-rotate-right"></i> 지역 초기화</span>
							</div>
						</div>
						<!-- 선호근무지역 End -->

						<!-- 선호복리후생 Start -->
						<div class="py-10">
							<h5 class="text-left preferTitle">
								<i class="fa-solid fa-heart-circle-plus"></i> 선호복리후생(최대 5개)
							</h5>

							<div class="table_scroll">
								<table class="default_table welfare_select_table"
									id="welfareCheckboxes">
									<colgroup>
										<col style="width: 33.33%">
										<col style="width: 33.33%">
										<col style="width: 33.33%">
									</colgroup>
									<tbody>
										<tr>
											<th>지원금/보험</th>
											<th>급여제도</th>
											<th>출퇴근/근무제도</th>
										</tr>
										<tr>
											<td>
												<ul class="chk_list">
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp407"
															name="welfare_cd[]" value="44" data-description="건강검진 지원"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp407">건강검진 지원</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp408"
															name="welfare_cd[]" value="45" data-description="의료비지원"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp408">의료비지원</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp417"
															name="welfare_cd[]" value="46" data-description="경조사 지원"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp417">경조사 지원</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp419"
															name="welfare_cd[]" value="51" data-description="단체 상해보험"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp419">단체 상해보험</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp486"
															name="welfare_cd[]" value="47" data-description="학자금 지원"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp486">학자금 지원</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp487"
															name="welfare_cd[]" value="48"
															data-description="업무활동비 지원" data-pass-onload-refresh="y">
															<label class="lbl" for="welfare_cd_corp487">업무활동비
																지원</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp488"
															name="welfare_cd[]" value="52" data-description="문화생활"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp488">문화생활</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp490"
															name="welfare_cd[]" value="49" data-description="결혼준비 지원"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp490">결혼준비 지원</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp495"
															name="welfare_cd[]" value="50"
															data-description="복지카드/포인트" data-pass-onload-refresh="y">
															<label class="lbl" for="welfare_cd_corp495">복지카드/포인트</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp534"
															name="welfare_cd[]" value="49" data-description="결혼준비 지원"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp534">결혼준비 지원</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp434"
															name="welfare_cd[]" value="54"
															data-description="명절선물/귀향비" data-pass-onload-refresh="y">
															<label class="lbl" for="welfare_cd_corp434">명절선물/귀향비</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp501"
															name="welfare_cd[]" value="53"
															data-description="임신/출산 지원금" data-pass-onload-refresh="y">
															<label class="lbl" for="welfare_cd_corp501">임신/출산
																지원금</label>
													</span></li>
												</ul>
											</td>
											<td>
												<ul class="chk_list">
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp400"
															name="welfare_cd[]" value="1" data-description="퇴직연금"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp400">퇴직연금</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp401"
															name="welfare_cd[]" value="2" data-description="인센티브제"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp401">인센티브제</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp402"
															name="welfare_cd[]" value="3" data-description="상여금"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp402">상여금</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp403"
															name="welfare_cd[]" value="4" data-description="장기근속자 포상"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp403">장기근속자 포상</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp404"
															name="welfare_cd[]" value="5" data-description="우수사원포상"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp404">우수사원포상</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp405"
															name="welfare_cd[]" value="6" data-description="스톡옵션"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp405">스톡옵션</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp406"
															name="welfare_cd[]" value="7" data-description="퇴직금"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp406">퇴직금</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp420"
															name="welfare_cd[]" value="8" data-description="성과급"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp420">성과급</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp421"
															name="welfare_cd[]" value="9" data-description="야근수당"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp421">야근수당</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp422"
															name="welfare_cd[]" value="10"
															data-description="휴일(특근)수당" data-pass-onload-refresh="y">
															<label class="lbl" for="welfare_cd_corp422">휴일(특근)수당</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp423"
															name="welfare_cd[]" value="11" data-description="연차수당"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp423">연차수당</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp424"
															name="welfare_cd[]" value="12" data-description="직책수당"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp424">직책수당</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp425"
															name="welfare_cd[]" value="13" data-description="자격증수당"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp425">자격증수당</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp426"
															name="welfare_cd[]" value="14" data-description="장기근속수당"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp426">장기근속수당</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp427"
															name="welfare_cd[]" value="15" data-description="위험수당"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp427">위험수당</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp428"
															name="welfare_cd[]" value="16" data-description="가족수당"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp428">가족수당</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp499"
															name="welfare_cd[]" value="17" data-description="4대 보험"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp499">4대 보험</label>
													</span></li>
												</ul>
											</td>

											<td>
												<ul class="chk_list">
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp410"
															name="welfare_cd[]" value="33" data-description="기숙사 운영"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp410">기숙사 운영</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp414"
															name="welfare_cd[]" value="34" data-description="통근버스 운행"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp414">통근버스 운행</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp477"
															name="welfare_cd[]" value="35" data-description="주차장제공"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp477">주차장제공</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp478"
															name="welfare_cd[]" value="36" data-description="주차비지원"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp478">주차비지원</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp524"
															name="welfare_cd[]" value="37" data-description="재택근무"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp524">재택근무</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp525"
															name="welfare_cd[]" value="38" data-description="주 52시간"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp525">주 52시간</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp527"
															name="welfare_cd[]" value="40" data-description="주4.5일"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp527">주 4.5일</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp528"
															name="welfare_cd[]" value="39" data-description="주4일"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp528">주 4일</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp529"
															name="welfare_cd[]" value="42" data-description="사택 제공"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp529">사택 제공</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp530"
															name="welfare_cd[]" value="43" data-description="주거비 지원"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp530">주거비 지원</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp535"
															name="welfare_cd[]" value="41" data-description="자율 근무제"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp535">자율 근무제</label>
													</span></li>
												</ul>
											</td>

											
										</tr>
										<tr>
											<th>근무 환경</th>
											<th>조직문화</th>
											<th>교육/생활</th>
										</tr>
										<tr>
										<td>
												<ul class="chk_list">
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp444"
															name="welfare_cd[]" value="18"
															data-description="사내 어린이집 운영"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp444">사내 어린이집 운영</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp449"
															name="welfare_cd[]" value="19" data-description="휴게실"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp449">휴게실</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp450"
															name="welfare_cd[]" value="20" data-description="수면실"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp450">수면실</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp453"
															name="welfare_cd[]" value="21" data-description="사내 카페"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp453">사내 카페</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp455"
															name="welfare_cd[]" value="22" data-description="구내 식당"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp455">구내 식당</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp457"
															name="welfare_cd[]" value="23" data-description="정원"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp457">정원</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp459"
															name="welfare_cd[]" value="24" data-description="휠체어용 난간"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp459">휠체어용 난간</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp465"
															name="welfare_cd[]" value="25" data-description="체력단련실운영"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp465">체력단련실운영</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp460"
															name="welfare_cd[]" value="26" data-description="유도점자블록"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp460">유도점자블록</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp461"
															name="welfare_cd[]" value="27" data-description="장애인 화장실"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp461">장애인 화장실</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp462"
															name="welfare_cd[]" value="28"
															data-description="장애인 전용주차장" data-pass-onload-refresh="y">
															<label class="lbl" for="welfare_cd_corp462">장애인
																전용주차장</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp463"
															name="welfare_cd[]" value="29"
															data-description="장애인 엘리베이터" data-pass-onload-refresh="y">
															<label class="lbl" for="welfare_cd_corp463">장애인
																엘리베이터</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp464"
															name="welfare_cd[]" value="30" data-description="비상경보장치"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp464">비상경보장치</label>
													</span></li>

													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp484"
															name="welfare_cd[]" value="31"
															data-description="자회사 제품할인" data-pass-onload-refresh="y">
															<label class="lbl" for="welfare_cd_corp484">자회사
																제품할인</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp485"
															name="welfare_cd[]" value="32" data-description="최신 장비"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp485">최신 장비</label>
													</span></li>
												</ul>
											</td>
											<td>
												<ul class="chk_list">
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp431"
															name="welfare_cd[]" value="60"
															data-description="수평적 조직문화" data-pass-onload-refresh="y">
															<label class="lbl" for="welfare_cd_corp431">수평적
																조직문화</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp432"
															name="welfare_cd[]" value="55" data-description="회식강요 안함"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp432">회식강요 안함</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp433"
															name="welfare_cd[]" value="56" data-description="야근강요 안함"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp433">야근강요 안함</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp466"
															name="welfare_cd[]" value="57" data-description="자유복장"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp466">자유복장</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp467"
															name="welfare_cd[]" value="58" data-description="캐주얼데이"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp467">캐주얼데이</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp514"
															name="welfare_cd[]" value="59"
															data-description="자유로운 연차사용" data-pass-onload-refresh="y">
															<label class="lbl" for="welfare_cd_corp514">자유로운
																연차사용</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp518"
															name="welfare_cd[]" value="61" data-description="칼퇴근 보장"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp518">칼퇴근 보장</label>
													</span></li>
												</ul>
											</td>
											<td>
												<ul class="chk_list">
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp102"
															name="welfare_cd[]" value="62" data-description="워크샵"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp102">워크샵</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp203"
															name="welfare_cd[]" value="63" data-description="해외연수지원"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp203">해외연수지원</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp204"
															name="welfare_cd[]" value="64" data-description="도서구입비지원"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp204">도서구입비지원</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp206"
															name="welfare_cd[]" value="65" data-description="멘토링제도"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp206">멘토링제도</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp209"
															name="welfare_cd[]" value="66" data-description="자격증취득지원"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp209">자격증취득지원</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp210"
															name="welfare_cd[]" value="69" data-description="교육비 지원"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp210">교육비 지원</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp416"
															name="welfare_cd[]" value="67" data-description="저녁식사 제공"
															data-pass-onload-refresh="y"> <label class="lbl"
															for="welfare_cd_corp416">저녁식사 제공</label>
													</span></li>
													<li class="chk_item"><span class="inpChk small">
															<input type="checkbox" id="welfare_cd_corp418"
															name="welfare_cd[]" value="68"
															data-description="사내동호회 운영" data-pass-onload-refresh="y">
															<label class="lbl" for="welfare_cd_corp418">사내동호회
																운영</label>
													</span></li>
												</ul>
											</td>

										</tr>
									</tbody>
								</table>
							</div>
							<div class="tag-group">
								<span id="weltag"> </span> <span class="clear"
									onclick="clearWelfares()"><i
									class="fa-solid fa-rotate-right"></i> 선택 초기화</span>
							</div>
						</div>
						<!-- 선호복리후생 End -->
						<div class="px-4 text-center">
							<button class="btn btn-primary w-full" type="submit">제출하기</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<%@include file="/WEB-INF/views/inc/footer.jsp"%>
	<script>
		/* 선호근무지역 Start */
		//선호근무지역 생성기
		function showLocations(region) {
			var locationCheckboxes = document
					.getElementById('locationCheckboxes');
			locationCheckboxes.innerHTML = '';

			if (region === '서울') {
				var locations = [ '서울전체', '강남구', '강동구', '강북구', '강서구', '관악구',
						'광진구', '구로구', '금천구', '노원구', '도봉구', '동대문구', '동작구',
						'마포구', '서대문구', '서초구', '성동구', '성북구', '송파구', '양천구',
						'영등포구', '용산구', '은평구', '종로구', '중구', '중랑구' ];

				var locationcode = 101000;
			} else if (region === '경기') {
				var locations = [ '경기전체', '가평군', '고양시', '고양시 덕양구', '고양시 일산동구',
						'고양시 일산서구', '과천시', '광명시', '광주시', '구리시', '군포시', '김포시',
						'남양주시', '동두천시', '부천시', '부천시 소사구', '부천시 오정구', '부천시 원미구',
						'성남시', '성남시 분당구', '성남시 수정구', '성남시 중원구', '수원시',
						'수원시 권선구', '수원시 영통구', '수원시 장안구', '수원시 팔달구', '시흥시',
						'안산시', '안산시 단원구', '안산시 상록구', '안성시', '안양시', '안양시 동안구',
						'안양시 만안구', '양주시', '양평군', '여주시', '연천군', '오산시', '용인시',
						'용인시 기흥구', '용인시 수지구', '용인시 처인구', '의왕시', '의정부시', '이천시',
						'파주시', '평택시', '포천시', '하남시', '화성시' ];
				var locationcode = 102000;
			} else if (region === '광주') {
				var locations = [ '광주전체', '광산구', '남구', '동구', '북구', '서구' ];
				var locationcode = 103000;
			} else if (region === '대구') {
				var locations = [ '대구전체', '남구', '달서구', '달성군', '동구', '북구', '서구',
						'수성구', '중구', '군위군' ];

				var locationcode = 104000;
			} else if (region === '대전') {
				var locations = [ '대전전체', '대덕구', '동구', '서구', '유성구', '중구' ];
				var locationcode = 105000;
			} else if (region === '부산') {
				var locations = [ '부산전체', '강서구', '금정구', '기장군', '남구', '동구',
						'동래구', '부산진구', '북구', '사상구', '사하구', '서구', '수영구', '연제구',
						'영도구', '중구', '해운대구' ];

				var locationcode = 106000;
			} else if (region === '울산') {
				var locations = [ '울산전체', '남구', '동구', '북구', '울주군', '중구' ];

				var locationcode = 107000;
			} else if (region === '인천') {
				var locations = [ '인천전체', '강화군', '계양구', '미추홀구', '남동구', '동구',
						'부평구', '서구', '연수구', '옹진군', '중구' ];

				var locationcode = 108000;
			} else if (region === '강원') {
				var locations = [ '강원전체', '강릉시', '고성군', '동해시', '삼척시', '속초시',
						'양구군', '양양군', '영월군', '원주시', '인제군', '정선군', '철원군', '춘천시',
						'태백시', '평창군', '홍천군', '화천군', '횡성군' ];

				var locationcode = 109000;
			} else if (region === '경남') {
				var locations = [ '경남전체', '거제시', '거창군', '고성군', '김해시', '남해군',
						'창원시 마산회원구', '창원시 마산합포구', '창원시 성산구', '창원시 의창구', '밀양시',
						'사천시', '산청군', '양산시', '의령군', '진주시', '창원시 진해구', '창녕군',
						'창원시', '통영시', '하동군', '함안군', '함양군', '합천군' ];
				var locationcode = 110000;
			} else if (region === '경북') {
				var locations = [ '경북전체', '경산시', '경주시', '고령군', '구미시', '군위군',
						'김천시', '문경시', '봉화군', '상주시', '성주군', '안동시', '영덕군', '영양군',
						'영주시', '영천시', '예천군', '울릉군', '울진군', '의성군', '청도군', '청송군',
						'칠곡군', '포항시', '포항시 남구', '포항시 북구' ];
				var locationcode = 111000;
			} else if (region === '전남') {
				var locations = [ '전남전체', '강진군', '고흥군', '곡성군', '광양시', '구례군',
						'나주시', '담양군', '목포시', '무안군', '보성군', '순천시', '신안군', '여수시',
						'영광군', '영암군', '완도군', '장성군', '장흥군', '진도군', '함평군', '해남군',
						'화순군' ];
				var locationcode = 112000;
			} else if (region === '전북') {
				var locations = [ '전북전체', '고창군', '군산시', '김제시', '남원시', '무주군',
						'부안군', '순창군', '완주군', '익산시', '임실군', '장수군', '전주시',
						'전주시 덕진구', '전주시 완산구', '정읍시', '진안군' ];
				var locationcode = 113000;
			} else if (region === '충북') {
				var locations = [ '충북전체', '괴산군', '단양군', '보은군', '영동군', '옥천군',
						'음성군', '제천시', '증평군', '진천군', '청원군', '청주시', '청주시 상당구',
						'청주시 흥덕구', '충주시', '청주시 청원구', '청주시 서원구' ];

				var locationcode = 114000;
			} else if (region === '충남') {
				var locations = [ '충남전체', '계룡시', '공주시', '금산군', '논산시', '당진시',
						'보령시', '부여군', '서산시', '서천군', '아산시', '연기군', '예산군', '천안시',
						'천안시 동남구', '천안시 서북구', '청양군', '태안군', '홍성군' ];

				var locationcode = 115000;
			} else if (region === '제주') {
				var locations = [ '제주전체', '서귀포시', '제주시' ];

				var locationcode = 116000;
			} else if (region === '세종') {
				var locations = [ '세종특별자치시' ];

				var locationcode = 118000;
			}

			locations.forEach(function(location) {
				var label = document.createElement('label');
				var checkbox = document.createElement('input');
				checkbox.type = 'checkbox';
				checkbox.value = locationcode;
				label.appendChild(checkbox);
				label.appendChild(document.createTextNode(' ' + location));
				locationCheckboxes.appendChild(label);
				locationcode += 10;
			});

			//지역체크 유지하기 위한 코드
			document
					.querySelectorAll(
							'#locationCheckboxes input[type="checkbox"]')
					.forEach(
							function(locationCheckbox) {
								document
										.querySelectorAll(
												'#lctag input[type="checkbox"]')
										.forEach(
												function(lctagCheckbox) {
													if (locationCheckbox.value === lctagCheckbox.id) {
														locationCheckbox.checked = true;
													}
												});
							});

		}

		//지역 초기화 버튼
		function clearLocations() {
			$('#locationCheckboxes').html('');
			$('#lctag').html('');
		}

		//지역 체크시 태그 생성/삭제
		$('#locationCheckboxes')
				.on(
						'change',
						'input[type="checkbox"]',
						function() {
							var target = $(this);
							var lctag = $('#lctag');

							if (lctag.children().length >= 6
									&& target.is(':checked')) {
								alert('3개 이상 선택할 수 없습니다.');
								target.prop('checked', false);
								return;
							}

							if (target.is(':checked')) {
								var tagname = target.parent().text().trim();
								var tagId = target.val();

								lctag
										.append('<input type="checkbox" id="' + tagId + '" value="' + tagname + '">'
												+ '<label for="' + tagId + '">'
												+ tagname
												+ ' <i class="fa-solid fa-xmark"></i></label>');
							} else {
								var tagId = target.val();
								$('#' + tagId).next().addBack().remove();
							}
						});

		//지역 태그 눌러서 삭제하기
		$('#lctag').on('change', 'input[type="checkbox"]', function() {
			var checkboxId = $(this).attr('id');

			$('#locationCheckboxes input[type="checkbox"]').each(function() {
				var locationCheckbox = $(this);
				if (locationCheckbox.val() === checkboxId) {
					locationCheckbox.prop('checked', false);
				}
			});
			$(this).next().addBack().remove();
		});
		/* 선호근무지역 End */

		/* 선호복리후생 Start */
		//복지 선택 초기화 버튼
		function clearWelfares() {
			$('#welfareCheckboxes input[type="checkbox"]').prop('checked',
					false);
			$('#weltag').html('');
		}

		//복지 체크시 태그 생성/삭제
		$('#welfareCheckboxes')
				.on(
						'change',
						'input[type="checkbox"]',
						function() {
							var target = $(this);
							var weltag = $('#weltag');

							if (weltag.children().length >= 10
									&& target.is(':checked')) {
								alert('5개 이상 선택할 수 없습니다.');
								target.prop('checked', false);
								return;
							}

							if (target.is(':checked')) {
								var tagname = target.parent().text().trim();
								var tagId = target.val();

								weltag
										.append('<input type="checkbox" id="' + tagId + '" value="' + tagname + '">'
												+ '<label for="' + tagId + '">'
												+ tagname
												+ ' <i class="fa-solid fa-xmark"></i></label>');
							} else {
								var tagId = target.val();
								$('#' + tagId).next().addBack().remove();
							}
						});

		//복지 태그 눌러서 삭제하기
		$('#weltag').on('change', 'input[type="checkbox"]', function() {
			var checkboxId = $(this).attr('id');

			$('#welfareCheckboxes input[type="checkbox"]').each(function() {
				var welfareCheckbox = $(this);
				if (welfareCheckbox.val() === checkboxId) {
					welfareCheckbox.prop('checked', false);
				}
			});
			$(this).next().addBack().remove();
		});
		/* 선호복리후생 End */
	</script>
</body>

</html>