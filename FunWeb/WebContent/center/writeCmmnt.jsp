<%@page import="comment.commentDAO"%>
<%@page import="comment.commentBean"%>
<%@page import="board.boardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%
request.setCharacterEncoding("utf-8"); //post 방식일 때 한글처리
int num = Integer.parseInt(request.getParameter("num"));

String id = (String)session.getAttribute("id");
String comment = request.getParameter("comment");

commentBean cb = new commentBean();
cb.setGllr_num(num);
cb.setId(id);
cb.setComment(comment);

commentDAO cd = new commentDAO();
cd.insertComment(cb);


response.sendRedirect("gcontent.jsp?num="+num);

// history.back();




%>






