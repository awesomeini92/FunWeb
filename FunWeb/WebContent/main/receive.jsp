<%@page import="message.msgBean"%>
<%@page import="java.util.List"%>
<%@page import="message.msgDAO"%>
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

String rcvr = (String)session.getAttribute("id");
request.setCharacterEncoding("utf-8"); //post 방식일 때 한글처리


List msgList = null;
msgBean mb = new msgBean();

msgDAO md = new msgDAO();
msgList = md.selectMsg(rcvr);



for(int i=0; i<msgList.size(); i++){
	mb = (msgBean)msgList.get(i);

%>
<table id = "notice">
<tr><td>보내는 사람</td><td><%=mb.getSdr() %></td></tr>
<tr><td>받는 사람</td><td><%=mb.getRcvr() %></td></tr>
<tr><td>내용</td><td><%=mb.getMsg() %></td></tr>
</table>
<%} %>
</body>

</html>