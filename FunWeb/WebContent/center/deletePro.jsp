<%@page import="board.boardDAO"%>
<%@page import="member.memberBean"%>
<%@page import="member.memberDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
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

boardDAO bd = new boardDAO();
bd.deleteBoard(num);

response.sendRedirect("notice.jsp");


%>




</body>
</html>