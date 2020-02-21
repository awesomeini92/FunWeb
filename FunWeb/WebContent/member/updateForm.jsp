<%@page import="member.memberDAO"%>
<%@page import="member.memberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<link href="../css/front.css" rel="stylesheet" type="text/css">
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
 
 <script type="text/javascript">

 function post(){
	//우편번호검색
	var post = document.reg.postCode.value;
		 window.open("setPostcode.jsp","우편번호검색","width=500,height=300");
	 }
	 
 </script>
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
<!-- 본문메인이미지 -->
<div id="sub_img_member"></div>
<!-- 본문메인이미지 -->
<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="../center/fwriteForm.jsp">Upload File</a></li>
<li><a href="../center/fnotice.jsp">File Reference</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->
<article>
<h1>Update Info</h1>
<%
if(id==null){
	%>
	<script type="text/javascript">
		alert("로그인 해주세요");
		location.href="login.jsp";
		</script>
	<%
}
else{
memberDAO md = new memberDAO();
memberBean mb = new memberBean();
mb = md.getMember(id);

// String name = request.getParameter("name");
%>
<form action="updatePro.jsp" name="reg" id="join" method="post">  <!-- css subpage -->
<fieldset>
<legend>Basic Info</legend>
<label>User ID</label>
<input type="text" name="id" class="id" value="<%=id %>" readonly><br>
<label>Password</label>
<input type="password" name="pass"><br>
<label>New Password</label>
<input type="password" name="newPass"><br>
<label>Name</label>
<input type="text" name="name" value="<%=mb.getName()%>" readonly><br>
<label>E-Mail</label>
<input type="email" name="email" value="<%= mb.getEmail()%>"><br>
</fieldset>

<fieldset>
<legend>Optional</legend>
<label>Post Code</label>  <!-- 상세주소 추가해야함-->
<input type="text" name="postCode" value="<%=mb.getPostCode()%>" id="postCode">
<input type=button value="우편번호검색" class="post" onclick="post()" name="postButton"><br>
<label>Address</label> 
<input type="text" name="address" id="address" value="<%=mb.getAddress()%>"><br>
<label>Detail Address</label>
<input type="text" name="detailAddress" value="<%=mb.getDetailAddress()%>" id="detailAddress" ><br>
<label>Extra Address</label>
<input type="text" name="extraAddress" value="<%=mb.getExtraAddress()%>"  id="extraAddress" ><br>
<label>Phone Number</label>
<input type="text" name="phone" value="<%=mb.getPhone()%>" ><br>
<label>Mobile Phone Number</label>
<input type="text" name="mobile" value="<%=mb.getMobile()%>" ><br>
</fieldset>

 <script type="text/javascript">
 
 function del(){
	 if (confirm("탈퇴하시겠습니까?") == true){    //확인
<%-- 		 location.href="deletePro.jsp?pass=<%=mb.getPass()%>"; --%>
var pass = document.reg.pass.value;
location.href="deletePro.jsp?pass="+pass; 
		}else{   //취소
		    return false;
		}
}
 </script>
 <div class="clear"></div>
<div id="buttons">
<%if(id!=null){ %>
<input type="submit" value="회원수정" class="submit"> <!-- onclick 이벤트 -->
<input type="button" value="회원탈퇴" class="withdraw" onclick=del()>
<input type="reset" value="취소" class="cancel">

</div>
</form>
<%} 
}%>
</article>
<!-- 본문내용 -->
<!-- 본문들어가는 곳 -->

<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"/>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>