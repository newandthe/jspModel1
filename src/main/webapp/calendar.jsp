<%@page import="dto.CalendarDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.CalendarDao"%>
<%@page import="util.CalendarUtil"%>
<%@page import="java.util.Calendar"%>
<%@page import="dto.MemberDto"%>
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
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
a{
	text-decoration: none;
}
a:hover{
	text-decoration: underline;
}
.caltable {
  border : 1px solid #3c3c3c;
  border-collapse : collapse;
}
</style>

</head>
<body>

<h1>일정관리</h1>

<hr>
<br>
<%
	Calendar cal = Calendar.getInstance();
	cal.set(Calendar.DATE, 1);	// 1일로 설정

	String syear = request.getParameter("year");  // --  2023
	String smonth = request.getParameter("month");
	
	
	int year = cal.get(Calendar.YEAR);
	if(CalendarUtil.nvl(syear) == false){	// 넘어온 파라미터가 있음
		year = Integer.parseInt(syear);
	}	
	int month = cal.get(Calendar.MONTH) + 1; // 0 ~ 11까지 이므로 +1을 해 줘야한다
	if(CalendarUtil.nvl(smonth) == false){  // 넘어온 파라미터가 있음
		month = Integer.parseInt(smonth);
	}
	
	System.out.println("month:" + month);
	
	if(month < 1){
		month = 12;
		year--;
	}
	if(month > 12){
		month = 1;
		year++;
	}
	
	cal.set(year, month-1, 1);
	
	// 요일
	int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
	
	// << year--
	String pp = String.format("<a href='calendar.jsp?year=%d&month=%d' style='text-decoration: none'>"
							 + "  <img src='images/left.gif' width='20px' height='20px'>"
							+ "</a>", 					year-1, month); // a태그를 클릭하면 들어 갈 값
	
	// < month--
	String p = String.format("<a href='calendar.jsp?year=%d&month=%d' style='text-decoration: none'>"
							 + "  <img src='images/prec.gif' width='20px' height='20px'>"
							+ "</a>", 					year, month-1);
	
	// > month++
	String n = String.format("<a href='calendar.jsp?year=%d&month=%d' style='text-decoration: none'>"
							 + "  <img src='images/next.gif' width='20px' height='20px'>"
							+ "</a>", 					year, month+1);
	
	// >> year++
	String nn = String.format("<a href='calendar.jsp?year=%d&month=%d' style='text-decoration: none'>"
			 				+ "  <img src='images/last.gif' width='20px' height='20px'>"
						   + "</a>", 					year+1, month);
	
	// DB
	CalendarDao dao = CalendarDao.getInstance();
	
	List<CalendarDto> list = dao.getCalendarList(login.getId(), year + CalendarUtil.two(month + ""));
%>


<div align="center">

<table border="1" class="caltable">
<col width="120"><col width="120"><col width="120"><col width="120">
<col width="120"><col width="120"><col width="120">

<tr height="80">
	<td colspan="7" align="center">
		<%=pp %>&nbsp;<%=p %>&nbsp;&nbsp;&nbsp;&nbsp;
		
		<font style="color:#3c3c3c;font-size: 40px;font-family: fantasy">
			<%=String.format("%d년&nbsp;&nbsp;%2d월", year, month) %>
		</font>
		
		&nbsp;&nbsp;&nbsp;&nbsp;<%=n %>&nbsp;<%=nn %>
	</td>
</tr>

<tr height="30" style="background-color: #000; color: white;">
	<th>sun</th>
	<th>mon</th>
	<th>tus</th>
	<th>wed</th>
	<th>thu</th>
	<th>fri</th>
	<th>sat</th>
</tr>

<tr height="100" align="left" valign="top">
<%
// 윗쪽빈칸
for(int i = 1;i < dayOfWeek; i++){
	%>
	<td style="background-color: #eeeeee">&nbsp;</td>
	<%
}

// 날짜
int lastday = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
for(int i = 1;i <= lastday; i++){
	%>
	<td style="color: #3c3c3c;padding-top: 5px">	
		<%=CalendarUtil.callist(year, month, i) %>&nbsp;&nbsp;<%=CalendarUtil.calwrite(year, month, i) %>
		<%=CalendarUtil.makeTable(year, month, i, list) %>
	</td>
	<%
	if((i + dayOfWeek -1) % 7 == 0 && i != lastday){
		%>	
		</tr><tr height="100" align="left" valign="top">
		<%
	}	
}

// 아래쪽 빈칸
cal.set(Calendar.DATE, lastday);
int weekday = cal.get(Calendar.DAY_OF_WEEK);
for(int i = 0;i < 7 - weekday; i++){
	%>
	<td style="background-color: #eeeeee">&nbsp;</td>
	<%	
}
%>
</tr>
</table>
</div>




</body>
</html>




