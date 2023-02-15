<%@page import="dao.BbsDao"%>
<%@page import="dto.BbsDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
request.setCharacterEncoding("utf-8");

int seq = Integer.parseInt( request.getParameter("seq"));

String id = request.getParameter("id");
String title = request.getParameter("title");
String content = request.getParameter("content");

BbsDao dao = BbsDao.getInstance();

boolean isSuc = dao.delete(seq, new BbsDto(id, title, content));

if(isSuc){
	%>
	<script>
	alert("삭제 성공!");
	location.href = "bbslist.jsp";
	</script>
	<%
}else{
	%>
	<script>
	alert("삭제 실패 ㅠㅠ");
	location.href = "bbslist.jsp";
	</script>
	<%
}
%>
    
