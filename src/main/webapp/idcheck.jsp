<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String id = request.getParameter("id");
	System.out.println("id: " + id);
	
	MemberDao dao = MemberDao.getInstance();
	boolean b = dao.getId(id);
	
	if(b == true){	// 중복 id가 존재하는 경우
		out.println("Can't use");
	}else{		// 중복 id가 존재하지 않는 경우
		out.println("Can use");
	}
%>