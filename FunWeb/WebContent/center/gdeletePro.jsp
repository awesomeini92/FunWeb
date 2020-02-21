<%@page import="gallary.gallaryDAO"%>
<%@page import="reference.referenceDAO"%>
<%@page import="board.boardDAO"%>
<%@page import="board.boardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>


<body>
<%
request.setCharacterEncoding("utf-8"); //post 방식일 때 한글처리
String name = (String)session.getAttribute("id"); //이름을 아이디로 준다
int num = Integer.parseInt(request.getParameter("num"));

gallaryDAO gd = new gallaryDAO();
gd.deleteGallary(num);

response.sendRedirect("gnotice.jsp");

%>
</body>
</html>