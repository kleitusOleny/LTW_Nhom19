package dao;

import model.User;

import java.util.List;

public class UseDAO extends ADAO implements IDAO<User> {
    @Override
    public List<User> getAll() {
        return List.of();
    }

    @Override
    public User findById(User id) {
        return null;
    }

    @Override
    public boolean create(User entity) {
        return false;
    }

    @Override
    public boolean update(User entity) {
        return jdbi.withHandle(handle -> handle.createUpdate("""
                        UPDATE users
                        SET 
                        username=:username,
                        email=:email,
                        phone_number:phone_number,
                        birth_day=:birth_day,
                        password_hash=:password_hash
                        """).bind("username", entity.getUserName())
                .bind("email", entity.getEmail())
                .bind("phone_number", entity.getPhoneNumber())
                .bind("birth_day", entity.getBirthDay())
                .bind("password_hash", entity.getPasswordHash()).execute() > 0);
    }

    @Override
    public boolean delete(User id) {
        return false;
    }

    @Override
    public List<User> search(String keyword) {
        return List.of();
    }

    @Override
    public boolean exists(User id) {
        return false;
    }
}
