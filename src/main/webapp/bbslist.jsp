<%@page import="dao.BbsDao"%>
<%@page import="dto.BbsDto"%>
<%@page import="java.util.List"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%!
// 답글의 화살표 함수
public String arrow(int depth){
	String img = "<img src='./arrow.png' width='20px' height='20px' />";	
	String nbsp = "&nbsp;&nbsp;&nbsp;&nbsp;";
	
	String ts = "";
	for(int i = 0;i < depth; i++){
		ts += nbsp;
	}
	
	return depth==0?"":ts + img;
}
%>      
    
<%
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
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String choice = request.getParameter("choice");
String search = request.getParameter("search");

if(choice == null){
	choice = "";
}
if(search == null){
	search = "";
}


BbsDao dao = BbsDao.getInstance();

// 현재 페이지 넘버 찾기.
String sPageNumber = request.getParameter("pageNumber");
int pageNumber = 0;
if(sPageNumber != null && !sPageNumber.equals("")){
	pageNumber = Integer.parseInt(sPageNumber);
}

// List<BbsDto> list = dao.getBbsList();
// List<BbsDto> list = dao.getBbsSearchList(choice, search);
List<BbsDto> list = dao.getBbsPageList(choice, search, pageNumber);

// 글의 총 수
int count = dao.getAllBbs(choice, search);

// 페이지의 수
int pageBbs = count / 10;		// 10개씩 총글의 수를 나눔		26 / 10 -> 2
if((count % 10) > 0){	// 6
	pageBbs = pageBbs + 1;		// 2 + 1	
}

%>

<h1>게시판</h1>

<div align="center">

<table border="1">
<col width="70"><col width="600"><col width="100"><col width="150">

<thead>
<tr>
	<th>번호</th> <th>제목</th> <th>조회수</th> <th>작성자</th>
</tr>
</thead>

<tbody>

<%
if(list == null || list.size() == 0){	// 글이 없다면..
%>
	<tr>
		<td colspan="4">작성된 글이 없습니다.</td>	
	</tr>
<%
}else{
	for(int i=0; i<list.size(); i++)
	{
		BbsDto dto = list.get(i);
		%>
		<tr>
			<th><%=i + 1 %></th>
			<td><% if(dto.getDel() == 0){
				%>
				<%=arrow(dto.getDepth()) %>
				<a href="bbsdetail.jsp?seq=<%=dto.getSeq() %>;" onclick="readcnt()">
				<!-- 조회수 -->
				
				<%=dto.getTitle() %></a>
			<%
				} else {
			 %>
			 	<!-- 색이나 배치 원하면 td태그 따로 묶고 디자인 주면 됨. -->
				*** 이글은 관리자에 의해서 삭제되었습니다. 
			 <%}
			%>
			</td>
			
			<td><%=dto.getReadcount() %></td>
			<td><%=dto.getId() %></td>
		</tr>
		<%
	}
}
%>

</tbody>
</table>

<br>

<%
	for(int i = 0;i < pageBbs; i++){
		if(pageNumber == i){	// 현재 페이지
			%>
			<span style="font-size: 15pt;color: #0000ff;font-weight: bold;">
				<%=i+1 %>
			</span>
			<%
		}else{					// 그밖에 다른 페이지
			%>
			<a href="#none" title="<%=i+1 %>페이지" onclick="goPage(<%=i %>)"
				style="font-size: 15pt; color: #000; font-weight: bold; text-decoration: none;">
				[<%=i+1 %>]
			</a>			
			<%
		}		
	}
%>


<br><br>

<select id="choice">
	<option value="">검색</option>
	<option value="title">제목</option>
	<option value="content">내용</option>
	<option value="writer">작성자</option>
</select>

<input type="text" id="search" value="<%=search %>">
									<!-- 값을 유지하기위해 필요한 설정! -->
<button type="button" onclick="searchBtn()">검색</button>

<br>
<a href="bbswrite.jsp">글쓰기</a>

</div>



<script type="text/javascript">

let search = "<%=search %>";	
 // 값을 유지하기 위해 필요한 설정! 밑에는 지역변수라 충돌날 가능성이 없다.
 // console.log("search = " + search);
 if(search != ""){
	 let obj = document.getElementById("choice");
	 obj.value = "<%=choice %>";
	 obj.setAttribute("selected", "selected");
	 // 값을 넣은후 꼭 selected를 설정해야 유지해야한다.
 }

function searchBtn() {
	let choice = document.getElementById("choice").value;
	let search = document.getElementById("search").value;
	
	/* if(choice == ""){
		alert("카테고리를 선택해 주십시오.");
		return;
	}
	
	if(search.trim() == ""){
		alert("검색어를 입력해 주십시오.");
		return;
	} */
	
	location.href = "bbslist.jsp?choice=" + choice + "&search=" + search;
}

function goPage( pageNumber ) {
	let choice = document.getElementById('choice').value;
	let search = document.getElementById('search').value;
	

	
	location.href = "bbslist.jsp?choice=" + choice + "&search=" + search + "&pageNumber=" + pageNumber;	
}

function readcnt(){
	
}


</script>

</body>
</html>