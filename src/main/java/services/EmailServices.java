package services;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.util.Properties;

public class EmailServices {
    private final String username = "yurichangirl752@gmail.com";
    private final String password = "cieg xskp pojn vhzp";

    public boolean sendOtpEmail(String toEmail, String otp) {
        // Cấu hình SMTP Server của Gmail
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        // Tạo Session xác thực
        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Mã xác thực OTP của bạn");
            message.setText("Chào bạn,\n\nMã OTP của bạn là: " + otp +
                    "\n\nMã này có hiệu lực trong 1 phút. Vui lòng không cung cấp mã này cho bất kỳ ai.");
            Transport.send(message);
            return true;
        } catch (MessagingException e) {
            return false;
        }
    }
}
