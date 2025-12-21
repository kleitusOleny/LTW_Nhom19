/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vn.hcmuaf.nlu.fit.ltw_nhom19;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author CTT VNPAY
 */
@WebServlet("/vnpayajax")
public class ajaxServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json;charset=UTF-8");
        resp.setCharacterEncoding("UTF-8");

        Gson gson = new Gson();
        JsonObject job = new JsonObject();

        try {
            System.out.println("=== VNPay AJAX Servlet Started ===");

            // Validate amount parameter
            String amountParam = req.getParameter("amount");
            if (amountParam == null || amountParam.isEmpty()) {
                throw new IllegalArgumentException("Amount parameter is required");
            }

            String vnp_Version = "2.1.0";
            String vnp_Command = "pay";
            String orderType = "other";
            long amount = Integer.parseInt(amountParam) * 100;
            String bankCode = req.getParameter("bankCode");

            String vnp_TxnRef = Config.getRandomNumber(8);
            String vnp_IpAddr = Config.getIpAddress(req);

            String vnp_TmnCode = Config.vnp_TmnCode;
            String secretKey = Config.secretKey;

            // Validate configuration
            if (vnp_TmnCode == null || vnp_TmnCode.isEmpty()) {
                throw new IllegalStateException("VNPAY_TMN_CODE is not configured in .env file");
            }
            if (secretKey == null || secretKey.isEmpty()) {
                throw new IllegalStateException("VNPAY_HASH_SECRET is not configured in .env file");
            }

            System.out.println("TmnCode: " + vnp_TmnCode);
            System.out.println("Amount: " + amount);
            System.out.println("TxnRef: " + vnp_TxnRef);

            Map<String, String> vnp_Params = new HashMap<>();
            vnp_Params.put("vnp_Version", vnp_Version);
            vnp_Params.put("vnp_Command", vnp_Command);
            vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
            vnp_Params.put("vnp_Amount", String.valueOf(amount));
            vnp_Params.put("vnp_CurrCode", "VND");

            if (bankCode != null && !bankCode.isEmpty()) {
                vnp_Params.put("vnp_BankCode", bankCode);
            }
            vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
            vnp_Params.put("vnp_OrderInfo", "Thanh toan don hang:" + vnp_TxnRef);
            vnp_Params.put("vnp_OrderType", orderType);

            String locate = req.getParameter("language");
            if (locate != null && !locate.isEmpty()) {
                vnp_Params.put("vnp_Locale", locate);
            } else {
                vnp_Params.put("vnp_Locale", "vn");
            }
            vnp_Params.put("vnp_ReturnUrl", Config.vnp_ReturnUrl);
            vnp_Params.put("vnp_IpAddr", vnp_IpAddr);

            Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
            SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
            String vnp_CreateDate = formatter.format(cld.getTime());
            vnp_Params.put("vnp_CreateDate", vnp_CreateDate);

            cld.add(Calendar.MINUTE, 15);
            String vnp_ExpireDate = formatter.format(cld.getTime());
            vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);

            List fieldNames = new ArrayList(vnp_Params.keySet());
            Collections.sort(fieldNames);
            StringBuilder hashData = new StringBuilder();
            StringBuilder query = new StringBuilder();
            Iterator itr = fieldNames.iterator();
            while (itr.hasNext()) {
                String fieldName = (String) itr.next();
                String fieldValue = (String) vnp_Params.get(fieldName);
                if ((fieldValue != null) && (!fieldValue.isEmpty())) {
                    // Build hash data
                    hashData.append(fieldName);
                    hashData.append('=');
                    hashData.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII));
                    // Build query
                    query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII));
                    query.append('=');
                    query.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII));
                    if (itr.hasNext()) {
                        query.append('&');
                        hashData.append('&');
                    }
                }
            }
            String queryUrl = query.toString();
            String vnp_SecureHash = Config.hmacSHA512(secretKey, hashData.toString());
            queryUrl += "&vnp_SecureHash=" + vnp_SecureHash;
            String paymentUrl = Config.vnp_PayUrl + "?" + queryUrl;

            System.out.println("Payment URL generated successfully");
            System.out.println("URL length: " + paymentUrl.length());

            job.addProperty("code", "00");
            job.addProperty("message", "success");
            job.addProperty("data", paymentUrl);

        } catch (NumberFormatException e) {
            System.err.println("Error parsing amount: " + e.getMessage());
            e.printStackTrace();
            job.addProperty("code", "99");
            job.addProperty("message", "Invalid amount format: " + e.getMessage());
            job.addProperty("data", "");
        } catch (IllegalArgumentException e) {
            System.err.println("Invalid argument: " + e.getMessage());
            e.printStackTrace();
            job.addProperty("code", "99");
            job.addProperty("message", e.getMessage());
            job.addProperty("data", "");
        } catch (IllegalStateException e) {
            System.err.println("Configuration error: " + e.getMessage());
            e.printStackTrace();
            job.addProperty("code", "99");
            job.addProperty("message", "Configuration error: " + e.getMessage());
            job.addProperty("data", "");
        } catch (Exception e) {
            System.err.println("Unexpected error: " + e.getMessage());
            e.printStackTrace();
            job.addProperty("code", "99");
            job.addProperty("message", "System error: " + e.getMessage());
            job.addProperty("data", "");
        }

        resp.getWriter().write(gson.toJson(job));
        System.out.println("=== VNPay AJAX Servlet Completed ===");
    }

}
