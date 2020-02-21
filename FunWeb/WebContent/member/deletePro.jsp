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
String id = (String)session.getAttribute("id");
String pass = request.getParameter("pass");
memberDAO md = new memberDAO();


int check = md.checkUser(id, pass);

if(check == 1){
	md.deleteMember(id);
session.invalidate();
	%>
	<script type="text/javascript">
alert("탈퇴하셨습니다.");
location.href="../main/main.jsp";
</script>
<%} else{%>
	<script type="text/javascript">
	alert("비밀번호 오류");
	history.back();
	</script>

<%}%>






</body>
</html>
