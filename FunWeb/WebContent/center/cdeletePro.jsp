<%@page import="comment.commentDAO"%>
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
int cmmnt_num = Integer.parseInt(request.getParameter("cmmnt_num"));
int gllr_num = Integer.parseInt(request.getParameter("gllr_num"));

commentDAO cd = new commentDAO();
cd.deleteComment(cmmnt_num);

response.sendRedirect("gcontent.jsp?num="+gllr_num);

%>
</body>
</html>