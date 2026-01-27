package dao;

import model.Manufacturer;
import java.util.List;

public class ManufacturerDAO extends ADAO {
    
    // Lấy danh sách
    public List<Manufacturer> getAllManufacturers() {
        return jdbi.withHandle(handle -> handle
                .createQuery("SELECT id, manufacturer_name, location FROM manufacturers WHERE is_delete = 0")
                .mapToBean(Manufacturer.class)
                .list());
    }
    
    // Thêm nhà sản xuất
    public int insert(Manufacturer m) {
        String query = "INSERT INTO manufacturers (manufacturer_name, location, is_delete) VALUES (:manufacturerName, :location, 0)";
        return jdbi.withHandle(handle ->
                handle.createUpdate(query)
                        .bindBean(m)
                        .execute());
    }
    
    // Xóa nhà sản xuất
    public int delete(int id) {
        String query = "UPDATE manufacturers SET is_delete = 1 WHERE id = :id";
        return jdbi.withHandle(handle ->
                handle.createUpdate(query)
                        .bind("id", id)
                        .execute());
    }
    
    public int update(Manufacturer m) {
        String query = "UPDATE manufacturers SET manufacturer_name = :manufacturerName, location = :location WHERE id = :id";
        return jdbi.withHandle(handle ->
                handle.createUpdate(query)
                        .bind("id", m.getId())
                        .bind("manufacturerName", m.getManufacturerName())
                        .bind("location", m.getLocation())
                        .execute());
    }
}