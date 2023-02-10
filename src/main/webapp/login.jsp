<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script src="http://lab.alexcican.com/set_cookies/cookie.js" type="text/javascript" ></script>

<style type="text/css">
.center{
	/* 임시 로그인화면 */

	margin: auto;
	width: 60%;
	border: 3px solid #ff0000;
	padding: 10px;
}
</style>

</head>
<body>

<h2>login page</h2>

<div class="center">

<form action="loginAf.jsp" method="post">

<table border="1">
<tr>
	<th>아이디</th>
	<td>
		<input type="text" id="id" name="id" size="20"><br>
		<input type="checkbox" id="chk_save_id">id 저장
	</td>
</tr>
<tr>
	<th>패스워드</th>
	<td>
		<input type="password" name="pwd" size="20">
	</td>
</tr>
<tr>
	<td colspan="2">
		<input type="submit" value="log-in">
		<a href="regi.jsp">회원가입</a>
	</td>
</tr>
</table>
</form>
</div>

<script type="text/javascript">
/*
	cookie : id 저장, pw저장에 사용. == > String 형태로 저장 (Client)
	session : login한 정보에 사용.  == > Object 형태로 저장 (Server)
 */
 
 let user_id = $.cookie("user_id");	// "user_id"는 단순 문자열. 사용자 지정
	
 if(user_id != null){	// 저장한 ID가 있을 경우.
	 $("#id").val(user_id);
 	 $("#chk_save_id").prop("checked", true);
 }
 
 $("#chk_save_id").click(function() {
 	if( $("#chk_save_id").is(":checked") == true ){	// id저장에 체크 되어있다면
		// alert('true');
 		if( $("#id").val().trim() == "" ){	// id 입력공간이 빈칸이라면
 			alert('id를 입력해 주십시오.');
 		$("#chk_save_id").prop("checked", false);	// 빈상태에서 체크시도하면 알림 후 체크 안됨.
 		}else{
 		// cookie를 저장하는 부분이다.
 		$.cookie("user_id", $("#id").val().trim(), { expires:7, path:'/' });	
 		// user_id 값에 입력한 id값을 넣고 기한(7일)과 경로를 정해준 것. /는 모든 경로를 의미.
 		// 각각의 클라이언트에 저장된다.
 		// 개발자 도구의 Application에서 확인이 가능하다.
 		}
 	} 
 	else{
 		// alert('false');
 		$.removeCookie("user_id", { path:'./' });	// expires와 path 생략 가능
 	}
 });
</script>



</body>
</html>