package services;

import dao.AddressDAO;
import jakarta.servlet.http.HttpServletRequest;
import model.Address;
import model.User;

import java.util.List;

public class AddressService {
    private AddressDAO addressDAO;

    public AddressService() {
        addressDAO = new AddressDAO();
    }

    private static final String VN_TEXT_REGEX = "^[a-zA-ZÀ-Ỹà-ỹĐđ\\s]{2,50}$";

    private static final String VN_PHONE_REGEX = "^(0[3|5|7|8|9][0-9]{8}|\\+84[3|5|7|8|9][0-9]{8})$";

    public List<Address> getAll() {
        return addressDAO.getAll();
    }

    public List<Address> getByUserID(int id) {
        return addressDAO.getByUserID(id);
    }

    public boolean addAddress(Address address) {
        String error = validateAddress(address);
        if (error != null) {
            throw new IllegalArgumentException(error);
        }
        return addressDAO.create(address);
    }

    public boolean updateAddress(Address address, int userId) {

        if (address == null || address.getId() <= 0) {
            throw new IllegalArgumentException("Địa chỉ không hợp lệ");
        }

        Address old = addressDAO.findById(address);
        if (old == null || old.getUserId() != userId) {
            throw new SecurityException("Không có quyền cập nhật địa chỉ này");
        }

        String error = validateAddress(address);
        if (error != null) {
            throw new IllegalArgumentException(error);
        }
        return addressDAO.update(address);
    }

    public boolean deleteAddress(int id, int userId) {

        if (id <= 0) {
            throw new IllegalArgumentException("ID địa chỉ không hợp lệ");
        }

        Address address = new Address();
        address.setId(id);
        address.setUserId(userId);

        Address existing = addressDAO.findById(address);
        if (existing == null) {
            throw new IllegalArgumentException("Địa chỉ không tồn tại");
        }

        if (existing.getUserId() != userId) {
            throw new SecurityException("Không có quyền xóa địa chỉ này");
        }

        return addressDAO.delete(existing);
    }

    private String validateAddress(Address address) {

        if (address == null)
            return "Dữ liệu không hợp lệ";
        System.out.println(address);

        String name = address.getFullName();
        String phone = address.getPhoneNumber();
        String city = address.getCity();
        String ward = address.getWard();
        String addressLine = address.getAddressLine();

        if (name == null || !name.matches(VN_TEXT_REGEX)) {
            return "Họ tên không hợp lệ";
        }

        if (phone == null || !phone.matches(VN_PHONE_REGEX)) {
            return "Số điện thoại không hợp lệ";
        }

        if (city == null || !city.matches(VN_TEXT_REGEX)) {
            return "Thành phố/Tỉnh không hợp lệ";
        }

        if (ward == null || !ward.matches(VN_TEXT_REGEX)) {
            return "Phường/Xã không hợp lệ";
        }

        if (addressLine == null || addressLine.trim().length() < 5) {
            return "Địa chỉ cụ thể quá ngắn";
        }

        return null;
    }

    public void setDefaultAddress(int addressId, int userId) {
        if (addressId <= 0) {
            throw new IllegalArgumentException("ID địa chỉ không hợp lệ");
        }

        addressDAO.unsetAllDefaults(userId);

        Address newDefault = new Address();
        newDefault.setId(addressId);
        newDefault.setUserId(userId);
        newDefault.setDefault(true);
        addressDAO.setDefault(newDefault);
    }

    public void handleAdd(HttpServletRequest req, User user) {
        Address address = mapRequestToAddress(req);
        address.setUserId(user.getId());

        this.addAddress(address);
    }

    public void handleUpdate(HttpServletRequest req, User user) {
        int addressId = Integer.parseInt(req.getParameter("id"));

        Address address = mapRequestToAddress(req);
        address.setId(addressId);
        address.setUserId(user.getId());

        this.updateAddress(address, user.getId());
    }

    public void handleDelete(HttpServletRequest req, User user) {
        int id = Integer.parseInt(req.getParameter("id"));
        this.deleteAddress(id, user.getId());
    }

    public void handleSetDefault(HttpServletRequest req, User user) {
        int id = Integer.parseInt(req.getParameter("id"));
        this.setDefaultAddress(id, user.getId());
    }

    private Address mapRequestToAddress(HttpServletRequest req) {
        Address address = new Address();

        address.setFullName(req.getParameter("fullName"));
        address.setPhoneNumber(req.getParameter("phone"));
        address.setWard(req.getParameter("ward"));
        address.setCity(req.getParameter("city"));
        address.setAddressLine(req.getParameter("addressLine"));

        return address;
    }

}
