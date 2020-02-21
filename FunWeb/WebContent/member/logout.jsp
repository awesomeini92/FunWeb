<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
//세션값 초기화
String id = (String)session.getAttribute("id");
if(id==null){%>
	<script type="text/javascript">
	alert("로그인 먼저 해주세요.");
	location.href="login.jsp";
	</script>
<%}else{
session.invalidate();
// response.sendRedirect("main.jsp"); //창 안뿌리고 이동할 때
%>

<script type="text/javascript">
alert("로그아웃 되었습니다.");
location.href="../main/main.jsp";
</script>

<%}
%>
