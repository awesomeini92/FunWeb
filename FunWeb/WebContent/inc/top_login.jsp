<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String id = (String)session.getAttribute("id");
%>

<!-- 헤더들어가는 곳 -->
<header>
<div id="login"> <%=id %>님이 로그인 하셨습니다. | <a href="../member/updateForm.jsp">정보수정 | <a href="../member/logout.jsp">logout</a></div>

<div class="clear"></div>
<!-- 로고들어가는 곳 -->
<div id="logo"><a href="../main/main.jsp"><img src="../images/LOGO.png" width="265" height="62" alt="Fun Web"></a></div>
<!-- 로고들어가는 곳 -->
<nav id="top_menu">
<ul>
	<li><a href="../main/main.jsp">HOME</a></li>
	<li><a href="../company/welcome.jsp">INTRO</a></li>
	<li><a href="../center/gnotice.jsp">GALLARY</a></li>
	<li><a href="../center/notice.jsp">NOTICE</a></li>
	<li><a href="../contact/contact.jsp">CONTACT US</a></li></ul>
</nav>
</header>
<!-- 헤더들어가는 곳 -->