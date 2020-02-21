<%@page import="board.boardDAO"%>
<%@page import="board.boardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8"); //post 방식일 때 한글처리
String name = (String)session.getAttribute("id"); //이름을 아이디로 준다
String subject = request.getParameter("subject");
String content = request.getParameter("content");
int num = Integer.parseInt(request.getParameter("num"));

boardBean bb = new boardBean();
bb.setNum(num);
bb.setName(name);
bb.setSubject(subject);
bb.setContent(content);

boardDAO bd = new boardDAO();
bd.updateBoard(bb);
int check = bd.updateBoard(bb);

if(check==1){
	%>
	<script type="text/javascript">
	alert("글 수정 완료");
	location.href="notice.jsp";
	</script>
	
	<%
}else if(check==0){
		%>
		<script type="text/javascript">
		alert("글 수정 실패");
		history.back();
		</script>
		
		<%
	}
%>

