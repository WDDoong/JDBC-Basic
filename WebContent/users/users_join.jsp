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

	// 연결로직을 만들어주세요.
	Connection con = null;
	// 쿼리문 실행을 위한 PreparedStatement 객체 생성
	PreparedStatement pstmt = null;

	
	try{
		//MySQL과 연동할 것임을 선언.
		Class.forName("com.mysql.cj.jdbc.Driver");
	
		//접속 URL은 jdbc:mysql://localhost/db명
		String url = "jdbc:mysql://localhost/ict03";
	
		//접속 주소, 계정, 비밀번호를 이용해 접속요청을 넣습니다.
		con = DriverManager.getConnection(url, "root", "mysql");
		
		//1.쿼리문을 작성합니다.
		String sql = "INSERT INTO users VALUES(?, ?, ?, ?)";
		
		//2.만든 쿼리문의 ?자리에 적용할 자바 변수를 집어넣습니다.
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, uid);
		pstmt.setString(2, upw);
		pstmt.setString(3, uname);
		pstmt.setString(4, email);
		
		//4.만든 쿼리문 실행하기
		pstmt.executeUpdate();
		
		
		
	}catch(ClassNotFoundException e){
		System.out.println("드라이버 로딩 실패");
	}catch(SQLException e){
		System.out.println("에러 : " + e);
	}finally{
		try{
			if(con!=null && !con.isClosed()){
				con.close();
			}
		}catch(SQLException e){
			e.printStackTrace();
		}
	}
%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>
</head>
<body>
	<h2>회원가입이 완료되었습니다.</h2>
</body>
</html>