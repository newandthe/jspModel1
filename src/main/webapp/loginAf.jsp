<%@page import="dto.MemberDto"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<%
// name값과 매칭.
// login.jsp를 통해서 id와 pwd가 전달되기 때문.

	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	
	MemberDao dao = MemberDao.getInstance();
	
	MemberDto mem = dao.login(id, pwd);
	
	if(mem != null){
		// 로그인 회원정보를 저장해놓는다. (세션에)
	    // 세션은 얻어오는 방법
	    // 1. request.getSession().setAttribute(name, value)
	    // 2.
	    session.setAttribute("login", mem);
	//	session.setMaxInactiveInterval(60*60*2);	// 세션의 유효기간(필수X)
													// 초 단위
													
													
		// 자바영역
		
		%>
		<script type="text/javascript">
		// 웹영역
		alert("환영합니다.! <%=mem.getId()%> 님");
		// location.href = "";
		</script>
		<%
	}else{
		 %>
		<script type="text/javascript">
		alert("아이디 혹은 패스워드를 확인해 주세요.");
		</script>		 
		 
		 <%
}
 %>