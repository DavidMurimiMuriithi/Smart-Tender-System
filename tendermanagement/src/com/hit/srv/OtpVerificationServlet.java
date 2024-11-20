package com.hit.srv;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/OtpVerificationServlet")
public class OtpVerificationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public OtpVerificationServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String userEmail = (String) session.getAttribute("username");  // Get the email stored in the session
		PrintWriter out = response.getWriter();
		
		// Generate a random OTP
		Random rand = new Random();
		int otp = rand.nextInt(900000) + 100000;  // Generates a 6-digit OTP
		
		// Store OTP in session for future validation
		session.setAttribute("otp", otp);

		// Email sending configuration (using Gmail SMTP server as an example)
		final String senderEmail = "davidmurimidecopter@gmail.com";  // Replace with your email
		final String senderPassword = "uhjo kikj fzaj atpl";      // Replace with your email password
		String host = "smtp.gmail.com";

		// Setup properties for the mail session
		Properties properties = new Properties();
		properties.put("mail.smtp.auth", "true");
		properties.put("mail.smtp.starttls.enable", "true");
		properties.put("mail.smtp.host", host);
		properties.put("mail.smtp.port", "587");

		// Get the default session object
		Session mailSession = Session.getInstance(properties, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(senderEmail, senderPassword);
			}
		});

		try {
			// Create a default MimeMessage object
			MimeMessage message = new MimeMessage(mailSession);

			// Set From: header field of the header
			message.setFrom(new InternetAddress(senderEmail));

			// Set To: header field of the header
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(userEmail));

			// Set Subject: header field
			message.setSubject("Your OTP Code");

			// Set the actual message
			message.setText("Dear user, your OTP code is: " + otp);

			// Send message
			Transport.send(message);
			System.out.println("OTP sent successfully to: " + userEmail);

			// Redirect user to OTP verification page
			response.sendRedirect("verifyOtp.jsp");

		} catch (MessagingException mex) {
			mex.printStackTrace();
			out.println("Failed to send OTP. Please try again.");
		}
	}
}
