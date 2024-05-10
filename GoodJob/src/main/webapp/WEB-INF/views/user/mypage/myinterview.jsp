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
				<h1>활동내역</h1>
				<div class="section-header-breadcrumb">
					<div class="breadcrumb-item active">
						<a href="#">활동내역</a>
					</div>
					<div class="breadcrumb-item">면접후기</div>
				</div>
			</div>
			<div class="section-body">
				<h2 class="section-title">면접후기</h2>
				<div class="row mt-4">
					<div class="col-12">
						<div class="card" id="interviewTable">
							<div class="card-header" id="interviewHeader">
								<h4>${totalCount}개의 후기를 작성하셨습니다.</h4>
								<div class="float-right">
									<div class="dropdown d-inline mr-2">
										<button class="btn btn-outline-primary dropdown-toggle"
											type="button" id="dropdownMenuButton" data-toggle="dropdown"
											aria-haspopup="true" aria-expanded="true">모든 날짜</button>
										<div class="dropdown-menu dropsmall"
											x-placement="bottom-start"
											style="position: absolute; transform: translate3d(0px, 28px, 0px); top: 0px; left: 0px; will-change: transform;">
											<a class="dropdown-item dropsmall" href="#">지난 1주</a> <a
												class="dropdown-item dropsmall" href="#">지난 1개월</a> <a
												class="dropdown-item dropsmall" href="#">지난 1년</a>
										</div>
									</div>
									<div class="dropdown d-inline mr-2">
										<button class="btn btn-primary dropdown-toggle" type="button"
											id="dropdownMenuButton" data-toggle="dropdown"
											aria-haspopup="true" aria-expanded="true">등록여부</button>
										<div class="dropdown-menu dropsmall"
											x-placement="bottom-start"
											style="position: absolute; transform: translate3d(0px, 28px, 0px); top: 0px; left: 0px; will-change: transform;">
											<a class="dropdown-item dropsmall" href="#">등록 완료</a> <a
												class="dropdown-item dropsmall" href="#">심사중</a> <a
												class="dropdown-item dropsmall" href="#">반려</a>
										</div>
									</div>
								</div>
							</div>
							<div class="card-body">
								<div class="table-responsive">
									<table class="table table-striped text-center">
										<tr>
											<th>번호</th>
											<th>기업명</th>
											<th>면접시기</th>
											<th>합격여부</th>
											<th>작성일</th>
											<th>등록여부</th>
											<th>수정/삭제</th>
										</tr>
										<c:forEach items="${list}" var="dto">
											<tr>
												<td>${dto.rnum}</td>
												<td>${dto.ITV_CPNAME}</td>
												<td>${dto.ITV_MEETDATE}</td>
												<td><c:if test="${dto.ITV_WHETHER=='합격'}">
														<div class="badge badge-primary">
													</c:if> <c:if test="${dto.ITV_WHETHER=='대기중'}">
														<div class="badge badge-warning">
													</c:if> <c:if test="${dto.ITV_WHETHER=='불합격'}">
														<div class="badge badge-danger">
													</c:if> ${dto.ITV_WHETHER}
													</div></td>
												<td>${dto.ITV_REGDATE}</td>
												<td><c:if test="${dto.ITV_CONFIRM=='1'}">
														<div class="badge badge-primary">등록 완료</div>
													</c:if> 
													<c:if test="${dto.ITV_CONFIRM=='0'}">
														<div class="badge badge-warning">심사중</div>
													</c:if> 
													<c:if test="${dto.ITV_CONFIRM=='2'}">
														<div class="badge badge-danger">반려</div>
													</c:if> </td>
												<td><div class="">
														<c:if test="${dto.ITV_CONFIRM=='0'||dto.ITV_CONFIRM=='2'}">
															<a
																href="/good/board/interview/itvEdit.do?itv_seq=${dto.ITV_SEQ}">수정</a> / <a
																href="#" class="text-danger">삭제</a>
														</c:if>
														<c:if test="${dto.ITV_CONFIRM=='1'}">
															-
														</c:if>
													</div> <input type="hidden" name="std_seq" value="${dto.ITV_SEQ}">
												</td>
											</tr>
										</c:forEach>
									</table>
								</div>
								<div id="interviewPaging">
									<nav>
										<ul class="pagination">${pagebar}
										</ul>
									</nav>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>
	<%@include file="/WEB-INF/views/inc/adminfooter.jsp"%>
	<script>
		$('.text-danger')
				.click(
						function() {
							if (confirm('게시물을 삭제하시겠습니까?')) {
								var itvSeqValue = $(this).closest('div').find(
										'input[type="hidden"]').val();
								location.href = "/good/board/interview/itvDel.do?itv_seq="
										+ itvSeqValue;
								$(this).parents().eq(2).remove();
								//데이터 처리도 해주기
							}
						});
	</script>
</body>
</html>