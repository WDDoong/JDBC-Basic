<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//5. user_update_fail.jsp은 body태그 내에 
	//	  수정이 완료되지 못했습니다. 다시 시도해주세요.
	//	 라는 메세지와 그 아래에 로그인폼으로 리다이렉트 시켜줍니다.
	session.invalidate();
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>회원정보 수정이 완료되지 못했습니다.</h2><br/>
	<h3>다시 시도해주세요.</h3><br/>
	<a href="user_login_form.jsp">로그인 창으로 돌아가기.</a>
</body>
</html>