<%@page import="kr.co.ictedu.UsersVO"%>
<%@page import="kr.co.ictedu.UsersDAO"%>
<%@page import="org.apache.tomcat.dbcp.dbcp2.DriverManagerConnectionFactory"%>
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	//DB쪽 데이터
	String uid = request.getParameter("id");
	String upw = request.getParameter("upw");
	
	String idSession = (String)session.getAttribute("id_session");
	// 이미 로그인이 되어 있는 유저
	if(idSession != null){
		uid = idSession;
	} else {
		// 1. DAO 생성
		UsersDAO dao = UsersDAO.getInstance();
		
		// 2. UsersVO를 생성하고 DB 아이디&비밀번호 검사
		UsersVO user = new UsersVO();
		user.setId(uid);
		user.setUpw(upw);
		
		// 3. DAO의 userLogin 기능을 호출하면서 파라미터로 적절한 자료를 넘겨주세요.
		// int logResultNum 결과정보 확인을 위한 변수
		int loginResultNum = dao.userLogin(user, uid, upw);
		
		// 4. ID&PW 세션 부여
		if(loginResultNum == 1) {
			session.setAttribute("id_session", uid);
			session.setAttribute("pw_session", upw);
		} else if(loginResultNum == 0) {
			response.sendRedirect("user_login_fail.jsp");
		}
	
	}

	
		
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 성공</title>
</head>
<body>

	<h2><%=uid %>님 환영합니다.</h2>
	<h2>로그인이 완료 되었습니다.</h2>
	<a href="user_logout.jsp">로그아웃 하기</a><br/>
	<a href="user_delete_form.jsp">회원탈퇴</a><br/>
	<a href="user_update_form.jsp">회원정보 수정</a><br/>
	<a href="user_get_all.jsp">회원 전체 목록 보기</a>
</body>
</html>