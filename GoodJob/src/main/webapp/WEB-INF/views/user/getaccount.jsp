<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>계정 찾기</title>
<%@include file="/WEB-INF/views/inc/asset.jsp"%>
<style>
.mb-4 {
	font-family: Pretendard-Regular;
	margin-bottom: 0px;
}

.bg-white {
	margin: 0 auto;
}

.form-label {
	font-family: Pretendard-Regular;
	font-size: 1.2rem;
}

#login_letter {
	font-family: Pretendard-Regular;
	font-size: 1.5rem;
	margin-bottom: 20px;
}

/* 공통 스타일 */
.container {
	max-width: 100%;
}

.button-group {
	border: 2px solid #4444;
	border-radius: 10px;
	text-align: center;
	display: flex;
	padding: none;
	/* 	background-image: linear-gradient(184.78deg, rgb(83, 90, 237) 7.64%, rgb(62, 178, 248) 120.07%); */
}

.button-group > div {
	background: transparent;
	color: #525252;
	font-family: 'Pretendard-Regular';
	font-size: 1.1rem;
}
.button-group > div:first-child {
    border-top-left-radius: 10px;
    border-bottom-left-radius: 10px;
    border-right: 2px solid #4444;
   
}

.button-group > div:last-child {
    border-top-right-radius: 10px;
    border-bottom-right-radius: 10px;
}


.button-group > div {
	padding: 10px 30px;
}

.form-content {
	border: 1px solid #525252;
	padding: 10px;
	border-radius: 10px;
}
.button-group > div {

	width: 100%;
}

/* 폼 요소 스타일 */
input[type="text"] {
	font-family: 'Pretendard-Regular';
	font-size: 1rem;
	border-radius: 10px;
	margin-bottom: 10px;
	width: 100%;
	border-color: rgb(235, 235, 235);
}
input[type="text"] {
	font-family: 'Pretendard-Regular';
	font-size: 1rem;
	border-radius: 10px;
	margin-bottom: 10px;
	width: 100%;
	border-color: rgb(235, 235, 235);
}

.form-content>div {
	text-align: center;
}

.btn_getAccount {
	background-image: linear-gradient(184.78deg, rgb(83, 90, 237) 7.64%,
	rgb(62, 178, 248) 120.07%);
	color: white;
	padding: 10px 20px;
	border-radius: 10px;
	font-size: .7rem;
	font-family: 'Pretendard-Regular';
	margin-left: 3px;
	width: 90%;
	margin-top: 20px;
	font-size: 1.3rem;
}
.form-content {
	border: 2px solid #4444;
	border-radius: 10px;
	border-top: 0;

}
</style>
</head>
<%@include file="/WEB-INF/views/inc/header.jsp"%>
<body>
	<section>
		<div class="container">
			<div class="min-h-[980px] bg-white py-10 lg:col-6 lg:py-[114px]">
				<div class="mx-auto w-full max-w-[480px]">
					<h1 class="mb-4">계정찾기</h1>
					<p id="login_letter">잃어버린 계정을 찾을 수 있습니다.</p>

					<div class="button-group">
						<div>
						<button onclick="showContent('id')">아이디 찾기</button>
					</div>
						<div>
							<button onclick="showContent('pw')">비밀번호 찾기</button>
						</div>
					</div>

						<div id="idContent" class="form-content">
							<label for="name" class="form-label">이름</label> 
							<input type="text" id="name" placeholder="등록한 이름을 입력하세요." /> 
							<label for="tel" class="form-label">연락처</label> 
								<input type="text" id="tel" placeholder="등록한 연락처를 입력하세요." />
							<div>
								<input type="submit" class="btn_getAccount" id="btn_getId"value="아이디 찾기" />
							</div>
							<span id="yourid"></span>
						</div>
<!-- 						<form action="/good/user/changepw.do" method="POST"> -->
						<div id="pwContent" class="form-content">
							<label for="id" class="form-label">아이디</label> 
							<input type="text" id="id" placeholder="등록한 아이디를 입력하세요." /> 
							<label for="tel" class="form-label">연락처</label> 
								<input type="text" id="getPw_tel" placeholder="등록한 연락처를 입력하세요." />
							<div>
								<input type="button" class="btn_getAccount" id="btn_getPw" value="비밀번호찾기" />
							</div>
							<span id="yourpw"></span>
						</div>
						
						<div id="changepw" class="form-content">
							<label for="id" class="form-label"></label> 
							<input type="password" id="pw" name="pw" placeholder="비밀번호" /> 
							<label for="pw" class="form-label">비밀번호 확인</label> 
							<input type="password" id="password" placeholder="비밀번호 확인" />
							<div>
								<input type="button" class="btn_getAccount" id="btn_changePw" value="비밀번호 재설정2" />
							</div>
						</div>
						
						

					
				</div>
			</div>
		</div>
	</section>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
	<%@include file="/WEB-INF/views/inc/footer.jsp"%>
	<script>
		document.addEventListener("DOMContentLoaded", function() {
			// 초기에는 idContent와 pwContent를 모두 숨기기
			const idContent = document.getElementById('idContent');
			const pwContent = document.getElementById('pwContent');
			const changepw = document.getElementById('changepw');
			idContent.style.display = 'none';
			pwContent.style.display = 'none';
			changepw.style.display = 'none';

			 // 버튼 그룹 내의 모든 버튼
		    const buttons = document.querySelectorAll('.button-group button');
		    
		    // 각 버튼에 클릭 이벤트를 추가
		    buttons.forEach(button => {
		        button.addEventListener('click', function() {
		            // 모든 버튼의 배경을 투명으로 설정하고 텍스트 색상을 기본색으로 변경
		            buttons.forEach(btn => {
		                btn.style.backgroundImage = 'none';
		                btn.parentNode.style.backgroundImage = 'none';
		                btn.style.color = '#4444';
		            });
		            // 클릭된 버튼의 배경을 변경하고 해당하는 div의 배경도 변경
		            this.style.color = 'white';
		            this.parentNode.style.backgroundImage = 'linear-gradient(184.78deg, rgb(83, 90, 237) 7.64%, rgb(62, 178, 248) 120.07%)';
		        });
		    });
		});

		function showContent(menu) {
			const idContent = document.getElementById('idContent');
			const pwContent = document.getElementById('pwContent');
		    const changepw = document.getElementById('changepw');

			// 모든 내용을 숨기기
			idContent.style.display = 'none';
			pwContent.style.display = 'none';
			changepw.style.display = 'none';

			// 선택한 메뉴에 따라 해당 내용을 보여주기
			if (menu === 'id') {
				idContent.style.display = 'block';
			} else if (menu === 'pw') {
				pwContent.style.display = 'block';
			}
		}
		
		$('#btn_getId').click(function () {
			
			var name = $('#name').val();
			var tel = $('#tel').val();
			
	        $.ajax({
	            type: 'POST',
	            url: '/good/user/getid.do',
	            data:  'name=' + name + '&tel=' + tel,
	            dataType: 'json',
	            success: function (result) {
	            	console.log(result.result);
	                if (result.result == null) {
	                	$('#yourid').text('일치하는 정보가 없습니다.');
	                	
	                } else {
						$('#yourid').text('해당 id는 ' + result.result + '입니다.');
	                }
	            },
	            error: function (a, b, c) {
	                console.log(a, b, c);
	            }
	        });
		});
		
		$('#btn_getPw').click(function () {
			
			var id = $('#id').val();
			var tel = $('#getPw_tel').val();
			
	        $.ajax({
	            type: 'POST',
	            url: '/good/user/getpw.do',
	            data:  'id=' + id + '&tel=' + tel,
	            dataType: 'json',
	            success: function (result) {
	            	console.log(result.result);
	                if (result.result == 0) {
	                	$('#yourpw').text('일치하는 정보가 없습니다.');
	                	
	                } else {
	        	        $('#id').prop('readonly', true);
	        	        $('#tel').prop('readonly', true);
	                	$('#changepw').show();
	                    
	                }
	            },
	            error: function (a, b, c) {
	                console.log(a, b, c);
	            }
	        });

		});
		
		$('#btn_changePw').click(function () {
			
			var id = $('#id').val();
			var pw = $('#pw').val();
			
	        $.ajax({
	            type: 'POST',
	            url: '/good/user/changepw.do',
	            data:  'id=' + id + '&pw=' + pw,
	            dataType: 'json',
	            success: function (result) {
	            	console.log(result.result);
	                if (result.result == 1) {
	                	var url = '/good/user/signin.do'; 
	                	
	                } else {
	                	alert('비밀변호 변경을 실패하였습니다.');
	                }
	            },
	            error: function (a, b, c) {
	                console.log(a, b, c);
	            }
	        });

		});
		


	</script>
</body>
</html>
