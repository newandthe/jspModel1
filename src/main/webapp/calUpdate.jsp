<%@page import="util.CalendarUtil"%>
<%@page import="dto.MemberDto"%>
<%@page import="dto.CalendarDto"%>
<%@page import="dao.CalendarDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
MemberDto login = (MemberDto)session.getAttribute("login");
if(login == null){
	%>
	<script>
	alert('로그인 해 주십시오');
	location.href = "login.jsp";
	</script>
	<%
}	
%>  
<%
int seq = Integer.parseInt( request.getParameter("seq") );
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
CalendarDao dao = CalendarDao.getInstance();
// CalendarDto dto = dao.getDay(seq);
%>
<h2>일정수정</h2>
<div align="center">
<form action="calUpdateAf.jsp" method="post">
<table border="1">
<col width="200"><col width="500">
<tr>
	<th>아이디</th>
	<td>
		<%=login.getId() %>
		<input type="hidden" name="id" value="<%=login.getId() %>">
		<input type="hidden" name="seq" value="<%=seq%>">
	</td>
</tr>
<tr>
	<th>제목</th>
	<td>
		<input type="text" name="title" size="80">
	</td>
</tr>
<tr>
	<th>일정</th>
	<td>
		<input type="date" name="date" id="date">&nbsp;
		<input type="time" name="time" id="time">
		
	</td>
</tr>
<tr>
	<th>내용</th>
	<td>
		<textarea rows="20" cols="80" name="content"></textarea>
	</td>
</tr>
<tr>
	<td colspan="2" align="center">
		<input type="submit" value="일정수정">
	</td>
</tr>
</table>
</form>
</div>

</body>
</html>