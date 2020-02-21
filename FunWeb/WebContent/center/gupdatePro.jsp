<%@page import="reference.referenceDAO"%>
<%@page import="reference.referenceBean"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="board.boardDAO"%>
<%@page import="board.boardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String uploadPath =request.getRealPath("/upload"); //업로드 할 폴더의 물리적인 경로

System.out.println(uploadPath); //파일이 저장된 가상 주소 출력

//업로드 할 파일 크기 => 5M
int maxSize = 5*1024*1024;

//MultipartRequest(리퀘스트 정보, 업로드할 폴더위치, 파일 크기, 한글처리, 이름동일시이름변경)
MultipartRequest mr = new MultipartRequest(request, uploadPath, maxSize, "utf-8", new DefaultFileRenamePolicy());

request.setCharacterEncoding("utf-8"); //post 방식일 때 한글처리
String name = (String)session.getAttribute("id");
String pass = mr.getParameter("pass");
String subject = mr.getParameter("subject");
String content = mr.getParameter("content");
int num = Integer.parseInt(mr.getParameter("num"));
String file = mr.getFilesystemName("file");
String old_file = mr.getParameter("old_file");


referenceBean rb = new referenceBean();
rb.setNum(num);
rb.setName(name);
rb.setSubject(subject);
rb.setContent(content);

if(file != null){
	rb.setFile(file);
}else{
	rb.setFile(old_file);
}


referenceDAO rd = new referenceDAO();
rd.updateReference(rb);
int check = rd.updateReference(rb);

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

