
package vn.hcmuaf.nlu.fit.ltw_nhom19;

import java.io.UnsupportedEncodingException;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Random;
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import io.github.cdimascio.dotenv.Dotenv;
import jakarta.servlet.http.HttpServletRequest;

/**
 *
 * @author CTT VNPAY
 */
public class Config {
    public static Dotenv dotenv;
    public static String vnp_PayUrl = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html";
    public static String vnp_ReturnUrl = "http://localhost:8080/LTW_Nhom19_war/vnpay/vnpay_return.jsp";
    public static String vnp_TmnCode;
    public static String secretKey;
    public static String vnp_ApiUrl = "https://sandbox.vnpayment.vn/merchant_webapi/api/transaction";

    static {
        try {
            // Try to load from classpath first
            dotenv = Dotenv.configure()
                    .ignoreIfMissing()
                    .load();

            // If not found in classpath, try project root
            if (dotenv.get("VNPAY_TMN_CODE") == null) {
                String projectRoot = System.getProperty("user.dir");
                dotenv = Dotenv.configure()
                        .directory(projectRoot)
                        .ignoreIfMissing()
                        .load();
            }

            // Get values from dotenv or use defaults/environment variables
            vnp_TmnCode = dotenv.get("VNPAY_TMN_CODE", System.getenv("VNPAY_TMN_CODE"));
            secretKey = dotenv.get("VNPAY_HASH_SECRET", System.getenv("VNPAY_HASH_SECRET"));

            // Validate that we have the required configuration
            if (vnp_TmnCode == null || vnp_TmnCode.isEmpty()) {
                System.err.println("WARNING: VNPAY_TMN_CODE is not configured!");
            }
            if (secretKey == null || secretKey.isEmpty()) {
                System.err.println("WARNING: VNPAY_HASH_SECRET is not configured!");
            }

            System.out.println("VNPay Config loaded successfully");
            System.out.println("TmnCode configured: " + (vnp_TmnCode != null && !vnp_TmnCode.isEmpty()));
            System.out.println("SecretKey configured: " + (secretKey != null && !secretKey.isEmpty()));

        } catch (Exception e) {
            System.err.println("Error loading .env file: " + e.getMessage());
            e.printStackTrace();

            // Fallback to environment variables
            vnp_TmnCode = System.getenv("VNPAY_TMN_CODE");
            secretKey = System.getenv("VNPAY_HASH_SECRET");

            System.out.println("Fallback to environment variables");
            System.out.println("TmnCode from env: " + (vnp_TmnCode != null && !vnp_TmnCode.isEmpty()));
            System.out.println("SecretKey from env: " + (secretKey != null && !secretKey.isEmpty()));
        }
    }

    public static String md5(String message) {
        String digest = null;
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] hash = md.digest(message.getBytes(StandardCharsets.UTF_8));
            StringBuilder sb = new StringBuilder(2 * hash.length);
            for (byte b : hash) {
                sb.append(String.format("%02x", b & 0xff));
            }
            digest = sb.toString();
        } catch (NoSuchAlgorithmException ex) {
            digest = "";
        }
        return digest;
    }

    public static String Sha256(String message) {
        String digest = null;
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(message.getBytes(StandardCharsets.UTF_8));
            StringBuilder sb = new StringBuilder(2 * hash.length);
            for (byte b : hash) {
                sb.append(String.format("%02x", b & 0xff));
            }
            digest = sb.toString();
        } catch (NoSuchAlgorithmException ex) {
            digest = "";
        }
        return digest;
    }

    // Util for VNPAY
    public static String hashAllFields(Map fields) {
        List fieldNames = new ArrayList(fields.keySet());
        Collections.sort(fieldNames);
        StringBuilder sb = new StringBuilder();
        Iterator itr = fieldNames.iterator();
        while (itr.hasNext()) {
            String fieldName = (String) itr.next();
            String fieldValue = (String) fields.get(fieldName);
            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                sb.append(fieldName);
                sb.append("=");
                sb.append(fieldValue);
            }
            if (itr.hasNext()) {
                sb.append("&");
            }
        }
        return hmacSHA512(secretKey, sb.toString());
    }

    public static String hmacSHA512(final String key, final String data) {
        try {

            if (key == null || data == null) {
                throw new NullPointerException();
            }
            final Mac hmac512 = Mac.getInstance("HmacSHA512");
            byte[] hmacKeyBytes = key.getBytes();
            final SecretKeySpec secretKey = new SecretKeySpec(hmacKeyBytes, "HmacSHA512");
            hmac512.init(secretKey);
            byte[] dataBytes = data.getBytes(StandardCharsets.UTF_8);
            byte[] result = hmac512.doFinal(dataBytes);
            StringBuilder sb = new StringBuilder(2 * result.length);
            for (byte b : result) {
                sb.append(String.format("%02x", b & 0xff));
            }
            return sb.toString();

        } catch (Exception ex) {
            return "";
        }
    }

    public static String getIpAddress(HttpServletRequest request) {
        String ipAdress;
        try {
            ipAdress = request.getHeader("X-FORWARDED-FOR");
            if (ipAdress == null) {
                ipAdress = request.getRemoteAddr();
            }
        } catch (Exception e) {
            ipAdress = "Invalid IP:" + e.getMessage();
        }
        return ipAdress;
    }

    public static String getRandomNumber(int len) {
        Random rnd = new Random();
        String chars = "0123456789";
        StringBuilder sb = new StringBuilder(len);
        for (int i = 0; i < len; i++) {
            sb.append(chars.charAt(rnd.nextInt(chars.length())));
        }
        return sb.toString();
    }
}
