<%@page import="board.boardBean"%>
<%@page import="board.boardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

<!-- 본문들어가는 곳 -->
<!-- 메인이미지 -->
<div id="sub_img_center"></div>
<!-- 메인이미지 -->

<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="../center/fwriteForm.jsp">Upload File</a></li>
<li><a href="../center/fnotice.jsp">File Reference</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->

<%
int num = Integer.parseInt(request.getParameter("num"));
request.setCharacterEncoding("utf-8"); //post 방식일 때 한글처리
boardDAO bd = new boardDAO();
boardBean bb = new boardBean();
bb=bd.getBoard(num);

if(id==null){%>
	<script type="text/javascript">
			alert("로그인 해주세요");
			location.href="../member/login.jsp";
	</script>
	
<%}else if(id.equals(bb.getName())){

	
%>
<article>
<h1>Notice Update</h1>

<form action="updatePro.jsp" method="post">
<input type="hidden" name="num" value="<%=num %>">
<table id = "notice">
<tr><td>글쓴이</td><td><input type="text" value="<%= bb.getName()%>" readonly></td></tr>
<tr><td>제목</td><td><input type="text" name="subject"   value="<%=bb.getSubject()%>" ></td></tr>
<tr><td>내용</td><td><textarea name="content"  cols="20" rows="10"  ><%=bb.getContent() %></textarea></td></tr>
<tr><td colspan="2"><input type="submit" value="수정하기"></td></tr>
</table>
</form>


<%} %>
<div class="clear"></div>
<div id="page_control">


</div>
</article>
<!-- 게시판 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"/>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>