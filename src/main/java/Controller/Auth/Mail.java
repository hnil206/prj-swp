package Controller.Auth;

import Model.Config;
import jakarta.servlet.http.HttpServletRequest;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.io.UnsupportedEncodingException;
import java.util.Properties;

public class Mail {
    public static String getHost(HttpServletRequest request){
        String domain = request.getServerName();
        String protocol = request.getScheme();
        int port = request.getServerPort();
        String context = request.getContextPath();
        return protocol + "://" + domain +":"+ port + context;
    }
    public static boolean send(String mail_to,String subject, String html){
        Properties properties = new Properties();
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");
        properties.put("mail.smtp.auth", "true"); // if authentication is required
        properties.put("mail.smtp.starttls.enable", "true"); // if using TLS
        Session session = Session.getInstance(properties, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(Config.map.get("email_address"), Config.map.get("email_address_password"));
            }
        });
        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(Config.map.get("email_address"), Config.map.get("email_address_show")));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(mail_to));
            message.setSubject(subject);
            message.setContent(html, "text/html; charset=UTF-8");
            Transport.send(message);
            return true;
        } catch (MessagingException | UnsupportedEncodingException e) {
            e.printStackTrace();
            return false;
        }
    }
}
