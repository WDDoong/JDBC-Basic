<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>점수 확인</title>
</head>
<body>
	<h3>당신의 학점은</h3>
	<c:choose>
		<c:when test="${param.point >= 90 && param.point <= 100}">
			<p>A학점 입니다.</p>
		</c:when>
		<c:when test="${param.point >= 80 && param.point <= 100}">
			<p>B학점 입니다.</p>
		</c:when>
		<c:when test="${param.point >= 70 && param.point <= 100}">
			<p>C학점 입니다.</p>
		</c:when>
		<c:when test="${param.point >= 60 && param.point <= 100}">
			<p>D학점 입니다.</p>
		</c:when>
		<c:otherwise>
			<p>F학점 입니다.</p>
		</c:otherwise>
	</c:choose>
	

</body>
</html>