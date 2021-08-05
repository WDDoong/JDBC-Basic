<%@page import="kr.co.ictedu.UsersDAO"%>
<%@page import="kr.co.ictedu.UsersVO"%>
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
	//세션쪽 아이디&비밀번호&사용자가 폼에서 입력한 비밀번호
	String pwSession = (String)session.getAttribute("pw_session");	
	String idSession = (String)session.getAttribute("id_session");
	String delPw = request.getParameter("delPw");
	
	// 1. DAO를 생성하고
	UsersDAO dao = UsersDAO.getInstance();
	
	// 2. UsersVO를 생성하되, pwSession & idSession만 setter로 넣어주세요.
	UsersVO user = new UsersVO();
	user.setId(idSession);
	user.setUpw(pwSession);
	
	// 3. DAO의 usersDelete 기능을 호출하면서 파라미터로 적절한 자료를 넘겨주세요.
	int deleteResultNum = dao.usersDelete(user, delPw);
	
	// 4. 결과에 따라 세션만 파기할지 redirect까지 해줄지 경정
	if(deleteResultNum == 1){
		session.invalidate();
	}else if(deleteResultNum == 0){
		session.invalidate();
		response.sendRedirect("user_login_form.jsp");
	}
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴 페이지</title>
</head>
<body>
	<h1>회원탈퇴가 완료되었습니다.</h1>
	<a href="user_login_form.jsp">삭제 확인 및 돌아가기</a>
</body>
</html>