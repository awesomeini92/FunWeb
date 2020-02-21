<%@page import="member.memberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.IOException"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="mailtest.GoogleAuthentication"%>
<%@page import="javax.mail.Address"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.Session"%>
<%@page import="java.util.Properties"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="javax.servlet.annotation.WebServlet"%>
  
<%
request.setCharacterEncoding("utf-8");
		memberBean bb = new memberBean();
		request.setCharacterEncoding("UTF-8");
// 		String sender =request.getParameter("sender");
		String sender = "gkdl4437@gmail.com";
		String receiver = request.getParameter("email");
		out.println(receiver);
		String subject = "가입을 축하합니다.";
		String content = "가입을 축하합니다.";
		response.setContentType("text/html charset=UTF-8");
		
		try {
			Properties properties = System.getProperties();
			properties.put("mail.smtp.starttls.enable", "true");
			properties.put("mail.smtp.host", "smtp.gmail.com");
			properties.put("mail.smtp.auth", "true");
			properties.put("mail.smtp.port", "587");
			Authenticator auth = new GoogleAuthentication();
			Session s = Session.getDefaultInstance(properties, auth);
			Message message = new MimeMessage(s);
			Address sender_address = new InternetAddress(sender);
			Address receiver_address = new InternetAddress(receiver);
			message.setHeader("content-type", "text/html;charset=UTF-8");
			message.setFrom(sender_address);
			message.addRecipient(Message.RecipientType.TO, receiver_address);
			message.setSubject(subject);
			message.setContent(content, "text/html;charset=UTF-8");
			message.setSentDate(new java.util.Date());
			Transport.send(message);
			%><script type="text/javascript">
			alert("가입축하 메일이 발송되었습니다.");
			location.href="login.jsp";
			</script>
			out.println("<h3></h3>");
		<%	
		} catch (Exception e) {
			out.println("SMTP 서버가 잘못 설정되었거나, 서비스에 문제가 있습니다.");
			e.printStackTrace();
		}
		
 %>