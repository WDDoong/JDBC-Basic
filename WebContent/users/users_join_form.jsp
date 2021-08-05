<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>
</head>
<body>
	<!-- 아이디, 비밀번호, 이름, 이메일 4개 요소를 users_join.jsp로 보내주는 form을 작성하세요. post방식으로 전달합니다.
		보내는 input태그의 name속성은 컬럼명과 일치시켜주세요.--> 
	<h2>회원가입</h2>
	<form action="users_join.jsp" method="post">
		<input type="text" name="id" placeholder="ID" required><br/>
		<input type="password" name="upw" placeholder="PW" required><br/>
		<input type="text" name="uname" placeholder="이름" required><br/>
		<input type="email" name="email" placeholder="e-mail" required><br/>
		<input type="submit" value="가입하기">
		
	</form>
</body>
</html>