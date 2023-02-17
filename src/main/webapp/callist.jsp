<%@page import="dto.MemberDto"%>
<%@page import="dto.CalendarDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.CalendarDao"%>
<%@page import="util.CalendarUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 로그인 정보 검사
	MemberDto login = (MemberDto)session.getAttribute("login");

	if(login == null){	// 로그인이 되어있지 않다면( session이 없다면 )
		%>
		<script>
		alert('로그인 해 주십시오');
		location.href = "login.jsp";
		// 로그인이 안되어 있는 경우
		</script>
		<%
	}
%>      
<%
String year = request.getParameter("year");
String month = request.getParameter("month");
String day = request.getParameter("day");

String yyyymmdd = year + CalendarUtil.two(month + "") + CalendarUtil.two(day + "");
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
List<CalendarDto> list = dao.getDayList(login.getId(), yyyymmdd);
%>

<h2><%=year %>년 <%=month %>월 <%=day %>일의 일정</h2>
<hr>
<br>

<div align="center">
<table border="1">
<col width="100"><col width="450"><col width="300">
<tr>
	<th>번호</th><th>제목</th><th>시간</th>
</tr>
<%
for(int i=0; i<list.size(); i++){
	CalendarDto dto = list.get(i);
	%>
	<tr>
		<th><%=i+1 %></th>
		<td><a href="caldetail.jsp?seq=<%=dto.getSeq() %>"><%=dto.getTitle() %></a></td>
		<td><%=CalendarUtil.toDates(dto.getRdate()) %></td>
	</tr>
	<%
}

%>
</table>
</div>

<button type="button" onclick="location.href='calendar.jsp'">일정관리</button>


</body>
</html>