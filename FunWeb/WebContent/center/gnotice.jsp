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
<style type="text/css">
.gallary{ 
/* 	display: inline; */
	float:left;
 	margin:  5em;
}
.ntc_img{
margin:  1px;
}
#table_search{
display: block;
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

<!-- 게시판 -->
<% 
request.setCharacterEncoding("utf-8"); //post 방식일 때 한글처리

gallaryDAO gd = new gallaryDAO();
List gallaryList = null;

gallaryBean gb = new gallaryBean();

int pageSize = 4; //한 페이지에 보여줄 글 개수


//현 페이지 번호
String pageNum = request.getParameter("pageNum");
if(pageNum==null){
	pageNum="1";
}
int currentPage = Integer.parseInt(pageNum);
int startRow = (currentPage-1)*pageSize+1;
int endRow = currentPage*pageSize;

//글개수  모든 행의 개수-count(*)
int count = gd.getGallaryCount();

if(count!=0){
	//gallaryList = gd.getBoardList(1,10); 1페이지 글 10개
	gallaryList = gd.getGallaryList(startRow, pageSize);
}

%>

<article>
<h1>Gallary Notice [전체글개수: <%=count %>]</h1>


<!-- <tr> <th class="tno">No.</th> -->
<!--     <th class="ttitle">Title</th> -->
<!--     <th class="twrite">Writer</th> -->
<!--     <th class="tdate">Date</th> -->
<!--     <th class="tread">Read</th></tr>  -->
    <%
 
  	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
	Date today = gd.getToday();


	
for(int i=0; i<gallaryList.size();i++){

	gb = (gallaryBean)gallaryList.get(i);
	String file = gb.getFile();
	String time = gd.getTime(gb.getNum());
	Date date = gb.getDate();
	
	 int compare = today.compareTo(date);
	
%>

<div class="gallary">
<%-- <td class="left"><%=bb.getSubject() %></td> --%>
<%-- <td><%=bb.getFile() %></td> --%>
<div class="ntc_img" onclick="location.href='gcontent.jsp?num=<%=gb.getNum()%>'">
	<img src="../upload/<%=file%>" width=200px></div>
<%-- <div>글번호  <%=gb.getNum() %></div> --%>
<div>작성자  <%=gb.getName() %></div>
<%if(compare==0){ %>
<div>작성일  <%=time %></div>   <!-- date 오늘 날짜는 시간 출력 -->
<%}else{ %>
<div>작성일  <%=sdf.format(gb.getDate())%></div>  <!-- 아니면 날짜 출력 -->
<%} %>
<div>조회수  <%=gb.getReadcount() %></div>
</div>
<%} %>



<div id="table_search">
<%if(id!=null){%>
<input type="button" value="글쓰기" class="btn" onclick="location.href='gwriteForm.jsp'">
<%
}%>
</div>




<div class="clear"></div>
<div id="page_control">
<% //페이지컨트롤

//전체페이지 개수 구하기
int pageCount = 0;

pageCount = count%pageSize==0 ? count/pageSize : (count/pageSize)+1;
//pageCount = count/pageSize+(count%pageSize==0 ? 0 : 1)


//한화면에 보여줄 페이지 개수 설정
int pageBlock=10;

int startPage = ((currentPage-1)/pageBlock)*pageBlock +1;

int endPage = (startPage + pageBlock)-1;

if(endPage>pageCount){
	endPage=pageCount;
}
if(startPage>pageBlock){
	%><a href="gnotice.jsp?pageNum=<%=startPage-pageBlock%>">Prev</a><%
}
//페이지 n번을 누르면 주소 보내주기
for(int i=startPage; i<=endPage; i++){
	%><a href="gnotice.jsp?pageNum=<%=i%>"><%=i%></a><%
}

//[다음]
if(endPage<pageCount){
	%><a href="gnotice.jsp?pageNum=<%=startPage+pageBlock%>">Next</a><%
}


%>
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