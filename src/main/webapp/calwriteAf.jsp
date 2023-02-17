<%@page import="dto.CalendarDto"%>
<%@page import="dao.CalendarDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
request.setCharacterEncoding("utf-8");

String id = request.getParameter("id");
String title = request.getParameter("title");
String content = request.getParameter("content");

String date = request.getParameter("date");
String time = request.getParameter("time");

// 2023-02-16
// 15-14
String datesplit[] = date.split("-");
String year = datesplit[0];
String month = datesplit[1];
String day = datesplit[2];

String timesplit[] = time.split(":");
String hour = timesplit[0];
String min = timesplit[1];

String rdate = year + month + day + hour + min;
System.out.println(rdate);

CalendarDao dao = CalendarDao.getInstance();
boolean isSuc = dao.addCalendar(new CalendarDto(id, title, content, rdate));
if(isSuc){
%>
<script type="text/javascript">
alert("일정이 추가되었습니다");
location.href = "calendar.jsp";
</script>
<%
} else {
	%>
	<script type="text/javascript">
		alert("일정추가에 실패하였습니다.");
		location.href = "calwrite.jsp?year=" + year + "&month=" + month + "&day=" + day;
	</script>
	<%
}
%>