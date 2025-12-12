package dao;

import db.JdbiConnector;
import model.Address;
import org.jdbi.v3.core.Jdbi;

import java.util.List;

public class AddressDAO extends ADAO implements IDAO<Address> {
    @Override
    public List<Address> getAll() {
        return jdbi.withHandle(handle -> {
            return handle.createQuery("select * from addresses where is_delete = 0").mapToBean(Address.class).list();
        });
    }

    @Override
    public Address findById(Address id) {
        return jdbi.withHandle(handle -> {
            return handle.createQuery("select full_name, phone_number, address_line,city,country,is_default from addresses where user_id=:id AND id=:id").bind("user_id", id.getUserId()).bind("id", id.getId()).mapToBean(Address.class).findOnly();
        });
    }

    @Override
    public boolean create(Address entity) {
        return jdbi.withHandle(handle -> handle.createUpdate("""
                INSERT INTO addresses (full_name, phone_number, city, country, address_line) VALUES (:full_name, :phone_number, :city, :country, :address_line)
                """).bind("full_name", entity.getFullName()).bind("phone_number", entity.getPhoneNumber()).bind("city", entity.getCity()).bind("country", entity.getCountry()).bind("address_line", entity.getAddressLine()).execute() > 0);
    }


    @Override
    public boolean update(Address entity) {
        return jdbi.withHandle(handle -> handle.createUpdate("""
                 UPDATE addresses
                 SET full_name = :full_name,
                     phone_number = :phone_number,
                     city = :city,
                     country = :country,
                     address_line = :address_line
                 WHERE user_id=:uid AND id=:id
                """).bind("user_id", entity.getUserId()).bind("id", entity.getId()).bind("full_name", entity.getFullName()).bind("phone_number", entity.getPhoneNumber()).bind("city", entity.getCity()).bind("country", entity.getCountry()).bind("address_line", entity.getAddressLine()).execute() > 0);
    }

    @Override
    public boolean delete(Address id) {
        return jdbi.withHandle(handle -> handle.createUpdate("""
                 DELETE FROM addresses
                 WHERE user_id=:uid AND id=:id
                """).bind("user_id", id.getUserId()).bind("id", id.getId()).execute() > 0);
    }

    @Override
    public List<Address> search(String keyword) {
        return null;
    }

    @Override
    public boolean exists(Address entity) {
        return jdbi.withHandle(handle ->
                handle.createQuery("""
                                    SELECT 1 
                                    FROM addresses 
                                    WHERE user_id = :uid 
                                      AND address_line = :address_line
                                """)
                        .bind("uid", entity.getUserId())
                        .bind("address_line", entity.getAddressLine())
                        .mapTo(Integer.class)
                        .findFirst()
                        .isPresent()
        );
    }

    public List<Address> getByUserID(int id) {
        return jdbi.withHandle(handle -> {
            return handle.createQuery("select full_name, phone_number, address_line,city,country,is_default from addresses where user_id=:id").bind("user_id", id).mapToBean(Address.class).list();
        });
    }

    public void setDefault(Address a) {
        a.setDefault(true);
        jdbi.withHandle(handle -> handle.createUpdate("""
                 UPDATE addresses
                 SET is_default=:bl
                 WHERE user_id=:uid AND id=:id
                """).bind("user_id", a.getUserId()).bind("id", a.getId()).bind("is_default", a.isDefault()));
    }

}
