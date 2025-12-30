package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Address;
import model.User;
import org.mindrot.jbcrypt.BCrypt;
import services.AddressService;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@WebServlet(name = "AddressController", value = "/address")
public class AddressController extends HttpServlet {
    private AddressService addressService;

    public AddressController() {
        addressService = new AddressService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession(true);
            if (session == null || session.getAttribute("user") == null) {
                response.sendRedirect(request.getContextPath() + "/AuthPages/Login.jsp");
                return;
            }
            User user = (User) session.getAttribute("user");
            List<Address> addressList = addressService.getByUserID(user.getId());
            request.setAttribute("addressList", addressList);
            request.getRequestDispatcher("/infoUsers/addresses.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error loading addresses", e);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        // if (session == null || session.getAttribute("user") == null) {
        // response.sendRedirect(request.getContextPath() + "/login");
        // return;
        // }
        if (session.getAttribute("user") == null) {
            User fakeUser = new User();
            fakeUser.setId(1);
            fakeUser.setFullName("Nguyễn Văn A");
            fakeUser.setEmail("test@gmail.com");
            fakeUser.setPhoneNumber("0909999999");
            LocalDate localDate = LocalDate.of(2000, 11, 20);
            LocalDateTime birthDate = localDate.atStartOfDay();
//            fakeUser.setBirthDay(birthDate);
            fakeUser.setPasswordHash(BCrypt.hashpw("123456", BCrypt.gensalt()));
            session.setAttribute("user", fakeUser);
        }
        User user = (User) session.getAttribute("user");
        String action = request.getParameter("action");
        try {
            System.out.println(action);
            switch (action) {
                case "add": {
                    addressService.handleAdd(request, user);
                    session.setAttribute("success", "Thêm địa chỉ thành công");
                    break;
                }
                case "delete": {
                    addressService.handleDelete(request, user);
                    session.setAttribute("success", "Xóa địa chỉ thành công");

                    break;
                }
                case "edit": {
                    addressService.handleUpdate(request, user);
                    session.setAttribute("success", "Cập nhật địa chỉ thành công");
                    break;
                }
                case "default": {
                    addressService.handleSetDefault(request, user);
                    session.setAttribute("success", "Đặt địa chỉ mặc định thành công");
                    break;
                }
                default:
                    throw new IllegalArgumentException("Action không hợp lệ");
            }
        } catch (Exception e) {
            session.setAttribute("error", e.getMessage());
        }
        response.sendRedirect(request.getContextPath() + "/infoUsers/user_sidebar.jsp#" + request.getContextPath() + "/address");
    }

}
