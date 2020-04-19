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

	String mode = request.getParameter("mode");
	String no = request.getParameter("no");
	String subject = request.getParameter("subject");
	String writer = request.getParameter("writer");
	String contents = request.getParameter("contents");
	String registIp = request.getRemoteHost();

Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
String sql = "";
try {
	conn = DriverManager.getConnection(
		"jdbc:oracle:thin:@localhost:1521:xe", 
		"stone", 
		"1234"
	);
	stmt = conn.createStatement();
	
	int result = 0;
	
	if ("W".equals(mode)) {
		stmt.executeQuery("SELECT NVL(MAX(NO), 0)+1 FROM BOARD");
		rs = stmt.getResultSet();
		rs.next();
		sql = "INSERT INTO BOARD (" + 
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
			")"; 
		result = stmt.executeUpdate(sql);
	} else if ("M".equals(mode)) {
		sql = "UPDATE BOARD SET " + 
				"SUBJECT = '" + subject + "'," +
				"NAME = '" + writer + "'," +
				"CONTENTS = '" + contents + "'," +
				"CHANGE_DT = SYSDATE," +
				"CHANGE_IP = '" + registIp + "' " +
			"WHERE NO = " + no;
		result = stmt.executeUpdate(sql);
	} else if ("D".equals(mode)) {
		sql = "DELETE FROM BOARD WHERE NO = " + no;
		result = stmt.executeUpdate(sql);
	}
	System.out.println(sql);

	if (result > 0) {
		if ("M".equals(mode)) {
			out.println("<script>alert('성공'); location.href='boardView.jsp?no=" + no +"';</script>");
		} else {
			out.println("<script>alert('성공'); location.href='boardList.jsp';</script>");
		}
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