<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.*"%>
<%@ page import="com.oreilly.servlet.ServletUtils"%>


<%

	request.setCharacterEncoding("utf-8");

   String fileName = request.getParameter( "file_name" );
   System.out.println(fileName);
//    ServletContext context = getServletContext(); ///ServletContext 객체생성 ()
//    String savePath = "/upload";
//    String sDownloadPath = context.getRealPath(savePath); //==request.getRealPath()
   String uploadPath = request.getRealPath("/upload");
   String sFilePath = uploadPath + "\\" + fileName;
  
   
   byte b[] = new byte[4096]; //byte형 저장하는 배열
   File oFile = new File(sFilePath); //파일을 가져와 제어하기
  

   FileInputStream in = new FileInputStream(oFile); //자바에서 처리하기 위해 파일 입력

   
   String sMimeType = getServletContext().getMimeType(sFilePath); //물리적인 경로의 파일의 type 확인
   System.out.println("sMimeType>>>"+sMimeType ); //파일 타입 출력

   // octet-stream은  8비트로 된 일련의 데이터를 뜻합니다. 지정되지 않은 파일 형식을 의미합니다.
 
   //파일 타입이 없을 때 default값 설정
   if(sMimeType == null){
	   sMimeType = "application/octet-stream";
   }

   response.setContentType(sMimeType); //서버에서 파일 타입으로 설정하여 클라이언트한테 보낸다
   
   
   //브라우저 별로 한글처리
   String userAgent = request.getHeader("User-Agent"); //브라우저 확인
   boolean ie = (userAgent.indexOf("MSIE") > -1)||(userAgent.indexOf("Trident") > -1);//익스플로러인가
      
   String sEncoding=null;
   if(ie) { //익스플로러일 때 파일이름 한글처리
	  sEncoding = URLEncoder.encode(fileName, "utf-8").replaceAll("\\+", "%20");
	  System.out.println(sEncoding);
   }else{ //나머지 브라우저일 때 파일이름  한글처리
	  sEncoding = new String(fileName.getBytes("utf-8"),"8859_1");
	  System.out.println(sEncoding);
  }
   
  
   //한글 업로드 (이 부분이 한글 파일명이 깨지는 것을 방지해 줍니다.)
	//	String sEncoding = new String(fileName.getBytes("utf-8"),"8859_1");
 //  System.out.println(sEncoding);

 // 서버에서 클라이언트에 보낼때 파일을 다운(attachment)하도록 설정 					//한글처리된 파일이름
   response.setHeader("Content-Disposition", "attachment; filename= " + sEncoding);
   
 //응답 출력하기 위한 객체 생성
   ServletOutputStream out2 = response.getOutputStream();
   int numRead;

   // 바이트 배열b의 0번 부터 numRead번 까지 브라우저로 출력
   while((numRead = in.read(b, 0, b.length)) != -1) {
    out2.write(b, 0, numRead);
   }
   out2.flush(); 
   out2.close();
   in.close();

   out.clear();
	out = pageContext.pushBody();
 //  ServletUtils.returnFile( PdsMisc.UPLOAD_DIRECTORY + File.separator + StringMisc.uniToEuc( fileName ), response.getOutputStream() );
%>
