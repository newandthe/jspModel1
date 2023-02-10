<%@page import="dto.MemberDto"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	request.setCharacterEncoding("utf-8");	
	// DB에 한글을 기입할 경우 이게 없으면 깨집니다.

	String id = request.getParameter("id");	// post라 보이지 않은상태로
	String pwd = request.getParameter("pwd");
	String name = request.getParameter("name");
	String email = request.getParameter("email");

	// 회원가입의 정보가 넘어왔을때.. DB에 회원 정보를 추가 해야한다..!
	MemberDao dao = MemberDao.getInstance();
	
	MemberDto dto = new MemberDto(id, pwd, name, email, 0);
	boolean isSuccess = dao.addMember(dto);
	
	if(isSuccess){
		%>
			<script type="text/javascript">
			alert("성공적으로 가입되었습니다.");
			location.href = "login.jsp";
			</script>
		<%
	}else{
		%>
			<script type="text/javascript">
			alert("다시 가입해 주십시오");
			location.href = "regi.jsp";
			</script>
		<%
	}
%>