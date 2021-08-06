<%@page import="kr.co.ictedu.UsersVO"%>
<%@page import="kr.co.ictedu.UsersDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 1. 세션을 통해 아이디를 가져옵니다.
	// 	만약 로그인 상태가 아니라면 로그인창으로 리다이렉트 합니다.
	String idSession = (String)session.getAttribute("id_session");

	if(idSession == null){
		response.sendRedirect("user_login_form.jsp");
	}
	// 2. dao를 통해 UsersVO를 가져와야 합니다.
	UsersDAO dao = UsersDAO.getInstance();
	UsersVO user = new UsersVO();	//데이터 전송을 위해 
	user.setId(idSession);	//아이디를 입력함.
	
	
	
	// 3. 들고온 UsersVO를 이용해 아래 html태그의 value속성에 표현식을 이용해
	// 	  UsersVO의 아이디, 이름, 이메일을 기입하게 만들어줍니다.
	UsersVO resultData = dao.getUserInfo(user);
	
	// reslutData내부의 데이터가 null인 경우는 조회가 실패한 경우이므로 다시 로그인 창으로 
	if(resultData.getId() == null) {
		session.invalidate();
		response.sendRedirect("user_login_form.jsp");
	}

%>   
   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정 페이지</title>
</head>
<body>
	<!-- readonly(변경불가)  required(입력필수) -->
	<h2>회원정보 수정 페이지</h2>
	<form action="user_update_ok.jsp" method="post">
		<input type="text" name="uid" value="<%= user.getId() %>" placeholder="아이디" readonly required/><br>
		<input type="password" name="upw" placeholder="비밀번호" required/><br>
		<input type="text" name="uname" value="<%= resultData.getUname() %>" placeholder="이름" required/><br>
		<input type="email" name="email" value="<%= resultData.getEmail() %>" placeholder="이메일"/><br>
		<input type="submit" value="회원정보 수정"/><br>
	</form>
</body>
</html>