<%@page import="dao.BbsDao"%>
<%@page import="dto.BbsDto"%>
<%@page import="java.util.List"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
int seq = Integer.parseInt(request.getParameter("seq"));

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
	
	BbsDao dao = BbsDao.getInstance();
	
	dao.ReadCNT(seq);	// 카운트 증가 (조회수)
	BbsDto dto = dao.getBbs(seq);
	// 시퀀스 가져오기
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


<div align="center">
<h1>상세 글보기</h1>
<table border="1">
<colgroup>
	<col style="width: 200px"/>
	<col style="width: 200px"/>
</colgroup>


<thead>
<tr>
	<th> 작성자</th> <td><%=dto.getId() %></td>
</tr>
<tr>
	<th> 제목</th> <td><%=dto.getTitle() %></td>
</tr>
<tr>
	<th> 작성일</th> <td><%=dto.getWdate() %></td>
</tr>
<tr>
	<th> 조회수</th> <td><%=dto.getReadcount() %></td>
</tr>
<tr>
	<th> 답글정보</th> <td><%=dto.getRef() %>-<%=dto.getStep() %>-<%=dto.getDepth() %></td>
</tr>
<tr>
	<th> 내용</th> <td><textarea rows="10" cols="100"><%=dto.getContent() %></textarea></td>
</tr>
</thead>
<tbody>
</tbody>
</table>
<br><br>

<button type="button" onclick="answerBbs(<%=dto.getSeq()%>)">답글</button>

<button type="button" onclick="location.href='bbslist.jsp'">글목록</button>

<%
if(login.getId().equals(dto.getId())){	// 로그인한 경우만 수정과 삭제가 보인다.
	
%>


<button type="button" onclick="updateBbs(<%=dto.getSeq() %>)">수정</button>

<button type="button" onclick="deleteBbs(<%=dto.getSeq() %>)">삭제</button>
<%
}
%>
</div>

<script type="text/javascript">
function answerBbs( seq ){
	location.href = "answer.jsp?seq=" + seq;
}
function updateBbs( seq ){
	location.href = "updateBbs.jsp?seq=" + seq;
}
function deleteBbs( seq ){
	location.href = "deleteBbs.jsp?seq=" + seq;
}

// readcount 증가

</script>

</body>
</html>