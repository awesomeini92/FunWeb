<%@page import="member.memberDAO"%>
<%@page import="member.memberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%

request.setCharacterEncoding("utf-8"); //post 방식일 때 한글처리

String id = request.getParameter("id");
String pass = request.getParameter("pass");

memberDAO md = new memberDAO();
int check = md.checkUser(id, pass);


if(check==1){			//아이디 있음 1이면
		session.setAttribute("id", id); //서버에 저장된 세션값 (id,1212)로 저장됨
		response.sendRedirect("../main/main.jsp");
}else if(check==0){//0이면 비밀번호 오류%>비밀번호 오류
	<script type="text/javascript">
		alert("비밀번호 오류");
		history.back();
	</script>

<%}else if(check==-1) //-1이면 아이디 없음%>아이디없음
	<script type="text/javascript">
	alert("아이디 없음");
	history.back();
	</script>

%>