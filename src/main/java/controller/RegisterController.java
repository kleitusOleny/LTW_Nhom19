package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import services.AuthService;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.Period;
import java.time.format.DateTimeFormatter;

@WebServlet(name = "RegisterController", value = "/RegisterController")
public class RegisterController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fullName = request.getParameter("name");
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String plainPassword = request.getParameter("password");
        String phoneNumber = request.getParameter("phone-number");
        String birth = request.getParameter("birth");
        String confirmPassword = request.getParameter("confirm-password");

        boolean hasError = false;
        long spaceCount = fullName.chars().filter(c -> c == ' ').count();

        if (fullName.trim().isEmpty() || fullName.matches(".*\\d.*") || !fullName.matches("^[\\p{L} ]+$") || fullName.matches(".*\\s{2,}.*") || spaceCount < 2) {
            request.setAttribute("fullNameError", "Họ và tên không được chứa số hoặc ký tự đặc biệt, và phải có khoảng cách giữa các từ");
            hasError = true;
        }

        if (fullName.startsWith(" ") || fullName.endsWith(" ")) {
            request.setAttribute("fullNameError2", "Họ tên không được có khoảng trắng ở đầu hoặc cuối");
            hasError = true;
        }

        if (fullName.length() < 6 || fullName.length() > 20){
            request.setAttribute("fullNameError3", "Họ và tên quá ngắn hoặc quá dài");
            hasError = true;
        }

        if (username != null) {
            username = username.trim();
            if (!username.isEmpty()) {
                if (username.length() <= 4 || username.length() >= 30) {
                    request.setAttribute("usernameError", "Tên tài khoản quá ngắn hoặc quá dài");
                    hasError = true;
                }
            }
        }

        if (email == null || email.trim().isEmpty() ||
                !email.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")) {
            request.setAttribute("emailError", "Email không đúng định dạng (ví dụ: jukisyuri@gmail.com)");
            hasError = true;
        }

        if (email.length() < 6 || email.length() > 80){
            request.setAttribute("emailError2", "Email quá ngắn hoặc quá dài");
            hasError = true;
        }

        if (plainPassword == null || plainPassword.trim().isEmpty() ||
                !plainPassword.matches("^(?=.*[a-z])(?=.*[A-Z])(?=.*[^A-Za-z0-9]).{8,}$")) {
            request.setAttribute("passwordError", "Mật khẩu cần ít nhất 8 ký tự, gồm chữ hoa, chữ thường và ký tự đặc biệt");
            hasError = true;
        }

        if (phoneNumber == null || phoneNumber.trim().isEmpty() ||
                !phoneNumber.matches("^0\\d{9,10}$")){
            request.setAttribute("phoneNumberError", "Số điện thoại phải bắt đầu bằng số 0 và có 10-11 chữ số");
            hasError = true;
        }

        if (!plainPassword.equals(confirmPassword)) {
            request.setAttribute("confirmedPasswordError", "Mật khẩu xác nhận không khớp, vui lòng nhập lại");
            hasError = true;
        }

        if (birth == null || birth.isEmpty()) {
            request.setAttribute("birthError", "Lỗi trường nhập ngày sinh");
            hasError = true;
        }

        LocalDate now = LocalDate.now();
        LocalDate birthDay = LocalDate.parse(birth) ;
        int age = Period.between(birthDay, now).getYears();
        if (age < 18) {
            request.setAttribute("ageError", "Ngày sinh không đủ tuổi");
            hasError = true;
        }

        String registerUrl = "/AuthPages/Register.jsp";
        AuthService authService = new AuthService();
        // Nếu là false thì pass
        if (!hasError) {
            Timestamp ts = Timestamp.valueOf(birthDay.atStartOfDay());
            authService.register(fullName, email, username, plainPassword, phoneNumber, ts);
            response.sendRedirect(request.getContextPath() + "/AuthPages/Login.jsp");
        } else {
            request.getRequestDispatcher(registerUrl).forward(request, response);
        }
    }
}