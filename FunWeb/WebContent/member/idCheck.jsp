<%@page import="member.memberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script type="text/javascript">
function idSelect(){
	opener.document.frm.id.value = document.wfr.checkId.value;
// 	join.jsp에서 새창을 켰으므로 join.jsp는 opener라 한다.
	window.close();
}
</script>

</head>
<body>

<%
   request.setCharacterEncoding("utf-8"); //post 방식일 때 한글처리
   String checkId = request.getParameter("checkId");
   memberDAO md = new memberDAO();

	int check = md.checkId(checkId);
	
	if(check ==1){ 
		out.println("아이디 중복입니다.");
		
// 		<script type="text/javascript">
// 		alert("아이디 중복입니다.")
// 		close();
// 		</script>	%>
	<%}else{ 	
		out.println("사용할 수 있는 아이디입니다.");

	
// 		<script type="text/javascript">
// 		alert("사용할 수 있는 아이디입니다.")
// // 		history.back();
// 		close();
// 		</script>
	
	%>
	<input type="button"  value="아이디선택" onclick="idSelect()">
		
		<%}
 %>
 
<form action="idCheck.jsp"  method="post" name="wfr"> 
<label>아이디 검색</label>
<input type="text"   value="<%=checkId%>"  name="checkId">
<input type="submit" value="아이디중복체크">
</form>















</body>
</html>
