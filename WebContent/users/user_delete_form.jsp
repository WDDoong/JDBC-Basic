<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//로그인 상태에서만 이 페이지를 볼 수 있도록 조회
	String idSession = (String)session.getAttribute("id_session");
	if(idSession == null) {
		response.sendRedirect("user_login_form.jsp");
	}
%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>탈퇴하기</h2>
<form action="user_delete_ok.jsp" method="post">
	<input type="password" name="delPw" placeholder="비밀번호를 입력해주세요." required><br/>
	<input type="submit" value="탈퇴">
</form>
</body>
</html>