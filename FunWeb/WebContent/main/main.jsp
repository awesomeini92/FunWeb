<%@page import="gallary.gallaryBean"%>
<%@page import="gallary.gallaryDAO"%>
<%@page import="reference.referenceBean"%>
<%@page import="reference.referenceDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="board.boardDAO"%>
<%@page import="board.boardBean"%>
<%@page import="java.sql.Date"%>
<%@page import="member.memberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/front.css" rel="stylesheet" type="text/css">

<!--[if lt IE 9]>.
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

<style type="text/css">
.gallary{ 
/* 	display: inline; */
	float:left;
	margin: 3em;
	text-align: center;
}
.main_g_img{

margin:  5px;
}

</style>

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


<!-- 메인이미지 들어가는곳 -->
<div class="clear"></div>
<div id="main_img">
<img src="../images/pepper_3.jpg" width="320" height="282">
<img src="../images/pepper_4.jpg" width="318" height="282">
<img src="../images/pepper_10.jpg" width="324" height="282">
</div>
<!-- 메인이미지 들어가는곳 -->
<!-- 메인 콘텐츠 들어가는 곳 -->
<article id="front">




<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->
<div>
<%
int pageSize = 3; //한 페이지에 보여줄 글 개수
int startRow = 1;
gallaryDAO gd = new gallaryDAO();
List gallaryList = null;

gallaryBean gb = new gallaryBean();
//현 페이지 번호
String pageNum = "1";
int currentPage = Integer.parseInt(pageNum);
int count = gd.getGallaryCount();

if(count!=0){
	//boardList = bd.getBoardList(1,10); 1페이지 글 10개
	gallaryList = gd.getGallaryList(startRow,pageSize);
}

SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
Date today = gd.getToday();
for(int i=0; i<gallaryList.size();i++){
		gb = (gallaryBean)gallaryList.get(i);
		String time = gd.getTime(gb.getNum());
		Date date = gb.getDate();
 int compare = today.compareTo(date); 
%>
<div class="gallary">
<%-- <td class="left"><%=bb.getSubject() %></td> --%>
<%-- <td><%=bb.getFile() %></td> --%>
<div class="main_g_img" onclick="location.href='../center/gcontent.jsp?num=<%=gb.getNum()%>'"><img src="../upload/<%=gb.getFile()%>" width=200px height=200px></div>

<div>작성자  <%=gb.getName() %></div>
<%if(compare==0){ %>
<div>작성일  <%=time %></div>   <!-- date 오늘 날짜는 시간 출력 -->
<%}else{ %>
<div>작성일  <%=sdf.format(gb.getDate())%></div>  <!-- 아니면 날짜 출력 -->
<%} %>

</div>
 <%	} %>
<!-- @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->



<div class="clear"></div>
<div id="sec_news"> <!-- 가장최근글 5개 -->
<h3><span class="purple">Reference</span> Board</h3>
<!-- <h3 class="brown">News &amp; Notice</h3> -->

<%
pageSize = 5; //한 페이지에 보여줄 글 개수
startRow = 1;
referenceDAO rd = new referenceDAO();
List referenceList = null;

referenceBean rb = new referenceBean();
//현 페이지 번호
pageNum = "1";
currentPage = Integer.parseInt(pageNum);
count = rd.getReferenceCount();

if(count!=0){
	//boardList = bd.getBoardList(1,10); 1페이지 글 10개
	referenceList = rd.getReferenceList(startRow,pageSize);
}
%>
	<table><%
  	sdf = new SimpleDateFormat("yyyy.MM.dd");
	today = rd.getToday();
	for(int i=0; i<referenceList.size();i++){
			rb = (referenceBean)referenceList.get(i);
			String time = rd.getTime(rb.getNum());
			Date date = rb.getDate();
	 int compare = today.compareTo(date); %>
	<tr>
	<td class="contxt"><a href="../center/fcontent.jsp?num=<%=rb.getNum()%>"><%=rb.getSubject() %></a></td>
		<%if(compare==0){ %>	<td><%=time %></td>
	</tr>
		<%}else{ %>	<td><%=sdf.format(rb.getDate())%></td>
	</tr><%}
		}%>
	</table>
</div>

<div id="news_notice"> <!-- 가장최근글 5개 -->
<h3><span class="skyblue">Basic</span> Board</h3>


<%
pageSize = 5; //한 페이지에 보여줄 글 개수
startRow = 1;
boardDAO bd = new boardDAO();
List boardList = null;

boardBean bb = new boardBean();
//현 페이지 번호
pageNum = "1";
currentPage = Integer.parseInt(pageNum);
count = bd.getBoardCount();

if(count!=0){
	//boardList = bd.getBoardList(1,10); 1페이지 글 10개
	boardList = bd.getBoardList(startRow,pageSize);
}
%>
	<table><%
  	sdf = new SimpleDateFormat("yyyy.MM.dd");
	today = bd.getToday();
	System.out.println(today);
	for(int i=0; i<boardList.size();i++){
			bb = (boardBean)boardList.get(i);
			String time = bd.getTime(bb.getNum());
			Date date = bb.getDate();
	 int compare = today.compareTo(date); %>
	<tr>
	<td class="contxt"><a href="../center/content.jsp?num=<%=bb.getNum()%>"><%=bb.getSubject() %></a></td>
		<%if(compare==0){ %>	<td><%=time %></td>
	</tr>
		<%}else{ %>	<td><%=sdf.format(bb.getDate())%></td>
	</tr><%}
		}%>
	</table>
</div>
</article>
<!-- 메인 콘텐츠 들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"/>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>