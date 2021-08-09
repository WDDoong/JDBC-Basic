<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>점수 입력</title>
</head>
<body>
	<h2>점수를 입력하세요.</h2>
	<form action="jstl_choose_test.jsp">
		<input type="text" name="point" placeholder="점수를 입력하세요." size="15">점<br/>
		<input type="submit" value="제출">
	</form>
</body>
</html>