<%@page import="util.CalendarUtil"%>
<%@page import="dto.CalendarDto"%>
<%@page import="dao.CalendarDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
CalendarDto dto = dao.getDay(seq);


%>
<h2>일정보기</h2>
<hr>
<br>
<div align="center">
<table border="1">
<col width="200"><col width="500">
<tr>
	<th>아이디</th>
	<td><%=dto.getId() %></td>
</tr>
<tr>
	<th>제목</th>
	<td><%=dto.getTitle() %></td>
</tr>
<tr>
	<th>일정</th>
	<td><%=CalendarUtil.toDates(dto.getRdate()) %></td>
</tr>
<tr>
	<th>내용</th>
	<td>
		<%=dto.getContent() %>
	</td>
</tr>
</table>
<br>

<button type="button" onclick="calUpdate(<%=dto.getSeq() %>)">수정</button>
<button type="button" onclick="calDelete(<%=dto.getSeq() %>)">삭제</button>

</div>

<script type="text/javascript">
function calUpdate(seq) {
	location.href = "calUpdate.jsp?seq=" + seq;
}
function calDelete(seq) {
	location.href = "calDelete.jsp?seq=" + seq;
}
</script>
</body>
</html>