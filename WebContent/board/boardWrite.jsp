<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>blog.naver.com/musasin84 - 게시판 등록</title>
<style type="text/css">
* { font-size: 9pt; font-family: 굴림;}
</style>
<script type="text/javascript">
	function goList() {
		location.href = 'boardList.jsp';
	}
	function goWrite() {
		var form = document.writeForm;
		
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
		if (confirm("등록하시겠어요?")) {
			form.submit();
		}
		return false;

	}
	
</script>
</head>
<body>
<h1>게시판 등록</h1>
<form action="boardProcess.jsp" method="post" name="writeForm">
<input type="hidden" name="mode" value="W" />
<table style="border: solid 1px;">
<tr>
	<td>제목</td>
	<td><input type="text" name="subject" size="30" /></td>
</tr>
<tr>
	<td>작성자</td>
	<td><input type="text" name="writer" size="10" /></td>
</tr>
<tr>
	<td>내용</td>
	<td>
		<textarea name="contents" cols="28" rows="10"></textarea>
	</td>
</tr>
<tr>
	<td colspan="2" align="right">
		<input type="button" value="목록" onclick="goList();" />
		<input type="button" value="등록" onclick="goWrite();" />
	</td>
</tr>
</table>
</form>
</body>
</html>