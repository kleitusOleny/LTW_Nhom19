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

@WebServlet(name = "OnBoardingController", value = "/OnBoardingController")
public class OnBoardingController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String emailToken = (String) request.getSession().getAttribute("googleEmail");
        if (emailToken == null) {
            response.sendRedirect(request.getContextPath() + "/AuthPages/Login.jsp");
        }
        String fullName = request.getParameter("name");
        String username = request.getParameter("username");
        String phoneNumber = request.getParameter("phone-number");
        String birth = request.getParameter("birth");

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

        if (phoneNumber == null || phoneNumber.trim().isEmpty() ||
                !phoneNumber.matches("^0\\d{9,10}$")){
            request.setAttribute("phoneNumberError", "Số điện thoại phải bắt đầu bằng số 0 và có 10-11 chữ số");
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

        String onBoardingUrl = "/AuthPages/OnBoarding.jsp";
        AuthService authService = new AuthService();
        // Nếu là false thì pass
        if (!hasError) {
            Timestamp ts = Timestamp.valueOf(birthDay.atStartOfDay());
            authService.register(fullName, emailToken, username, null, phoneNumber, ts);
            response.sendRedirect(request.getContextPath());
        } else {
            request.getRequestDispatcher(onBoardingUrl).forward(request, response);
        }
    }
}