<%@page import="reference.referenceDAO"%>
<%@page import="reference.referenceBean"%>
<%@page import="board.boardDAO"%>
<%@page import="board.boardBean"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//center/fwritePro.jsp
//WebContent upload 폴더 만들기

String uploadPath =request.getRealPath("/upload"); //업로드 할 폴더의 물리적인 경로

System.out.println(uploadPath); //파일이 저장된 가상 주소 출력

//업로드 할 파일 크기 => 5M
int maxSize = 5*1024*1024;

//MultipartRequest(리퀘스트 정보, 업로드할 폴더위치, 파일 크기, 한글처리, 이름동일시이름변경)
MultipartRequest mr = new MultipartRequest(request, uploadPath, maxSize, "utf-8", new DefaultFileRenamePolicy());

String name = (String)session.getAttribute("id");
String pass = mr.getParameter("pass");
String subject = mr.getParameter("subject");
String content = mr.getParameter("content");
String file = mr.getFilesystemName("file");

int num=1;
int readcount=0;

referenceBean rb = new referenceBean();
rb.setNum(num);
rb.setName(name);
rb.setPass(pass);
rb.setSubject(subject);
rb.setContent(content);
rb.setReadcount(readcount);
System.out.println(file);
rb.setFile(file);

referenceDAO rd = new referenceDAO();
rd.insertReference(rb);

response.sendRedirect("fnotice.jsp");

%>