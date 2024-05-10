<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<style>

</style>
<%@include file="/WEB-INF/views/inc/adminasset.jsp"%>
<head>
<%@include file="/WEB-INF/views/inc/mypageheader.jsp"%>
</head>
<body>
	<!-- Main Content -->
	<div class="main-content">
		<section class="section">
			<div class="section-header">
				<h1>Mypage</h1>
			</div>
			<div class="section-body">
				<h2 class="section-title">${name}님, 안녕하세요.</h2>
				<div class="col-10 col-md-10 col-lg-10" id="profileWidget">
					<div class="card profile-widget">
						<div class="profile-widget-header">
							<img alt="image" src="/good/assets/img/avatar/avatar-1.png"
								class="rounded-circle profile-widget-picture" id="mypageImg">
							<div class="profile-widget-items">
								<div class="profile-widget-item">
									<div class="profile-widget-item-label">내 스크랩</div>
									<div class="profile-widget-item-value">17</div>
								</div>
								<div class="profile-widget-item">
									<div class="profile-widget-item-label">활동내역</div>
									<div class="profile-widget-item-value">-</div>
								</div>
								<div class="profile-widget-item">
									<div class="profile-widget-item-label">선호도 검사</div>
									<div class="profile-widget-item-value">'동료들만 좋다면' 형</div>
								</div>
							</div>
							<div class="profile-widget-items" id="mypageWidget">
								<div class="profile-widget-item">
									<ul class="left">
										<li class=""><a class="" href="#">삼성전자</a></li>
										<li class=""><a class="" href="#">삼성전자</a></li>
										<li class=""><a class="" href="#">삼성전자</a></li>
										<li class=""><a class="" href="#">삼성전자</a></li>
									</ul>
									<button class="btn btn-outline-primary" id="btnScrap">스크랩
										더 보기</button>
								</div>
								<div class="profile-widget-item left card" id="activityList">
									<div class="card-body">
										<ul class="list-group">
											<a href="/good/heeyeon/review.jsp"><li
												class="list-group-item d-flex justify-content-between align-items-center">
													기업리뷰 <span class="badge badge-primary badge-pill">14</span>
											</li></a>
											<a href="/good/user/mypage/mystudy.do"><li
												class="list-group-item d-flex justify-content-between align-items-center">
													스터디 <span class="badge badge-primary badge-pill">${stdCnt>0?stdCnt:'-'}</span>
											</li></a>
											<a href="/good/heeyeon/interview.jsp"><li
												class="list-group-item d-flex justify-content-between align-items-center">
													면접후기 <span class="badge badge-primary badge-pill">1</span>
											</li></a>
											<a href="/good/heeyeon/qna.jsp"><li
												class="list-group-item d-flex justify-content-between align-items-center">
													여기어때? <span class="badge badge-primary badge-pill">1</span>
											</li></a>
										</ul>
									</div>
								</div>
								<div class="profile-widget-item left card" id="preferMain">
									<div class="card-body">
										<canvas id="preferChart" height="70%" width="90%"></canvas>
									</div>
									<button class="btn btn-outline-primary" id="btnTest">검사
										다시하기</button>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="row" id="mypageMainCard">
					<div class="col-12 col-md-6 col-lg-3">
						<div class="card blue">
							<div class="card-body">
								<div class="media">
									<div class="mr-2 bg-custom text-white cardIcon">
										<i class="fas fa-book-open"></i>
									</div>
									<div class="media-body">
									<input type="hidden" name="link" value="/good/user/study/liststudy.do">
										<h6 class="mt-0">스터디</h6>
										<p class="mb-0">스터디하며 함께 취업 준비해요!</p>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-12 col-md-6 col-lg-3">
						<div class="card blue">
							<div class="card-body">
								<div class="media">
									<div class="mr-2 bg-custom text-white cardIcon">
										<i class="fas fa-comments"></i>
									</div>
									<div class="media-body">
									<input type="hidden" name="link" value="#">
										<h6 class="mt-0">면접후기</h6>
										<p class="mb-0">기업 면접 후기를 보고 대비해보세요.</p>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-12 col-md-6 col-lg-3">
						<div class="card blue">
							<div class="card-body">
								<div class="media">
									<div class="mr-2 bg-custom text-white cardIcon">
										<i class="fas fa-question"></i>
									</div>
									<div class="media-body">
									<input type="hidden" name="link" value="/good/user/qna/listqna.do">
										<h6 class="mt-0">여기어때?</h6>
										<p class="mb-0">이 기업이 어떤지 궁금할 땐 여기어때에서 물어보세요!</p>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-12 col-md-6 col-lg-3">
						<div class="card blue">
							<div class="card-body">
								<div class="media">
									<div class="mr-2 bg-custom text-white cardIcon">
										<i class="fas fa-building"></i>
									</div>
									<div class="media-body">
									<input type="hidden" name="link" value="#">
										<h6 class="mt-0">기업비교</h6>
										<p class="mb-0">스크랩한 기업들 중 더 자세히 비교해드릴게요! </p>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>
	<%@include file="/WEB-INF/views/inc/adminfooter.jsp"%>
	<script src="/good/assets/js/page/modules-chartjs.js"></script>
	<script>
		$('.card-body').click(function() {
			window.location.href = $(this).find('input[name="link"]').val();
		});

	</script>
</body>
</html>