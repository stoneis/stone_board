<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>blog.naver.com/musasin84 - 게시판 목록 (서블릿)</title>
	<style type="text/css">
		* {font-size: 9pt; font-family: 굴림;}
		tr, td, th {border: solid 1px;}
	</style>
</head>
<body>
<h1>게시판 목록 (서블릿) (blog.naver.com/musasin84)</h1>
<form name="searchForm" action="boardList.jsp" method="get">
<table style="border: solid 1px; width: 500px; margin-bottom: 5px;">
<tr>
	<td>
		<select name="searchField" style="width: 98%">
			<option value="">전체</option>
			<option value="SUBJECT">제목</option>
			<option value="CONTENTS">내용</option>
		</select>
	</td>
	<td>
		<input type="text" name="searchText" value="" style="width: 98%" />
	</td>
	<td>
		<input type="submit" value="검색" />
		<input type="button" value="등록" onclick="location.href='boardWrite.jsp';" />
	</td>
</tr>
</table>
</form>
<br/>
<div style="font-size: 13pt; color: red;">
	EL 표현법 : <%="${total}"%> ${total}<br/>
	스크립틀릿 : <%="request.getAttribute(\"total\")"%> <%=request.getAttribute("total") %>
</div>
<br/>
<table style="border: solid 1px; width: 500px;">
<tr style="background-color: skyblue;">
	<th width="50">No.</th>
	<th width="200">제목</th>
	<th width="80">작성자</th>
	<th width="50">조회수</th>
	<th width="150">등록일자</th>
</tr>
<tr>
	<td colspan="5" align="center">조회된 결과가 없습니다.</td>
</tr>
<tr>
	<td align="center"></td>
	<td><a href="boardView.jsp?no="></a></td>
	<td align="center"></td>
	<td align="center"></td>
	<td align="center"></td>
</tr>
</table>
</body>
</html>