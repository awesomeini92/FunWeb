<%@page import="message.msgDAO"%>
<%@page import="message.msgBean"%>
<%@page import="board.boardDAO"%>
<%@page import="board.boardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8"); //post 방식일 때 한글처리
String sdr = request.getParameter("sdr");
String rcvr = request.getParameter("rcvr"); //이름을 아이디로 준다
String msg = request.getParameter("msg");


msgBean mb = new msgBean();
mb.setMsg(msg);
mb.setSdr(sdr);
mb.setRcvr(rcvr);

msgDAO md = new msgDAO();
md.insertMsg(mb);

response.sendRedirect("send.jsp");

%>