<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->
<!--[if IE 6]>
 <script src="../script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

 </script>
 <![endif]-->
</head>
<body>
<div id="wrap">

<%
String id = (String)session.getAttribute("id");
//���ǰ��� ������ loginForm.jsp���� �̵�
if(id==null){%>
<!-- ������� �� -->
<jsp:include page="../inc/top.jsp"/>
<!-- ������� �� -->
<%
	 //response.sendRedirect("loginForm.jsp");
}else{%>
<!-- ������� �� -->
<jsp:include page="../inc/top_login.jsp"/>
<!-- ������� �� -->
	
<%}
%>

<!-- �������� �� -->
<!-- �����̹��� -->
<div id="sub_img_center"></div>
<!-- �����̹��� -->

<!-- ���ʸ޴� -->
<nav id="sub_menu">
<ul>
<li><a href="../center/fwriteForm.jsp">Upload File</a></li>
<li><a href="../center/fnotice.jsp">File Reference</a></li>
</ul>
</nav>
<!-- ���ʸ޴� -->

<%

if(id==null){%>
	<script type="text/javascript">
			alert("�α��� ���ּ���");
			location.href="../member/login.jsp";
	</script>
	
<%
}else{
%>
<article>
<h1>Notice Write</h1>

<form action="writePro.jsp" method="post">
<table id = "notice">
<tr><td>�۾���</td><td><input type="text" value="<%=id%>" readonly></td></tr>
<tr><td>��й�ȣ</td><td><input type="password" name="pass"></td></tr>
<tr><td>����</td><td><input type="text" name="subject"></td></tr>
<tr><td>����</td><td><textarea name="content" cols="20" rows="10"></textarea></td></tr>
<tr><td colspan="2"><input type="submit" value="�۾���"></td></tr>
</table>
</form>


<%} %>
<div class="clear"></div>
<div id="page_control">


</div>
</article>
<!-- �Խ��� -->
<!-- �������� �� -->
<div class="clear"></div>
<!-- Ǫ�͵��� �� -->
<jsp:include page="../inc/bottom.jsp"/>
<!-- Ǫ�͵��� �� -->
</div>
</body>
</html>