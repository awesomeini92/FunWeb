<%@page import="comment.commentDAO"%>
<%@page import="comment.commentBean"%>
<%@page import="board.boardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%
request.setCharacterEncoding("utf-8"); //post 방식일 때 한글처리
int gllr_num = Integer.parseInt(request.getParameter("gllr_num"));
int cmmnt_num = Integer.parseInt(request.getParameter("cmmnt_num"));
String id = request.getParameter("id");
String comment = request.getParameter("comment");

commentBean cb = new commentBean();
cb.setGllr_num(gllr_num);
cb.setCmmnt_num(cmmnt_num);
cb.setId(id);
cb.setComment(comment);

commentDAO cd = new commentDAO();
cd.updateCmmnt(cb);
int num =cb.getGllr_num();

response.sendRedirect("gcontent.jsp?num="+num);

// history.back();




%>






