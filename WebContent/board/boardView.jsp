<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	try {
		
		String no = request.getParameter("no");
		no = no == null ? "" : no;
		System.out.println("PARAMETER NO : " + no);

		conn = DriverManager.getConnection(
			"jdbc:oracle:thin:@localhost:1521:xe", 
			"stone", 
			"1234"
		);
		
		stmt = conn.createStatement();
		String readCntSql = "UPDATE BOARD SET READ_CNT = READ_CNT + 1 WHERE NO = " + no;
		stmt.executeQuery(readCntSql);
		System.out.println("UPDATE SQL : " + readCntSql);
		
		String viewSql = "SELECT * FROM BOARD WHERE NO = " + no;
		stmt.executeQuery(viewSql);
		System.out.println("VIEW SQL : " + viewSql);
		rs = stmt.getResultSet();
		rs.next();

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>blog.naver.com/musasin84 - 게시판 보기</title>
	<style type="text/css">
		* {font-size: 9pt; font-family: 굴림;}
		tr, td, th {border: solid 1px;}
	</style>
	<script type="text/javascript">
		function goDelete() {
			if (confirm("정말 삭제하시겠습니까?")) { 
				location.href = 'boardProcess.jsp?no=<%=rs.getString("NO")%>&mode=D';
			}
		}
	</script>
</head>
<body>
<h1>게시판 보기</h1>
<table style="border: solid 1px;">
<tr>
	<td>제목</td>
	<td><%=rs.getString("SUBJECT") %></td>
</tr>
<tr>
	<td>작성자</td>
	<td><%=rs.getString("NAME") %></td>
</tr>
<tr>
	<td>작성일자</td>
	<td><%=rs.getString("REGIST_DT") %></td>
</tr>
<tr>
	<td>작성자 IP</td>
	<td><%=rs.getString("REGIST_IP") %></td>
</tr>
<tr>
	<td>조회수</td>
	<td><%=rs.getString("READ_CNT") %></td>
</tr>
<tr>
	<td>내용</td>
	<td>
	<%
		out.print(rs.getString("CONTENTS").replace("\r\n","<br/>")); 
	%>
	</td>
</tr>
<tr>
	<td>수정일자</td>
	<td><%=rs.getString("CHANGE_DT") %></td>
</tr>
<tr>
	<td>수정자 IP</td>
	<td><%=rs.getString("CHANGE_IP") %></td>
</tr>
<tr>
	<td colspan="2" align="right">
		<input type="button" value="목록" onclick="location.href='boardList.jsp';" />
		<input type="button" value="수정" onclick="location.href='boardModify.jsp?no=<%=rs.getString("NO") %>';" />
		<input type="button" value="삭제" onclick="goDelete();" />
	</td>
</tr>
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