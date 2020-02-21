<%@page import="gallary.gallaryDAO"%>
<%@page import="gallary.gallaryBean"%>
<%@page import="board.boardDAO"%>
<%@page import="board.boardBean"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>board/writeForm.jsp</h1>

<%
//파일 업로드

//업로드 할 폴더 만들기 WebContent - upload폴더 만들기
String uploadPath =request.getRealPath("/upload"); //업로드 할 폴더의 물리적인 경로

System.out.println(uploadPath); //파일이 저장된 가상 주소 출력

//업로드 할 파일 크기 => 5M
int maxSize = 5*1024*1024;

//MultipartRequest(리퀘스트 정보, 업로드할 폴더위치, 파일 크기, 한글처리, 이름동일시이름변경)
MultipartRequest mr = new MultipartRequest(request, uploadPath, maxSize, "utf-8", new DefaultFileRenamePolicy());
																					//cos.jar에서 지원	
												
String name = (String)session.getAttribute("id");
String pass = mr.getParameter("pass");
String subject = mr.getParameter("subject");
String content = mr.getParameter("content");
String file = mr.getFilesystemName("file"); //첨부파일 이름 가져오기 (폴더에 업로드 된 파일이름)


//num=1, readcount 0 date 현시스템날짜 now()
int num=1;
int readcount=0;

gallaryBean gb = new gallaryBean();
gb.setNum(num);
gb.setName(name);
gb.setPass(pass);
gb.setSubject(subject);
gb.setContent(content);
gb.setFile(file);

gallaryDAO gd = new gallaryDAO();
gd.insertGallary(gb);

response.sendRedirect("gnotice.jsp");

%>

</body>
</html>