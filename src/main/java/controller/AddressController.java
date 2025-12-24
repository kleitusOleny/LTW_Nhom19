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
//                fakeUser.setBirthDay(birthDate);
                fakeUser.setPasswordHash(BCrypt.hashpw("123456", BCrypt.gensalt()));
                session.setAttribute("user", fakeUser);
            }
            User user = (User) session.getAttribute("user");
            System.out.println("Getting addresses for user ID: " + user.getId());

//            List<Address> addressList = addressService.getByUserID(user.getId());
//            System.out.println("Address list size: " + addressList.size());
            // for(Address a : addressList) {
            // System.out.println("Address: " + a.getFullName() + ", " + a.getCity());
            // }
//            System.out.println(addressList);
//            request.setAttribute("addressList", addressList);
            request.getRequestDispatcher("/infoUsers/addresses.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("ERROR in AddressController.doGet: " + e.getMessage());
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

            switch (action) {
                case "add": {
                    handleAdd(request, user);
                    session.setAttribute("success", "Thêm địa chỉ thành công");
                    break;
                }
                case "delete": {
                    handleDelete(request, user);
                    session.setAttribute("success", "Xóa địa chỉ thành công");

                    break;
                }
                case "update": {
                    handleUpdate(request, user);
                    session.setAttribute("success", "Cập nhật địa chỉ thành công");
                    break;
                }
                case "default": {
                    handleSetDefault(request, user);
                    session.setAttribute("success", "Đặt địa chỉ mặc định thành công");
                    break;
                }
                default:
                    throw new IllegalArgumentException("Action không hợp lệ");
            }
        } catch (Exception e) {
            session.setAttribute("error", e.getMessage());
        }
        request.getRequestDispatcher("/infoUsers/user_sidebar.jsp").forward(request, response);
    }

    private void handleAdd(HttpServletRequest req, User user) {
        Address address = mapRequestToAddress(req);
        address.setUserId(user.getId());

//        addressService.addAddress(address);
    }

    private void handleUpdate(HttpServletRequest req, User user) {
        int addressId = Integer.parseInt(req.getParameter("id"));

        Address address = mapRequestToAddress(req);
        address.setId(addressId);
        address.setUserId(user.getId());

//        addressService.updateAddress(address, user.getId());
    }

    private void handleDelete(HttpServletRequest req, User user) {
        int id = Integer.parseInt(req.getParameter("id"));
        // addressService.deleteAddress(id, user.getId());
    }

    private void handleSetDefault(HttpServletRequest req, User user) {
        int id = Integer.parseInt(req.getParameter("id"));
//        addressService.setDefaultAddress(id, user.getId());
    }

    private Address mapRequestToAddress(HttpServletRequest req) {
        Address address = new Address();

        address.setFullName(req.getParameter("fullName"));
        address.setPhoneNumber(req.getParameter("phone"));
        address.setCity(req.getParameter("city"));
        address.setWard(req.getParameter("ward"));
        // Set country to Vietnam by default since validation requires it
        address.setCountry("Việt Nam");
        address.setAddressLine(req.getParameter("addressLine"));

        return address;
    }
}
