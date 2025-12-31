package services;

import java.time.LocalDate;
import java.time.Period;
import java.util.HashMap;
import java.util.Map;

public class UserValidationServices {
    public Map<String, String> validateFirstAndLastName(String lastName, String firstName) {
        Map<String, String> errors = new HashMap<>();

        // Trường kiểm tra tên
        if (firstName.trim().isEmpty()){
            errors.put("firstNameError", "Tên không được để trống");
        } else {
            if (firstName.startsWith(" ") || firstName.endsWith(" ")) {
                errors.put("firstNameError", "Tên không được có khoảng trắng ở đầu hoặc cuối");
            }
            if (!firstName.matches("^[\\p{L}]+( [\\p{L}]+)*$")) {
                errors.put("firstNameError2", "Tên không hợp lệ (không chứa số, ký tự đặc biệt hoặc khoảng trắng kép)");
            }
            if (firstName.length() < 2 || firstName.length() > 30) {
                errors.put("firstNameError3", "Tên quá dài hoặc quá ngắn");
            }
        }
        // Trường kiểm tra họ
        if (lastName.trim().isEmpty()) {
            errors.put("lastNameError", "Họ không được để trống");
        } else {
            if (lastName.startsWith(" ") || lastName.endsWith(" ")) {
                errors.put("lastNameError", "Họ không được có khoảng trắng ở đầu hoặc cuối");
            }
            if (!lastName.matches("^[\\p{L}]+( [\\p{L}]+)*$")) {
                errors.put("lastNameError2", "Họ không hợp lệ (không chứa số, ký tự đặc biệt hoặc khoảng trắng kép)");
            }
            if (lastName.length() < 2 || lastName.length() > 20) {
                errors.put("lastNameError3", "Họ quá dài hoặc quá ngắn");
            }
        }
        return errors;
    }

    public Map<String, String> validateFullName(String fullName){
        Map<String, String> errors = new HashMap<>();

        if (fullName.trim().isEmpty()) {
            errors.put("fullNameError", "Họ và tên không được để trống");
        } else {
            if (!fullName.matches("^[\\p{L}]+( [\\p{L}]+)*$")) {
                errors.put("fullNameError", "Họ tên không hợp lệ (không chứa số, ký tự đặc biệt hoặc khoảng trắng thừa)");
            }
            if (fullName.startsWith(" ") || fullName.endsWith(" ")) {
                errors.put("fullNameError2", "Họ tên không được có khoảng trắng ở đầu hoặc cuối");
            }
            if (fullName.length() < 5 || fullName.length() > 51) { // tính thêm khoảng trắng
                errors.put("fullNameError3", "Họ và tên quá ngắn hoặc quá dài");
            }
        }
        return errors;
    }

    public Map<String, String> validateUsername(String username){
        Map<String, String> errors = new HashMap<>();
        if (username != null) {
            username = username.trim();
            if (!username.isEmpty()) {
                if (username.length() < 4 || username.length() > 30) {
                    errors.put("usernameError", "Tên tài khoản quá ngắn hoặc quá dài");
                }
            }
        }
        return errors;
    }

    public Map<String, String> validateEmail(String email) {
        Map<String, String> errors = new HashMap<>();
        if (email == null || email.trim().isEmpty() ||
                !email.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")) {
            errors.put("emailError", "Email không đúng định dạng (ví dụ: jukisyuri@gmail.com)");
        }
        if (email.length() < 6 || email.length() > 100){
            errors.put("emailError2", "Email quá ngắn hoặc quá dài");
        }
        return errors;
    }

    public Map<String, String> validateBothUsernameAndEmail(String usernameOrEmail, String password){
        Map<String, String> errors = new HashMap<>();
        if (usernameOrEmail == null || password == null || usernameOrEmail.isEmpty() || password.isEmpty()) {
            errors.put("inputError", "Tên tài khoản/email hoặc mật khẩu hiện không chứa nội dung gì");
        }
        if (usernameOrEmail.length() < 4 || usernameOrEmail.length() > 80) {
            errors.put("usernameError", "Tên tài khoản hoặc email quá ngắn hoặc quá dài");
        }
        return errors;
    }

    public Map<String, String> validatePassword(String plainPassword){
        Map<String, String> errors = new HashMap<>();
        if (plainPassword == null || plainPassword.trim().isEmpty() ||
                !plainPassword.matches("^(?=.*[a-z])(?=.*[A-Z])(?=.*[^A-Za-z0-9]).{8,}$")) {
            errors.put("passwordError", "Mật khẩu cần ít nhất 8 ký tự, gồm chữ hoa, chữ thường và ký tự đặc biệt");
        }
        return errors;
    }

    public Map<String, String> validatePhoneNumber(String phoneNumber){
        Map<String, String> errors = new HashMap<>();
        if (phoneNumber == null || phoneNumber.trim().isEmpty() ||
                !phoneNumber.matches("^0\\d{9,10}$")){
            errors.put("phoneNumberError", "Số điện thoại phải bắt đầu bằng số 0 và có 10-11 chữ số");
        }
        return errors;
    }

    public Map<String, String> validateBirth(String birth){
        Map<String, String> errors = new HashMap<>();
        if (birth == null || birth.isEmpty()) {
            errors.put("birthError", "Lỗi trường nhập ngày sinh");
        }
        LocalDate now = LocalDate.now();
        LocalDate birthDay = LocalDate.parse(birth);
        int age = Period.between(birthDay, now).getYears();
        if (age < 18) {
            errors.put("ageError", "Ngày sinh không đủ tuổi");
        }
        return errors;
    }

    public Map<String, String> isPasswordEqualConfirmed(String plainPassword, String confirmPassword){
        Map<String, String> errors = new HashMap<>();
        if (!plainPassword.equals(confirmPassword)) {
            errors.put("confirmedPasswordError", "Mật khẩu xác nhận không khớp, vui lòng nhập lại");
        }
        return errors;
    }
}
