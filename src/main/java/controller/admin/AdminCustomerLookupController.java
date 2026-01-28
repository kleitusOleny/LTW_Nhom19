package controller.admin;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import dao.AddressDAO;
import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Address;
import model.User;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@WebServlet(name = "AdminCustomerLookupController", value = "/admin/api/customer")
public class AdminCustomerLookupController extends HttpServlet {

    private transient UserDAO userDAO;
    private transient AddressDAO addressDAO;
    private transient Gson gson;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
        addressDAO = new AddressDAO();
        gson = new GsonBuilder().serializeNulls().create();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String query = request.getParameter("keyword");
        if (query == null || query.trim().isEmpty()) {
            writeJson(response, Map.of(
                    "found", false,
                    "message", "Vui lòng nhập email hoặc số điện thoại."));
            return;
        }

        query = query.trim();
        User user = userDAO.findByEmail(query);
        if (user == null) {
            user = userDAO.findByPhoneNumber(query);
        }

        if (user == null) {
            writeJson(response, Map.of(
                    "found", false,
                    "message", "Không tìm thấy khách hàng phù hợp."));
            return;
        }

        List<Address> addresses = addressDAO.getByUserID(user.getId());
        Address preferred = addresses.stream()
                .filter(Address::isDefault)
                .findFirst()
                .orElse(addresses.isEmpty() ? null : addresses.get(0));

        String addressText = preferred == null
                ? null
                : formatAddress(preferred);

        writeJson(response, Map.of(
                "found", true,
                "fullName", user.getFullName(),
                "email", user.getEmail(),
                "phone", user.getPhoneNumber(),
                "address", addressText,
                "addressId", preferred != null ? preferred.getId() : null,
                "userId", user.getId()));
    }

    private String formatAddress(Address address) {
        return List.of(address.getAddressLine(), address.getWard(), address.getCity())
                .stream()
                .filter(part -> part != null && !part.isBlank())
                .collect(Collectors.joining(", "));
    }

    private void writeJson(HttpServletResponse response, Map<String, ?> payload) throws IOException {
        try (PrintWriter writer = response.getWriter()) {
            writer.print(gson.toJson(payload));
        }
    }
}
