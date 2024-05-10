<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<%@include file="/WEB-INF/views/inc/asset.jsp"%>

<style>
.space-evenly {
	justify-content: space-evenly;
}
.matchplus {
	min-height: 200px;
    align-content: center;
}
</style>
</head>
<%@include file="/WEB-INF/views/inc/header.jsp"%>
<body>
	<section class="section pt-0">
		<div class="container mt-16">
			<div class="card px-5 py-16">
				<div class="text-center px-4">
					<h1 class="my-3 gradiTitle">
						<span>IT's Good Job for U</span>
					</h1>
				</div>
				<div id="matchinfo">
					<div class="cpsChart">
						<canvas id="cpSugradarChart" width="300" height="300"></canvas>
					</div>

					<div class="cpsContent pt-4">
						<div class="cpsMember">
							<h3>${name}님의 성향</h3>
							<div class="job_meta">
								<span class="job-keyword">사람중심</span> <span class="job-keyword">돈보다
									성장</span>
							</div>
							<p>결국 일도 '사람'이 모여서 하는 것!</p>
						</div>
					</div>
				</div>
				<div>
					<div class="border-y border-border py-8 mt-6 mb-8">
						<div class="cpsCompanyList">
							<h3 class="pl-8">매칭 기업 Top3 for U!</h3>
							<div class="cpsCompanyInfo">
								<div class="row mt-8 integration-tab-items">

									<c:forEach var="companyDTO" items="${top3}" varStatus="status">
										<div class="mb-8 md:col-6 lg:col-4 integration-tab-item"
											data-groups='["social"]'>
											<div
												class="rounded-xl bg-white px-8 py-8 shadow-lg min-h-400">
												<div
													class="pb-5 integration-card-head flex items-center space-x-4 border-b border-border min-h-[105px]">
													<img src="${companyDTO.dto.image}" alt="" />
													<div>
														<h5 class="h5">${companyDTO.dto.cp_name}</h5>
														<span class="font-medium">${companyDTO.dto.idst_name}</span>
													</div>
												</div>
												<div class="my-5 py-5 smallradarChart">
													<canvas id="cp${status.index + 1}SugradarChart"></canvas>
												</div>
												<div
													class="my-5 py-5 border-y border-border flex space-evenly">
													<div>
														<span
															class="bg-gradient inline-flex h-16 w-16 items-center justify-center rounded-full">
															${companyDTO.matchScore}% </span>
													</div>
													<span class="m-auto">"여기다.<br> ${name}님이 갈 곳!"
													</span>

												</div>
												<div class="job_meta">

													<c:forEach var="tag" items="${companyDTO.dto.tag_list}">
														<span class="job-keyword">${tag}</span>
													</c:forEach>

												</div>
											</div>
										</div>

									</c:forEach>

								</div>

							</div>
						</div>
					</div>
				</div>

				<div class="cpsCompany">
					<h3 class="pl-8">매칭률 높은 기업 더 보기</h3>
					<div class="row mt-8 cpsCompanyInfo">

						<c:forEach items="${list}" var="list">
							<div class="mb-8 sm:col-6 lg:col-4">
								<div class="rounded-xl bg-white p-6 shadow-lg lg:p-match matchplus">
									<div class="integration-card-head flex items-center space-x-4">
										<img src="${list.dto.image}" alt="">
										<div>
											<h5 class="h5">${list.dto.cp_name }</h5>
											<span class="font-medium">${list.dto.idst_name}</span>
										</div>

									</div>
									<div class="job_meta mt-2">
										<c:forEach items="${list.dto.tag_list}" var="tag">
											<span class="job-keyword text-xs">${tag}</span>
										</c:forEach>
									</div>

									<div class="text-right text-lg">
										<i class="fa-solid fa-star gold"></i> ${list.dto.review_avg}
									</div>
								</div>
							</div>
						</c:forEach>



					</div>
				</div>
			</div>
		</div>
	</section>

	<%@include file="/WEB-INF/views/inc/footer.jsp"%>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.4.1/chart.min.js"></script>
	<script>
		var ctx = document.getElementById('cpSugradarChart').getContext('2d');
		var myRadarChart = new Chart(ctx, {
			type : 'radar',
			data : {
				label: '회원',
				labels : [ '성장 가능성', '연봉', '조직문화', '조직안정성', '복지' ],
				datasets : [ {
					data : [${dto.potential}, ${dto.salary}, ${dto.culture}, ${dto.stability}, ${dto.welfare} ], // 새로운 데이터셋의 데이터
					backgroundColor : 'rgba(54, 162, 235, 0.2)', // fill color
					borderColor : 'rgba(54, 162, 235, 1)', // border color
					borderWidth : 1
				} ]
			},
			options : {
				scales : {
					r : {
						min : 0,
						max : 100,
						ticks : {
							stepSize : 20
						}
					}
				}
			}
		});

		<c:forEach var="companyDTO" items="${top3}" varStatus="status">
	    var ctx = document.getElementById('cp${status.index + 1}SugradarChart').getContext('2d');
	    var myRadarChart = new Chart(ctx, {
	      type: 'radar',
	      data: {
	        labels: ['성장 가능성', '연봉', '조직문화', '조직안정성', '복지'],
	        datasets: [{
	          label: '회사',
	          data: [${companyDTO.potential}, ${companyDTO.salary}, ${companyDTO.culture}, ${companyDTO.stability}, ${companyDTO.welfare}],
	          backgroundColor: 'rgba(255, 99, 132, 0.2)',
	          borderColor: 'rgba(255, 99, 132, 1)',
	          borderWidth: 1
	        }, {
	          label: '회원',
	          data: [${dto.potential}, ${dto.salary}, ${dto.culture}, ${dto.stability}, ${dto.welfare}],
	          backgroundColor: 'rgba(54, 162, 235, 0.2)',
	          borderColor: 'rgba(54, 162, 235, 1)',
	          borderWidth: 1
	        }]
	      },
	      options: {
	        scales: {
	          r: {
	            min: 0,
	            max: 100,
	            ticks: {
	              stepSize: 20
	            }
	          }
	        },
	        plugins: {
	          legend: {
	            display: false
	          }
	        }
	      }
	    });
	  </c:forEach>

	</script>
</body>
</html>