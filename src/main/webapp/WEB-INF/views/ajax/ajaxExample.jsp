<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8">
		<title>Ajax 개요</title>
		<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	</head>
	<body>
		<h1>Ajax 개요</h1>
		<p>Ajax는 Asynchronous Javascript And XML이란 용어로<br>
		서버로부터 데이터를 가져와 전체 페이지를 새로 고치지 않고 일부만 로드할 수 있게 하는 기법<br>
		비동기식 요청을 함.</p>
		<h3>동기식/비동기식이란?</h3>
		<p>동기식은 서버와 클라이언트가 동시에 통신하여 프로세스를 수행 및 종료까지 같이하는 방식<br>
		이에 반해 비동기식은 페이지 리로딩없이 서버요청 사이사이 추가적인 요청과 처리 가능</p>
		<h3>Ajax 구현(Javascript)</h3>
		<h4>1. ajax로 서버에 전송값 보내기</h4>
		<p>버튼 클릭시 전송값을 서버에서 출력</p>
		<input type="text" id="msg-1">
		<button onclick="jsFuncGet();">보내기(JS)</button>
		<h3>Ajax 구현(jQuery)</h3>
		<h4>2. ajax(jQuery)로 서버에 전송값 보내기</h4>		
		<p>버튼 클릭시 전송값을 서버에서 출력</p>
		<input type="text" id="msg-2">
		<button onclick="jqueryFunc()">보내기(jQuery)</button>
		<h3>3. 버튼 클릭시 서버에서 보낸 값 수신</h3>
		<button id="jq-btn3">서버에서 보낸 값 확인(받는거, 수신)</button>
		<p id="confirm-area"></p>
		<h3>4. 서버로 전송값 보내고 결과 문자열 받아서 처리</h3>
		<h4>숫자 2개를 전송하고 더한 값 받기</h4>
		첫번째 수 : <input type="number" id="num-1">
		두번째 수 : <input type="number" id="num-2">
		<button id="jq-btn4">전송 및 결과확인</button>
		<p id="p4"></p>
		<h3>5. 서버로 전송값 보내고 결과 JSON으로 받아서 처리</h3>
		유저 번호 입력 : <input type="text" id="user-num">
		<p id="p5"></p>
		<button id="jq-btn5">실행 및 결과확인</button>
		<h4>6. 서버로 전송값을 보내고 JSONArray로 결과 받아서 처리</h4>
		<p>유저 번호를 보내서 해당 유저를 가져오고, 없는 경우 전체리스트 가져오기</p>
		유저 번호 입력 : <input type="text" id="find-num">
		<p id="p6"></p>
		<button id="jq-btn6">실행 및 결과확인</button>
		<!-- 		
			1. 버튼이 눌리면 Ajax가 동작하는데 유저 번호를 보냄
			2. Controller에서 유저 번호를 받아서 그에 해당하는 데이터를 보내줌
			없으면 전체 리스트 데이터를 보내줌
			3. 성공하면 동작하는 함수에서 매개변수로 받아서 원하는 태그에 출력해줌
		 -->
		<h4>7. GSON을 이용한 List 변환</h4>
		<p>전체리스트 가져오기</p>
		<p id="p7"></p>
		<button id="jq-btn7">실행 및 결과확인</button>
		<h1>JSON 개요</h1>
		<p>
			Ajax 서버 통신시 데이터 전송을 위한 포맷
			<br>
			JSON(Javscript Object Notation) : 자바스크립트 객체 표기법
			<br>
			JSON을 사용하면 모든 데이터형을 서버와 주고 받을 수 있다.(사용목적)
			<br> 숫자, 문자열, boolean, 배열, 객체, null
			<br>
			'{'으로 시작하여 '}'로 끝나며 그 속에 데이터를 표기하고 'key : value(값)' 쌍으로 구성된다.
			<pre>
				{
					"name" : "이순신",
					"age" : 27,
					"birth" : "1990-01-01",
					"gender" : "남",
					"marry" : true,
					"address" : "서울특별시 중구 인사동",
					"family" : {  
								"father" : "아버지",
								"mother" : "어머니",
								"brother" : "동생"
							}
				}
			</pre>
		</p>
		<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
		<script>
			$("#jq-btn7").on("click", function() {
				$.ajax({
					url : "/ajax/ex06.do",
					type : "GET",
					success : function(data) {
						console.log(data);
					},
					error : function() {
						alert("Ajax 오류! 관리자에게 문의바랍니다.");
					}
				});
			});
			$("#jq-btn6").on("click", function() {
				const userNum = $("#find-num").val();
				$.ajax({
					url : "/ajax/ex05.do",
					data : { userNum : userNum },
					type : "GET",
					success : function(data) {
						let str = "";
						for(let i = 0; i < data.length; i++) {
							str += "아이디 : " + data[i].userId + ", 비번 : " + data[i].userPw + "<br>";
						}
						$("#p6").html(str);
					},
					error : function() {
						alert("Ajax 오류! 관리자에게 문의바랍니다.");
					}
				});
			});
		
			$("#jq-btn5").on("click", function() {
				let userNum = $("#user-num").val();
				$.ajax({
					url : "/ajax/ex04.do",
					data : { "userNum" : userNum },
					type : "POST",
					success : function(result) {
						// JSONParse ( String -> json api) 
// 						console.log(result.userId);
// 						console.log(result.userPw);
						$("#p5").html("비밀번호 : " + result.userPw);
					},
					error : function() {
						alert("Ajax 오류! 관리자에게 문의바랍니다.");
					}
				});
			});
			$("#jq-btn4").on("click", function() {
				let num1 = $("#num-1").val();
				let num2 = $("#num-2").val();
				$.ajax({
					url : "/ajax/ex03.do",
					data : { "num1" : num1, "num2" : num2 },
					type : "GET",
					success : function(result) {
						$("#p4").html("<b>연산결과 : " + result + "</b>");
					},
					error : function() {
						alert("Ajax 오류! 관리자에게 문의해주세요!");
					}
				});
			});	
		
			$("#jq-btn3").on("click", function() {
				$.ajax({
					url : "/ajax/ex02.do",
					type : "GET",
					success : function(data) {
						console.log(data);
						$("#confirm-area").text(data);
					},
					error : function() {
						console.log("서버 처리 실패!!");
					}
				});
			});
		
			const jqueryFunc = () => {
				const message = $("#msg-2").val();
				$.ajax({
					url : "/ajax/ex01.do",
					data : { "msg" : message },
					type : "GET",
					success : function() {
						console.log("서버 전송 성공");
					},
					error : function() {
						console.log("서버 전송 실패");
					}
				})
			}
		
			const jsFuncGet = () => {
				// 1. XMLHttpRequest 객체 생성
				const xhttp = new XMLHttpRequest();
				const message = document.querySelector("#msg-1").value;
				// 2. 요청정보 설정
				xhttp.open("GET","/ajax/ex01.do?msg="+message, true);
				// 3. 데이터 처리에 따른 동작함수 설정
				xhttp.onreadystatechange = function() {
					if(this.readyState == 4 && this.status == 200) { // 성공했다면~~
						console.log("서버 전송 성공");
					}else if(this.readyState == 4 && this.status == 404) {
						console.log("서버 전송 실패");
					}
				}
				// 4. 전송
				xhttp.send();
			}
		</script>
	</body>
</html>














