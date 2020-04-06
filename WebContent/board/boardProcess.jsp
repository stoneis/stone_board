<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>blog.naver.com/musasin84 - 게시판 처리</title>
</head>
<body>
<%
	//form method "POST" 인 경우 한글깨짐 처리를 위함
	request.setCharacterEncoding("UTF-8");


	String subject = request.getParameter("subject");
	String writer = request.getParameter("writer");
	String contents = request.getParameter("contents");
	String registIp = request.getRemoteHost();

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
	stmt.executeQuery("SELECT NVL(MAX(NO), 0)+1 FROM BOARD");
	rs = stmt.getResultSet();
	rs.next();
	
	int result = stmt.executeUpdate(
		"INSERT INTO BOARD (" + 
			"NO, SUBJECT, NAME, READ_CNT," + 
			"CONTENTS, REGIST_DT, REGIST_IP" + 
		") VALUES (" +
			 + rs.getInt(1) + 
			",'" + subject + "'" +
			",'" + writer + "'" +
			",0" +
			",'" + contents + "'" +
			",SYSDATE" +
			",'" + registIp + "'" +
		")");
	
	if (result > 0) {
		out.println("<script>alert('성공'); location.href='boardList.jsp';</script>");
	} else {
		out.println("<script>alert('실패'); location.href='boardList.jsp';</script>");
	}
	
	
} catch (SQLException e) {
	out.println(e.getMessage());
} finally {
	if (rs != null) rs.close();
	if (stmt != null) stmt.close();
	if (conn != null) conn.close();
}

%>
</body>
</html>