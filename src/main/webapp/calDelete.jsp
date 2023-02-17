<%@page import="dao.CalendarDao"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
int seq = Integer.parseInt( request.getParameter("seq") );
%>

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
</head>
<body>
<%
CalendarDao dao = CalendarDao.getInstance();
// CalendarDto dto = dao.getDay(seq);
boolean isSuc = dao.calDelete(seq);

if(isSuc){
%>
<script type="text/javascript">
alert("일정이 삭제되었습니다");
location.href = "calendar.jsp";
</script>
<%}else{
%>
	<script type="text/javascript">
		alert("일정삭제에 실패하였습니다.");
		location.href = "calendar.jsp";
	</script>
<%
}
%>




</body>
</html>