<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>blog.naver.com/musasin84 - 게시판 목록</title>
	<style type="text/css">
		* {font-size: 9pt; font-family: 굴림;}
		tr, td, th {border: solid 1px;}
	</style>
</head>
<body>
<h1>게시판 목록</h1>
<table style="border: solid 1px; width: 500px; margin-bottom: 5px;">
<tr>
	<td>
		<select style="width: 98%">
			<option>전체</option>
			<option>제목</option>
			<option>내용</option>
		</select>
	</td>
	<td>
		<input type="text" style="width: 98%" />
	</td>
	<td>
		<input type="button" value="검색" />
		<input type="button" value="등록" />
	</td>
</tr>
</table>
<table style="border: solid 1px; width: 500px;">
<tr>
	<th width="50">No.</th>
	<th width="200">제목</th>
	<th width="80">작성자</th>
	<th width="50">조회수</th>
	<th width="100">등록일자</th>
</tr>
<tr>
	<td colspan="5" align="center">조회된 결과가 없습니다.</td>
</tr>
<tr>
	<td align="center">1</td>
	<td>제목 입니다.</td>
	<td align="center">홍길동</td>
	<td align="center">3</td>
	<td align="center">2020-03-25</td>
</tr>
<tr>
	<td align="center">1</td>
	<td>제목 입니다.</td>
	<td align="center">홍길동</td>
	<td align="center">3</td>
	<td align="center">2020-03-25</td>
</tr>
</table>
</body>
</html>