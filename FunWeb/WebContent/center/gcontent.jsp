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
<li><a href="../center/fwriteForm.jsp">Upload File</a></li>
<li><a href="../center/fnotice.jsp">File Reference</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->

<!-- 게시판 -->
<% 
int num = Integer.parseInt(request.getParameter("num")); 
request.setCharacterEncoding("utf-8"); //post 방식일 때 한글처리

gallaryDAO gd = new gallaryDAO();
//조회수 증가 update
gd.updateReadCount(num);
List commntList = null;

gallaryBean gb = new gallaryBean();

gb = gd.getGallary(num);
SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
Date today = gd.getToday();
commentDAO cd = new commentDAO();
commentBean cb = new commentBean();

%>

<article>
<h1>Gallary Notice Content</h1>
<table id="notice">
<tr><td>글번호</td><td><%=num%></td><td>조회수</td><td><%=gb.getReadcount()%></td></tr>
<tr><td>작성자</td><td><%=gb.getName() %></td><td>작성일</td><td><%=gb.getDate()%></td></tr>
<tr><td>글제목</td><td colspan="3"><%=gb.getSubject()%></td></tr>
<tr><td>첨부파일</td><td colspan="3"> <img src="../upload/<%=gb.getFile()%>" width=500px >
</td></tr>
<tr><td>글내용</td><td colspan="3"><%=gb.getContent()%></td></tr>
</table>
<div id="table_search">
<input type="button" value="글목록" class="btn" onclick="location.href='gnotice.jsp'">
</div>
<br><br>


<!-- @@수정@@ 글번호에 맞는 댓글만 출력하기 -->
<!-- 댓글보여주기 -->
<div id="comments"> <!-- 코멘트 부분 div 시작 -->
<%
int pageSize = 4; //한 페이지에 보여줄 글 개수
String pageNum = request.getParameter("pageNum");
if(pageNum==null){
	pageNum="1";
}
int currentPage = Integer.parseInt(pageNum);
int startRow = (currentPage-1)*pageSize+1;
int endRow = currentPage*pageSize;

// int count = cd.getCommentList(num).size();
int count = cd.getCommentCount(num);

if(count!=0){
// 	commntList = cd.getCommentList(num);
	commntList = cd.getCommentList(startRow, pageSize, num);
}

if(commntList!=null){
for(int i=0; i<commntList.size(); i++){
	cb = (commentBean)commntList.get(i);
	int cmmnt_num = cb.getCmmnt_num();
	String time = cd.getTime();
	Date date = cb.getDate();
	int compare = today.compareTo(date); 
%>

<table class="comments">
<tr><td style="width: 20%" id="getid"><%=cb.getId() %></td>
<td style="width: 20%" id="comm" > <%=cb.getComment()%></td>
<%if(compare==0){ %>
<td style="width: 20%" id="time" ><%=time %></td>   <!-- date 오늘 날짜는 시간 출력 -->
<%}else{ %>
<td style="width: 20%" id="date"><%=sdf.format(cb.getDate())%></td>  <!-- 아니면 날짜 출력 -->
<%} %>
</tr>
</table>


<%if(id!=null){
if(id.equals(cb.getId())){%>
 <script type="text/javascript">
 
 function del_cmmnt(){
	 if (confirm("정말 삭제하시겠습니까?") == true){    //확인
		 location.href="cdeletePro.jsp?gllr_num=<%=gb.getNum()%>&cmmnt_num=<%=cb.getCmmnt_num()%>";
		}else{   //취소
		    return false;
		}
}
 </script>
<input type="button" value="수정" class="btn" onclick="location.href='cupdateForm.jsp?gllr_num=<%=gb.getNum()%>&cmmnt_num=<%=cb.getCmmnt_num()%>'">
<input type="button" value="삭제" class="btn" onclick=del_cmmnt()>

<%
}
}
}

%>
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
	%><a href="gcontent.jsp?pageNum=<%=startPage-pageBlock%>&num=<%=num%>">Prev</a><%
}
//페이지 n번을 누르면 주소 보내주기
for(int i=startPage; i<=endPage; i++){
	%><a href="gcontent.jsp?pageNum=<%=i%>&num=<%=num%>"><%=i%></a><%
}

//[다음]
if(endPage<pageCount){
	%><a href="gcontent.jsp?pageNum=<%=startPage+pageBlock%>&num=<%=num%>">Next</a><%
}%>

<!-- 댓글쓰기 -->
<br><br><br><br><br>

<form action="writeCmmnt.jsp?num=<%=num%>" method="post">
<table id="notice">
<tr><td><input type="text" size="4" value="<%=id%>"  readonly ></td>
<td><textarea name=comment cols="50" ></textarea></td>
<td><input type="submit" value="댓글쓰기"  class="btn" ></td></tr>
</table>
</form>
</div>  <!-- 코멘트 부분 div 끝-->
<br><br>
<%
}else{
%>

<%

if(id!=null){
%>

<!-- 댓글쓰기 -->
<br><br><br><br><br>

<form action="writeCmmnt.jsp?num=<%=num%>" method="post">
<table id="notice">
<tr><td><input type="text" size="4" value="<%=id%>"  readonly ></td>
<td><textarea name=comment cols="50" ></textarea></td>
<td><input type="submit" value="댓글쓰기"  class="btn" ></td></tr>
</table>
</form>
</div>  <!-- 코멘트 부분 div 끝-->
<br><br>
<%}
}
%>



<div id="table_search">
<%if(id!=null){
if(id.equals(gb.getName())){%>
 <script type="text/javascript">
 
 function del_gllr(){
	 if (confirm("정말 삭제하시겠습니까?") == true){    //확인
		 location.href="gdeletePro.jsp?num=<%=gb.getNum()%>";
		}else{   //취소
		    return false;
		}
}
 </script>

<input type="button" value="글수정" class="btn" onclick="location.href='gupdateForm.jsp?num=<%=gb.getNum()%>'">
<input type="button" value="글삭제" class="btn" onclick=del_gllr()>
<input type="button" value="글목록" class="btn" onclick="location.href='gnotice.jsp'">
<%
}
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