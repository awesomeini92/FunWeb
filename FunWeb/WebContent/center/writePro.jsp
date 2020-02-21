<%@page import="board.boardDAO"%>
<%@page import="board.boardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8"); //post 방식일 때 한글처리
// String id = (String)session.getAttribute("id");
String name = (String)session.getAttribute("id"); //이름을 아이디로 준다
String pass = request.getParameter("pass");
String subject = request.getParameter("subject");
String content = request.getParameter("content");

//num=1, readcount 0 date 현시스템날짜 now()
int num=1;
int readcount=0;

boardBean bb = new boardBean();
bb.setNum(num);
bb.setName(name);
bb.setPass(pass);
bb.setSubject(subject);
bb.setContent(content);

boardDAO bd = new boardDAO();
bd.insertBoard(bb);

response.sendRedirect("notice.jsp");

%>