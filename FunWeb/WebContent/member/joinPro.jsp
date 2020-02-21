<%@page import="member.memberBean"%>
<%@page import="member.memberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("utf-8"); //post 방식일 때 한글처리

String id = request.getParameter("id");
String pass = request.getParameter("pass");
String name = request.getParameter("name");
String email = request.getParameter("email");
String address = request.getParameter("address");
String phone = request.getParameter("phone");
String mobile = request.getParameter("mobile");
String detailAddress = request.getParameter("detailAddress");
String extraAddress = request.getParameter("extraAddress");

int postCode = 0;

if(request.getParameter("postCode")!=""){
	postCode = Integer.parseInt(request.getParameter("postCode"));
}

memberBean mb = new memberBean();
mb.setId(id);
mb.setPass(pass);
mb.setName(name);
mb.setEmail(email);
mb.setAddress(address);
mb.setPhone(phone);
mb.setMobile(mobile);
mb.setDetailAddress(detailAddress);
mb.setExtraAddress(extraAddress);
mb.setPostCode(postCode);

memberDAO md = new memberDAO();
int check = md.checkId(id);


md.insertMember(mb);	

response.sendRedirect("mailPro.jsp?email="+email);
%>
<script type="text/javascript">
alert("회원가입 완료")
location.href="login.jsp";
</script>

    
    
    
    
    
    
    
    
    