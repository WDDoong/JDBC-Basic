<%@page import="kr.co.ictedu.UsersVO"%>
<%@page import="kr.co.ictedu.UsersDAO"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// DB연동 이전에 먼저 users_join_form에서 날려주는 데이터를 받아서 저장해줍니다.
	request.setCharacterEncoding("UTF-8");

	String uid = (String)request.getParameter("id");
	String upw = (String)request.getParameter("upw");
	String uname = (String)request.getParameter("uname");
	String email = (String)request.getParameter("email");

	// 기존에 있던 회원가입 로직은 DAO클래스로 이관합니다.
	// DAO클래스 받아오기
	UsersDAO dao = UsersDAO.getInstance();
	
	// VO객체 생성 및 uid, upq, uname, email setter로 입력해주기
	UsersVO user = new UsersVO(uid, upw, uname, email);
	
	dao.joinUsers(user);
%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>
</head>
<body>
	<h2>회원가입이 완료되었습니다.</h2>
	<a href="user_login_form.jsp">로그인하러 가기</a>
</body>
</html>