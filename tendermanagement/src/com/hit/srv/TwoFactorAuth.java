package com.hit.srv;

import java.util.Properties;
import java.util.Random;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class TwoFactorAuth {
    
    private static String generatedOTP;

    // Method to generate a 6-digit OTP
    public static String generateOTP() {
        Random random = new Random();
        generatedOTP = String.format("%06d", random.nextInt(999999));
        return generatedOTP;
    }

    // Method to send OTP via email
    public static void sendEmail(String recipientEmail, String otp) {
        // Your email credentials
        String fromEmail = "davidmurimidecopter@gmail.com";
        String emailPassword = "uhjo kikj fzaj atpl";

        // Email configurations
        Properties properties = new Properties();
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");

        // Authenticate with email account
        Session session = Session.getInstance(properties, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, emailPassword);
            }
        });

        try {
            // Create email message
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
            message.setSubject("Your 2FA OTP Code");
            message.setText("Your OTP code is: " + otp);

            // Send email
            Transport.send(message);
            System.out.println("OTP sent successfully to " + recipientEmail);

        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }

    // Method to verify the OTP
    public static boolean verifyOTP(String inputOTP) {
        return generatedOTP.equals(inputOTP);
    }

    public static void main(String[] args) {
        // Example usage
        String email = "recipient_email@example.com";
        
        // Generate and send OTP
        String otp = generateOTP();
        sendEmail(email, otp);
        
        // In real-world, user enters the OTP on the webpage
        // Here we simulate user input (this would come from an input form in practice)
        String userInput = "123456";  // Replace with actual user input
        
        // Verify OTP
        if (verifyOTP(userInput)) {
            System.out.println("OTP verified successfully.");
        } else {
            System.out.println("Invalid OTP.");
        }
    }
}
