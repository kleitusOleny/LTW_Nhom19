package controller.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class LoginGoogle extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        // Google gửi mã xác thực qua tham số "credential"
        String idTokenString = request.getParameter("credential");

        if (idTokenString != null) {
            System.out.println("Token: " + idTokenString);
            response.sendRedirect(request.getContextPath() + "/index.jsp?loginSuccess=1");
        } else {
            response.sendRedirect(request.getContextPath() + "AuthPages/Login.jsp?loginError=1");
        }
    }
}
