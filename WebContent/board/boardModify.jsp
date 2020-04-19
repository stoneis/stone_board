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
<title>blog.naver.com/musasin84 - 게시판 수정</title>
<style type="text/css">
* { font-size: 9pt; font-family: 굴림;}
</style>
<script type="text/javascript">
	function goList() {
		location.href = 'boardList.jsp';
	}
	function goModify() {
		var form = document.modifyForm;
		
		if (form.subject.value == "") {
			alert("제목을 입력하세요");
			form.subject.focus();
			return false;
		}
		if (form.writer.value == "") {
			alert("작성자을 입력하세요");
			form.writer.focus();
			return false;
		}
		if (confirm("수정하시겠어요?")) {
			form.submit();
		}
		return false;

	}
	
</script>
</head>
<body>
<h1>게시판 수정</h1>
<form action="boardProcess.jsp" method="post" name="modifyForm">
<input type="hidden" name="mode" value="M" />
<input type="hidden" name="no" value="<%=rs.getString("NO")%>" />
<table style="border: solid 1px;">
<tr>
	<td>제목</td>
	<td><input type="text" name="subject" size="30" value="<%=rs.getString("SUBJECT")%>" /></td>
</tr>
<tr>
	<td>작성자</td>
	<td><input type="text" name="writer" size="10" value="<%=rs.getString("NAME")%>" /></td>
</tr>
<tr>
	<td>내용</td>
	<td>
		<textarea name="contents" cols="28" rows="10"><%=rs.getString("CONTENTS")%></textarea>
	</td>
</tr>
<tr>
	<td colspan="2" align="right">
		<input type="button" value="목록" onclick="goList();" />
		<input type="button" value="수정" onclick="goModify();" />
	</td>
</tr>
</table>
</form>
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