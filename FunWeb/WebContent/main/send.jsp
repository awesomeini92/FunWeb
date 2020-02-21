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
//세션값이 없으면 loginForm.jsp으로 이동
if(id==null){%>
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/top.jsp"/>
<!-- 헤더들어가는 곳 -->
<%
	 //response.sendRedirect("loginForm.jsp");
}else{%>
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/top_login.jsp"/>
<!-- 헤더들어가는 곳 -->
	
<%}
%>
<%


%>

<form action="sendPro.jsp" method="post">
<table id = "notice">
<tr><td>보내는 사람</td><td><input type="text" name="sdr" value="<%=id%>" readonly></td></tr>
<tr><td>받는 사람</td><td><input type="text" name="rcvr"></td></tr>
<tr><td>내용</td><td><textarea name="msg" cols="20" rows="10"></textarea></td></tr>
<tr><td colspan="2"><input type="submit" value="쪽지쓰기"></td></tr>
</table>
</form>

<h2><a href="receive.jsp">받은 쪽지</a></h2>
</body>
</html>