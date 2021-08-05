<%@page import="kr.co.ictedu.UsersVO"%>
<%@page import="kr.co.ictedu.UsersDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	// 1. 폼에서 던져준 데이터를 받습니다.
	String upPw = request.getParameter("upw");
	String upName = request.getParameter("uname");
	String upEmail = request.getParameter("email");
	
	
	// 2. VO를 생성해서 던져준 데이터를  담습니다.
	UsersVO user = new UsersVO();
	user.setUpw(upPw);
	user.setUname(upName);
	user.setEmail(upEmail);
	
	
	// 3. dao를 생성해 usersUpdate(); 메서드를 호출합니다.
	UsersDAO dao = UsersDAO.getInstance();
	int userUpdate = dao.userUpdate(user);
	System.out.println(userUpdate);
	
	// 4. 업데이트 성공시 1, 실패시 0을 리턴받고
	//	  0을 리턴 받았을 때는 user_update_fail.jsp로 리다이렉트
	//	  1을 리턴 받을땐 하단 body태그 내에 "<계정명> 수정이 완료되었습니다."
	//	  라는 메세지와 다시 로그인폼으로 리다이렉트 시켜줍니다.
	
	if(userUpdate == 1){
		response.sendRedirect("user_update_ok.jsp");
	}else if(userUpdate == 0){
		response.sendRedirect("user_update_fail.jsp");
	}

	
	
%>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정 완료 페이지</title>
</head>
<body>

	<h2><%= user.getId() %> 수정이 완료되었습니다.</h2>
	<a href=""user_login_form.jsp""></a>
</body>
</html>