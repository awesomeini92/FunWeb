<%@page import="member.memberDAO"%>
<%@page import="member.memberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
request.setCharacterEncoding("utf-8");
String id = request.getParameter("id");
String pass = request.getParameter("pass");
String newPass = request.getParameter("newPass");
String name = request.getParameter("name");
String email = request.getParameter("email");
String address = request.getParameter("address");
String phone = request.getParameter("phone");
String mobile = request.getParameter("mobile");


memberDAO md = new memberDAO();
memberBean mb = new memberBean();
mb.setAddress(address);
mb.setEmail(email);
mb.setId(id);
mb.setMobile(mobile);
mb.setName(name);
mb.setPass(newPass);
mb.setPhone(phone);

int check = md.checkUser(id, pass);

if(check == 1){
	md.updateMember(mb);
	%>
	<script type="text/javascript">
	alert("정보수정 완료")
	location.href="../main/main.jsp";
	</script>
<%} else{%>
	<script type="text/javascript">
	alert("비밀번호 오류");
	history.back();
	</script>

<%}%>



    
