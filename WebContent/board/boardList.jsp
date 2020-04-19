<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	Connection conn = null;
	Statement stmt = null;
	ResultSet totalRs = null;
	ResultSet listRs = null;
	try {
		
		String searchField = request.getParameter("searchField");
		String searchText = request.getParameter("searchText");
		searchField = searchField == null ? "" : searchField;
		searchText = searchText == null ? "" : searchText;
		
		System.out.println("PARAMETER SEARCHFIELD : " + searchField);
		System.out.println("PARAMETER SEARCHTEXT : " + searchText);

		conn = DriverManager.getConnection(
			"jdbc:oracle:thin:@localhost:1521:xe", 
			"stone", 
			"1234"
		);
		
		String whereSql = "";
		if (!"".equals(searchField)) {
			whereSql += " WHERE " + searchField + " LIKE '%" + searchText + "%'";
		} else if ("".equals(searchField) && !"".equals(searchText)) {
			whereSql += " WHERE SUBJECT LIKE '%" + searchText + "%' OR CONTENTS LIKE '%" + searchText + "%'";
		}
		String totalSql = "SELECT COUNT(*) AS TOTAL FROM BOARD" + whereSql;
		
		stmt = conn.createStatement();
		stmt.executeQuery(totalSql);
		System.out.println("COUNT SQL : " + totalSql);
		totalRs = stmt.getResultSet();
		totalRs.next();
		int total = totalRs.getInt("TOTAL");
		
		String listSql = "SELECT * FROM BOARD" + whereSql;
		listSql += " ORDER BY REGIST_DT DESC";
		stmt.executeQuery(listSql);
		System.out.println("LIST SQL : " + listSql);
		listRs = stmt.getResultSet();

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
<h1>게시판 목록 (blog.naver.com/musasin84)</h1>
<form name="searchForm" action="boardList.jsp" method="get">
<table style="border: solid 1px; width: 500px; margin-bottom: 5px;">
<tr>
	<td>
		<select name="searchField" style="width: 98%">
			<option value="" <%if ("".equals(searchField)) { out.print("selected=\"selected\"");} %>>전체</option>
			<option value="SUBJECT" <%if ("SUBJECT".equals(searchField)) { out.print("selected=\"selected\"");} %>>제목</option>
			<option value="CONTENTS" <%if ("CONTENTS".equals(searchField)) { out.print("selected=\"selected\"");} %>>내용</option>
		</select>
	</td>
	<td>
		<input type="text" name="searchText" value="<%=searchText %>" style="width: 98%" />
	</td>
	<td>
		<input type="submit" value="검색" />
		<input type="button" value="등록" onclick="location.href='boardWrite.jsp';" />
	</td>
</tr>
</table>
</form>
<table style="border: solid 1px; width: 500px;">
<tr style="background-color: skyblue;">
	<th width="50">No.</th>
	<th width="200">제목</th>
	<th width="80">작성자</th>
	<th width="50">조회수</th>
	<th width="150">등록일자</th>
</tr>
<%
	if (total == 0) {
%>
<tr>
	<td colspan="5" align="center">조회된 결과가 없습니다.</td>
</tr>
<%
	} else {
	int lineNum = 0;
	while(listRs.next()) {
		lineNum++;
%>
<tr>
	<td align="center"><%=lineNum%></td>
	<td><a href="boardView.jsp?no=<%=listRs.getString("NO")%>"><%=listRs.getString("SUBJECT")%></a></td>
	<td align="center"><%=listRs.getString("NAME")%></td>
	<td align="center"><%=listRs.getString("READ_CNT")%></td>
	<td align="center"><%=listRs.getString("REGIST_DT")%></td>
</tr>
<% } } %>
</table>
</body>
</html>
<%
	} catch (SQLException e) {
		out.println(e.getMessage());
	} finally {
		if (totalRs != null) totalRs.close();
		if (listRs != null) listRs.close();
		if (stmt != null) stmt.close();
		if (conn != null) conn.close();
	}
%>