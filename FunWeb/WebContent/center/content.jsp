<%@page import="comment.commentDAO"%>
<%@page import="comment.commentBean"%>
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

boardDAO bd = new boardDAO();
//조회수 증가 update
bd.updateReadCount(num);

SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
Date today = bd.getToday();

boardBean bb = new boardBean();
bb = bd.getBoard(num);

String time = bd.getTime(bb.getNum());
Date date = bb.getDate();
int compare = today.compareTo(date); 
%>
<div class="gallary">
<%-- <td class="left"><%=bb.getSubject() %></td> --%>
<%-- <td><%=bb.getFile() %></td> --%>


<article>
<h1>Notice Content</h1>
<table id="notice">
<tr><td>글번호</td><td><%=num %></td><td>조회수</td><td><%=bb.getReadcount()%></td></tr>
<tr><td>작성자</td><td><%=bb.getName() %></td>
<%if(compare==0){ %>
<td>작성일</td><td><%=time %></td></tr>
<%}else{ %>
<td>작성일 </td><td> <%=sdf.format(bb.getDate())%></td></tr>  <!-- 아니면 날짜 출력 -->
<%} %>
<tr><td>글제목</td><td colspan="3"><%=bb.getSubject()%></td></tr>
<tr  style="height: 250px"><td>글내용</td><td colspan="3"><%=bb.getContent()%></td></tr>
</table>
<br><br><br>




<div id="table_search">
<%if(id!=null){
if(id.equals(bb.getName())){%>
 <script type="text/javascript">
 
 function del(){
	 if (confirm("정말 삭제하시겠습니까?") == true){    //확인
		 location.href="deletePro.jsp?num=<%=bb.getNum()%>";
		}else{   //취소
		    return false;
		}
}
 </script>


<input type="button" value="글수정" class="btn" onclick="location.href='updateForm.jsp?num=<%=bb.getNum()%>'">
<input type="button" value="글삭제" class="btn" onclick=del()>
<input type="button" value="글목록" class="btn" onclick="location.href='notice.jsp'">
<%
}else{%>
<input type="button" value="글목록" class="btn" onclick="location.href='notice.jsp'">
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