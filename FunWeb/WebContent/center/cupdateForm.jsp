<%@page import="comment.commentBean"%>
<%@page import="comment.commentDAO"%>
<%@page import="gallary.gallaryBean"%>
<%@page import="gallary.gallaryDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date"%>
<%@page import="board.boardBean"%>
<%@page import="java.util.List"%>
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
<li><a href="../center/fwriteForm.jsp">Driver Download</a></li>
<li><a href="../center/fnotice.jsp">Reference</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 게시판 -->
<% 
int gllr_num = Integer.parseInt(request.getParameter("gllr_num")); 
int cmmnt_num = Integer.parseInt(request.getParameter("cmmnt_num"));
request.setCharacterEncoding("utf-8"); //post 방식일 때 한글처리

gallaryDAO gd = new gallaryDAO();
//조회수 증가 update
gd.updateReadCount(gllr_num);
List commList = null;

gallaryBean gb = new gallaryBean();

gb = gd.getGallary(gllr_num);
SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
Date today = gd.getToday();

commentDAO cd = new commentDAO();
commentBean cb = new commentBean();
int count = cd.getCommentList(gllr_num).size();

if(count!=0){
 	commList = cd.getCommentList(gllr_num);
}
%>

<article>
<h1>Gallary Notice Content</h1>
<table id="notice">
<tr><td>글번호</td><td><%=gllr_num%></td><td>조회수</td><td><%=gb.getReadcount()%></td></tr>
<tr><td>작성자</td><td><%=gb.getName() %></td><td>작성일</td><td><%=gb.getDate()%></td></tr>
<tr><td>글제목</td><td colspan="3"><%=gb.getSubject()%></td></tr>
<tr><td>첨부파일</td><td colspan="3"> <img src="../upload/<%=gb.getFile()%>" width=200px >
</td></tr>
<tr><td>글내용</td><td colspan="3"><%=gb.getContent()%></td></tr>
</table>

<br><br>


<!-- @@수정@@ 글번호에 맞는 댓글만 출력하기 -->
<!-- 댓글보여주기 -->
<div id="comments"> <!-- 코멘트 부분 div 시작 -->
<%for(int i=0; i<cd.getCommentList(gllr_num).size(); i++){
	cb = (commentBean)commList.get(i);

	String time = cd.getTime();
	Date date = cb.getDate();
	int compare = today.compareTo(date); 
%>

<table class="comments">
<tr><td id="getid"><%=cb.getId() %></td>
<td id="comm" > <%=cb.getComment()%></td>
<%if(compare==0){ %>
<td id="time" ><%=time %></td>   <!-- date 오늘 날짜는 시간 출력 -->
<%}else{ %>
<td id="date"><%=sdf.format(cb.getDate())%></td>  <!-- 아니면 날짜 출력 -->
<%} %>
</tr>
</table>
<%} 
%>

<!-- 댓글쓰기 -->
<br><br><br><br><br>
<%
cb = cd.getComment(cmmnt_num);

%>

<form action="cupdatePro.jsp?gllr_num=<%=gllr_num%>&cmmnt_num=<%=cmmnt_num%>" method="post">
<table id="notice">
<tr><td><input type="text" size="4" name=id value="<%=cb.getId()%>"  readonly ></td>
<td><textarea name=comment cols="50"><%=cb.getComment()%></textarea></td>
<td><input type="submit" value="댓글수정"  class="btn" ></td></tr>
</table>
</form>
</div>  <!-- 코멘트 부분 div 끝-->
<br><br>




<div id="table_search">
<%if(id!=null){
if(id.equals(gb.getName())){%>
<input type="button" value="글수정" class="btn" onclick="location.href='gupdateForm.jsp?num=<%=gb.getNum()%>'">
<input type="button" value="글삭제" class="btn" onclick="location.href='gdeleteForm.jsp?num=<%=gb.getNum()%>'">
<input type="button" value="글목록" class="btn" onclick="location.href='gnotice.jsp'">
<%
}else{%>
<input type="button" value="글목록" class="btn" onclick="location.href='gnotice.jsp'">
<%} 
}%>
</div>





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