<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>게시글 등록</title>
	</head>
	<body>
		<h1>게시글 등록</h1>
		<form action="/board/write.kh" method="post" enctype="multipart/form-data">
			<ul>
				<li>
					<label>제목</label>
					<input type="text" name="boardTitle">
				</li>
				<li>
					<label>작성자</label>
<%-- 					<input type="text" name="boardWriter" value="${memberId }" readonly> --%>
					<span>${memberId }</span>
				</li>
				<li>
					<label>내용</label>
					<textarea rows="4" cols="50" name="boardContent"></textarea>
				</li>
				<li>
					<label>첨부파일</label>
					<!-- String으로 받을 수 없고 변환작업이 필요함 -->
					<input type="file" name="uploadFile">
				</li>
			</ul>
			<div>
				<input type="submit" value="등록">
			</div>
		</form>
	</body>	
</html>