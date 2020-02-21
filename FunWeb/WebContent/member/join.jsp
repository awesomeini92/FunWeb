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
 
 <script type="text/javascript">
 
 function checkId(){
	 //id가 비어있는지 아이디를 입력하세요 포커스 깜빡
	 if(document.frm.id.value.length==0){
			alert("아이디를 입력하세요");
			document.frm.id.focus();
			return false;
		}
	 //id가 있으면{
	var checkId = document.frm.id.value;
	 window.open("idCheck.jsp?checkId="+checkId,"아이디중복확인","width=500,height=300");
 }

 function post(){
	//우편번호검색
	var post = document.frm.postCode.value;
		 window.open("setPostcode.jsp","우편번호검색","width=500,height=300");
	 }
	 
 function check(){
	 	if(document.frm.id.value.length==0){
			alert("아이디를 입력하세요");
			document.frm.id.focus();
			return false;
		}
	 	
		if(document.frm.pass.value.length==0){
			alert("비밀번호를 입력하세요");
			document.frm.pass.focus();
			return false;
		}

		if(document.frm.pass2.value.length==0){
			alert("비밀번호를 한번 더 입력하세요");
			document.frm.pass2.focus();
			return false;
		}
		if(!(document.frm.pass.value==document.frm.pass2.value)){
			alert("비밀번호를 다시 확인해주세요");
			document.frm.pass2.focus();
			return false;
		}
		if(document.frm.name.value.length==0){
			alert("이름을 입력하세요");
			document.frm.name.focus();
			return false;
		}
		if(document.frm.email.value.length==0){
			alert("이메일을 입력하세요");
			document.frm.email.focus();
			return false;
		}
		if(document.frm.email2.value.length==0){
			alert("이메일을 한번 더 입력하세요");
			document.frm.email2.focus();
			return false;
		}
		if(!(document.frm.email.value==document.frm.email2.value)){
			alert("이메일을 다시 확인해주세요");
			document.frm.email2.focus();
			return false;
		}

	}
 


 </script>

</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/top.jsp"/>
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 본문메인이미지 -->
<div id="sub_img_member"></div>
<!-- 본문메인이미지 -->
<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="login.jsp">Login</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->
<article>
<h1>Join Us</h1>

<form action="joinPro.jsp"  name="frm"  id="join"  method="post" onsubmit="return check()">
<fieldset>
<legend>Basic Info</legend>
<label>User ID</label>
<input type="text" name="id" class="id" >
<!-- <input type=button value="중복확인" class="dup" ><br> -->
<input type=button value="중복확인" class="dup" onclick="checkId()"><br>
<label>Password</label>
<input type="password" name="pass"><br>
<label>Retype Password</label>
<input type="password" name="pass2"><br>
<label>Name</label>
<input type="text" name="name"><br>
<label>E-Mail</label>
<input type="email" name="email"><br>
<label>Retype E-Mail</label>
<input type="email" name="email2"><br>
</fieldset>

<fieldset>
<legend>Optional</legend>
<label>Post Code</label>  <!-- 상세주소 추가해야함-->
<input type="text" name="postCode" id="postCode">
<input type=button value="우편번호검색" class="post" onclick="post()" name="postButton"><br>
<label>Address</label> 
<input type="text" name="address" id="address"><br>
<label>Detail Address</label>
<input type="text" name="detailAddress" id="detailAddress"><br>
<label>Extra Address</label>
<input type="text" name="extraAddress" id="extraAddress"><br>
<label>Phone Number</label>
<input type="text" name="phone"><br>
<label>Mobile Phone Number</label>
<input type="text" name="mobile"><br>
</fieldset>
<div class="clear"></div>
<div id="buttons">
<input type="submit" value="회원가입" class="submit"> <!-- onclick 이벤트 -->
<input type="reset" value="취소" class="cancel">
</div>
</form>
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