<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>게시글 목록</title>
		<link rel="stylesheet" href="../resources/css/board/board.css">
	</head>
	<body>
		<h1><a href="/index.jsp">Home</a></h1>
		<h1>게시글 목록</h1>
		<table>
			<colgroup>
				<col width="5%"></col>
				<col width="40%"></col>
				<col width="10%"></col>
				<col width="15%"></col>
				<col width="10%"></col>
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성날짜</th>
					<th>첨부파일</th>
<!-- 					<th>조회수</th> -->
				</tr>
			</thead>
			<tbody>
			<!-- 	list데이터는 items에 넣었고 var에서 설정한 변수로 list데이터에서 -->
			<!-- 	꺼낸 값을 사용하고 i의 값은 varStatus로 사용 -->
				<c:forEach var="board" items="${bList }" varStatus="i">
					<tr>
						<td>${i.count }</td>
						<c:url var="detailUrl" value="/board/detail.kh">
							<c:param name="boardNo" value="${board.boardNo }"></c:param>
						</c:url>
						<td><a href="${detailUrl }">${board.boardTitle }</a></td>
						<td>${board.boardWriter }</td>
						<td>
							<fmt:formatDate pattern="yyyy-MM-dd" value="${board.bCreateDate }"/>
							<%-- ${notice.nCreateDate } --%>
						</td>
						<td>
							<c:if test="${!empty board.boardFilename }">O</c:if>
							<c:if test="${empty board.boardFilename }">X</c:if>
						</td>
<!-- 						<td> -->
<%-- 							<fmt:formatNumber pattern="##,###,###" value="1230000"></fmt:formatNumber> --%>
<!-- 						</td> -->
					</tr>
				</c:forEach>
				
			</tbody>
			<tfoot>
				<tr align="center">
					<td colspan="5">
						<c:if test="${pInfo.startNavi != 1 }">
							<c:url var="prevUrl" value="/board/list.kh">
								<c:param name="page" value="${pInfo.startNavi - 1 }"></c:param>
							</c:url>
							<a href="${prevUrl }">[이전]</a>
						</c:if>
						<c:forEach begin="${pInfo.startNavi }" end="${pInfo.endNavi }" var="p">
							<c:url var="pageUrl" value="/board/list.kh">
								<c:param name="page" value="${p }"></c:param>
							</c:url>
							<a href="${pageUrl }">${p }</a>&nbsp;
						</c:forEach>
						<c:if test="${pInfo.endNavi != pInfo.naviTotalCount }">
							<c:url var="nextUrl" value="/board/list.kh">
								<c:param name="page" value="${pInfo.endNavi + 1 }"></c:param>
							</c:url>
							<a href="${nextUrl }">[다음]</a>
						</c:if>
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<form action="/notice/search.kh" method="get">
							<select name="searchCondition">
								<option value="all">전체</option>
								<option value="writer">작성자</option>
								<option value="title">제목</option>
								<option value="content">내용</option>
							</select>
							<input type="text" name="searchKeyword" placeholder="검색어를 입력하세요">
							<input type="submit" value="검색">
						</form>
					</td>
					<td>
						<button type="button" onclick="showRegisterForm();">글쓰기</button>
					</td>
				</tr>
			</tfoot>
		</table>
		<script>
			const showRegisterForm = () => {
				location.href="/board/write.kh";
			}
		</script>
	</body>
</html>