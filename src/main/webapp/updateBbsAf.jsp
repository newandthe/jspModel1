<%@page import="dto.BbsDto"%>
<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
request.setCharacterEncoding("utf-8");

int seq = Integer.parseInt( request.getParameter("seq"));

String id = request.getParameter("id");
String title = request.getParameter("title");
String content = request.getParameter("content");

BbsDao dao = BbsDao.getInstance();

boolean isSuc = dao.update(seq, new BbsDto(id, title, content));

if(isSuc){
	%>
	<script>
	alert("수정 성공!");
	location.href = "bbslist.jsp";
	</script>
	<%
}else{
	%>
	<script>
	alert("수정 실패 ㅠㅠ");
	let seq = "<%=seq %>";
	location.href = "updateBbs.jsp?seq=" + seq;
	</script>
	<%
}
%>
