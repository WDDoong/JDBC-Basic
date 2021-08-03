<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String uid = request.getParameter("id");
	String upw = request.getParameter("upw");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 성공</title>
</head>
<body>
<%
	if(uid.equals("kkk1234") && upw.equals("1111")){
		session.setAttribute("log_id", uid);
		session.setAttribute("log_pw", upw);
		
	}else{
		response.sendRedirect("user_login_fail.jsp");
	}
%>
	<h2><%=uid %>님 환영합니다.</h2>
</body>
</html>