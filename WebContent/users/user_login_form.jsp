<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 하기</title>
</head>
<body>
	<h2>LOGIN</h2>
	<form action="user_login_ok.jsp" method="post">
		<input type="text" name="id" placeholder="ID"/><br>
		<input type="password" name="upw" placeholder="PW"/><br>
		<input type="submit" value="로그인"/><br>
		<a href="users_join_form.jsp">회원가입</a>
	</form>
	
</body>
</html>