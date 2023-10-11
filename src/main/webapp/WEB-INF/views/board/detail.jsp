<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>게시글 상세</title>
		<link rel="stylesheet" href="../resources/css/main.css">
		<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	</head>
	<body>
		<h1>게시글 상세</h1>
			<ul>
				<li>
					<label>제목</label>
					<span>${board.boardTitle }</span>
				</li>
				<li>
					<label>작성자</label>
					<span>${board.boardWriter }</span>
				</li>
				<li>
					<label>내용</label>
					<p>${board.boardContent }</p>
				</li>
				<li>
					<label>첨부파일</label>
					<!-- String으로 받을 수 없고 변환작업이 필요함 -->
<%-- 				<img alt="첨부파일" src="../resources/nuploadFiles/${notice.noticeFileRename }"> --%>
					<a href="${board.boardFilepath }" download>${board.boardFilename }</a> 
					<c:if test="${not empty board.boardFilename  }">
						<a href="#">삭제하기</a>
					</c:if>
				</li>
			</ul>
			<br><br>
			<c:url var="boardDelUrl" value="/board/delete.kh">
				<c:param name="boardNo" value="${board.boardNo }"></c:param>
				<c:param name="boardWriter" value="${board.boardWriter }"></c:param>
			</c:url>
			<c:url var="modifyUrl" value="/board/modify.kh">
				<c:param name="boardNo" value="${board.boardNo }"></c:param>
			</c:url>
			<div>
				<c:if test="${board.boardWriter eq memberId }">
					<button type="button" onclick="showModifyPage('${modifyUrl }');">수정하기</button>
					<button type="button" onclick="deleteBoard('${boardDelUrl }');">삭제하기</button>
				</c:if>
				<button type="button" onclick="showBoardList();">목록으로</button>
				<button type="button" onclick="javascript:history.go(-1);">뒤로가기</button>
			</div>
			<!-- 댓글 등록 -->
			<hr>
				<table align="center" width="500" border="1">
					<tr>
						<td><textarea rows="3" cols="55" id="rContent"></textarea></td>
						<td><button id="rSubmit">등록하기</button></td>
					</tr>
				</table>
<!-- 			<form action="/reply/add.kh" method="post"> -->
<%-- 				<input type="hidden" name="refBoardNo" value="${board.boardNo }"> --%>
<!-- 				<table width="500" border="1"> -->
<!-- 					<tr> -->
<!-- 						<td> -->
<!-- 							<textarea rows="3" cols="55" name="replyContent"></textarea> -->
<!-- 						</td> -->
<!-- 						<td> -->
<!-- 							<input type="submit" value="완료"> -->
<!-- 						</td> -->
<!-- 					</tr> -->
<!-- 				</table> -->
<!-- 			</form> -->
			<!-- 댓글 목록 -->
			<table align="center" width="550" border="1" id="replyTable">
				<tbody></tbody>
			</table>
			<script>
				// 댓글 등록 
				$("#rSubmit").on("click", function() {
					const rContent = $("#rContent").val();
					const refBoardNo = ${board.boardNo };
					$.ajax({
						url : "/reply/add.kh",
						data : { replyContent : rContent, refBoardNo : refBoardNo },
						type : "POST",
						success : function(result) {
							if(result == "success") {
								alert("댓글 등록 성공");
								getReplyList();
								$("#rContent").val("");
							} else {
								alert("댓글 등록 실패");
							}
						},
						error : function() {
							
						}
					});
				});
				// 댓글 수정 
				const modifyReply = (replyNo, obj) => {
// 					alert("modify go"); // 연결 확인
					const inputTag = $(obj).parent().prev().children();
					const replyContent = inputTag.val();
					$.ajax({
						url : "/reply/update.kh",
						data : { replyNo : replyNo, replyContent : replyContent},
						type : "POST",
						success : function(data) {
							if(data == "success") {
								alert("댓글 수정 성공!");
								getReplyList();
							} else {
								alert("댓글 수정 실패!");
							}
						},
						error : function() {
							alert("Ajax 오류! 관리자에게 문의하세요.");
						}
					});
				}
				// 댓글 삭제
				const removeReply = (replyNo) => {
// 					alert("remove go"); // 확인
					$.ajax({
						url : "/reply/delete.kh",
						data : { replyNo : replyNo },
						type : "GET",
						success : function(data) {
							if(data == "success") {
								alert("댓글 삭제 성공!");
								getReplyList();
							} else {
								alert("댓글 삭제 실패!");
							}
						},
						error : function() {
							alert("Ajax 오류! 관리자에게 문의하세요.");
						}
					});
				}
				// 댓글 수정창 보이기
				const modifyView = (obj, replyNo, replyContent) => {
// 					alert("test"); // 연결 확인
					let tr = $("<tr>");
					tr.append("<td colspan='3'><input type='text' size='50' value='"+replyContent+"'></td>");
					tr.append("<td><button onclick='modifyReply("+replyNo+", this);'>수정</button></td>");
					$(obj).parent().parent().after(tr);
				}
				// 댓글 리스트를 불러오는 ajax Function 
				const getReplyList = () => {
					const boardNo = ${board.boardNo };
					$.ajax({
						url : "/reply/list.kh",
						data : { boardNo : boardNo}, 
						type : "GET",
						success : function(result) {
// 							console.log(result);
							const tableBody = $("#replyTable tbody");
							let tr;
							let replyWriter;
							let replyContent;
							let rCreateDate;
							let btnArea;
							
							if(result.length > 0) {
								for(let i in result) {
									tr = $("<tr>"); // <tr></tr>
									replyWriter = $("<td width='100'>").text(result[i].replyWriter); // <td>khuser01</td>
									replyContent = $("<td>").text(result[i].replyContent); // <td>댓글내용</td>
									rCreateDate = $("<td width='100'>").text(result[i].rCreateDate); // <td>2023/09/26</td>
									btnArea = $("<td width='80'>")
													.append("<a href='javascript:void(0)' onclick='modifyView(this,"+result[i].replyNo+",\""+result[i].replyContent+"\");'>수정</a> ")
													.append("<a href='javascript:void(0)' onclick='removeReply("+result[i].replyNo+");'>삭제</a>");
									tr.append(replyWriter);
									tr.append(replyContent);
									tr.append(rCreateDate); // <tr><td></td><td></td>...</tr>
									tr.append(btnArea);
									tableBody.append(tr); // <tbody><tr><td></td><td></td>...</tr></tbody> -> 눈에 보이게 됨
								}
							}
						},
						error : function() {
							alert("Ajax 오류! 관리자에게 문의하세요.");
						}
					});
				}
				// ############### 게시글 ####################
				const deleteBoard = (boardUrl) => {
// 					alert(boardUrl);
					location.href = boardUrl;
				}
				function showModifyPage(modifyUrl) {
					location.href = modifyUrl;
				}
				function showBoardList() {
					location.href="/board/list.kh";
				}
				// ################# 댓글 ######################
				function replyModify(obj, replyNo, refBoardNo) {
					// DOM 프로그래밍을 이용하는 방법
					const form = document.createElement("form");
					form.action = "/reply/update.kh";
					form.method = "post";
					const input = document.createElement("input");
					input.type = "hidden";
					input.value = replyNo;
					input.name = "replyNo";
					const input2 = document.createElement("input");
					input2.type ="hidden";
					input2.value = refBoardNo;
					input2.name = "refBoardNo";
					const input3 = document.createElement("input");
					input3.type = "text";
					// 여기를 this를 이용하여 수정해주세요~~~!
// 					input3.value = document.querySelector("#replyContent").value;
					// this를 이용해서 내가 원하는 노드 찾기(this를 이용한 노드 탐색)
					input3.value = obj.parentElement.previousElementSibling.childNodes[0].value;
// 					obj.parentElement.previousElementSibling.children[0].value
					input3.name = "replyContent";
					form.appendChild(input);
					form.appendChild(input2);
					form.appendChild(input3);
					
					document.body.appendChild(form);
					form.submit();
				}
				function showReplyModifyForm(obj, replyContent) {
					// #1. HTML태그, display:none 사용하는 방법
// 					document.querySelector("#replyModifyForm").style.display="";
					obj.parentElement.parentElement.nextElementSibling.style.display="";

					
					// #2. DOM프로그래밍을 이용하는 방법
// 					<tr id="replyModifyForm" style="display:none;">
// 						<td colspan="3"><input type="text" size="50" value="${reply.replyContent }"></td>
// 						<td><input type="button" value="완료"></td>
// 					</tr>
// 					const trTag = document.createElement("tr");
// 					const tdTag1 = document.createElement("td");
// 					tdTag1.colSpan = 3;
// 					const inputTag1 = document.createElement("input");
// 					inputTag1.type="text";
// 					inputTag1.size=50;
// 					inputTag1.value=replyContent;
// 					tdTag1.appendChild(inputTag1);
// 					const tdTag2 = document.createElement("td");
// 					const inputTag2 = document.createElement("input");
// 					inputTag2.type="button";
// 					inputTag2.value="완료";
// 					tdTag2.appendChild(inputTag2);
// 					trTag.appendChild(tdTag1);
// 					trTag.appendChild(tdTag2);
// 					console.log(trTag);
					// 클릭한 a를 포함하고 있는 tr 다음에 수정폼이 있는 tr 추가하기
// 					const prevTrTag = obj.parentElement.parentElement;
// 					if(prevTrTag.nextElementSibling == null || !prevTrTag.nextElementSibling.querySelector("input"))
// 					prevTrTag.parentNode.insertBefore(trTag, prevTrTag.nextSibling);

				}
				function deleteReply(url) {
					location.href = url;
				}
				getReplyList();
			</script>
	</body>
</html>


















