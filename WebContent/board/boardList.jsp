<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	try {
		conn = DriverManager.getConnection(
			"jdbc:oracle:thin:@localhost:1521:xe", 
			"stone", 
			"1234"
		);
		stmt = conn.createStatement();
		stmt.executeQuery("SELECT * FROM BOARD");
		rs = stmt.getResultSet();

%>
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
<%
	while(rs.next()) {
%>
<tr>
	<td align="center"><%=rs.getString("NO")%></td>
	<td><%=rs.getString("SUBJECT")%></td>
	<td align="center"><%=rs.getString("NAME")%></td>
	<td align="center"><%=rs.getString("READ_CNT")%></td>
	<td align="center"><%=rs.getString("REGIST_DT")%></td>
</tr>
<% } %>
</table>
</body>
</html>
<%
		
	} catch (SQLException e) {
		out.println(e.getMessage());
	} finally {
		if (rs != null) rs.close();
		if (stmt != null) stmt.close();
		if (conn != null) conn.close();
	}
%>