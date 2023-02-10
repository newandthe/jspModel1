<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

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

<h2>회원가입</h2>
<p>환영합니다!</p>

<div class="center">
<form action="regiAfter.jsp" method="post"> <!-- 회원 가입후 이동할 장소 -->

<table border="1">
<tr>
	<td>아이디</td>
	<td>
		<input type="text" name="id" id="id" size="20"><br>
		<p id="idcheck" style="font-size: 8px"></p>	<!-- 아이디 중복 체크 -->
		<input type="button" id="idChkBtn" value="ID 중복확인">
	</td>
</tr>
<tr>
	<td>패스워드</td>
	<td>
		<input type="text" name="pwd" id="pwd" size="20">
	</td>
</tr>
<tr>
	<td>이름</td>
	<td>
		<input type="text" name="name" size="20">
	</td>
</tr>
<tr>
	<td>이메일</td>
	<td>
		<input type="email" name="email" size="20">
	</td>
</tr>
<tr>
	<td colspan="2" align="center">
		<input type="submit" value="회원가입">
	</td>
</tr>

</table>
</form>
</div>


<script type="text/javascript">
$(document).ready(function() {
	$("#idChkBtn").click(function() {
		
		// 원래는 여기에 id의 빈칸 조사를 진행해야 한다!.
		
		$.ajax({
			type:"post",
			url:"idcheck.jsp",
			data:{ "id":$("#id").val() },
			
			success:function(msg){
				/* Message는 사용자 지정 */
				// alert('success');
				// alert(msg.trim());
				
				if(msg.trim() == "Can use"){
					$("#idcheck").css("color", "#0000ff");
					$("#idcheck").text("사용할 수 있는 아이디입니다.");
				}else{
					$("#idcheck").css("color", "#ff0000");
					$("#idcheck").text("사용중인 아이디입니다.");
					$("#id").val("");
				}
			},
			error:function(){
				alert('error');
			}
			
			
		});
	});
});
</script>

</body>
</html>