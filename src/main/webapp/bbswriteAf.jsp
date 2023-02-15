<%@page import="dto.BbsDto"%>
<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	request.setCharacterEncoding("utf-8");	

	String id = request.getParameter("id");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	// DB에 넣어주는 작업 하기.
	BbsDao dao = BbsDao.getInstance();
	
	boolean isSuc = dao.writeBbs( new BbsDto(id, title, content) );
	
	if(isSuc){	// isSuc == true
		%>
		<script type="text/javascript">
		alert("추가되었습니다.");
		location.href = "bbslist.jsp";
		</script>
		<%
	}else{
		%>
		<script type="text/javascript">
		alert("다시 작성해 주십시오");
		location.href = "bbswrite.jsp";
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
</body>
</html>