package dao;

import model.User;

import java.util.List;

public class UserDAO extends ADAO implements IDAO<User> {
    @Override
    public List<User> getAll() {
        return jdbi.withHandle(handle ->
                handle.createQuery("SELECT id, email, username, password_hash AS passwordHash, phone_number AS phoneNumber, active, created_at AS createdAt, birth_day AS birthDay, full_name AS fullName FROM users")
                        .mapToBean(User.class)
                        .list()
        );
    }

    @Override
    public User findById(User entity) {
        return jdbi.withHandle(handle -> handle.createQuery("select * from users where id=:id")
                .bind("id", entity.getId()).mapToBean(User.class).findFirst().orElse(null));
    }

    @Override
    public boolean create(User entity) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("INSERT INTO users (email, username, password_hash, phone_number, full_name, birth_day, administrator, active, created_at) " +
                                "VALUES (:email, :username, :passwordHash, :phoneNumber, :fullName, :birthDay, :administrator, :active, :createdAt)")
                        .bindBean(entity) // Dùng bindBean cho nhanh vì tên field khớp với tên tham số
                        .execute() > 0
        );
    }

    @Override
    public boolean update(User entity) {
        return jdbi.withHandle(handle -> handle.createUpdate("""
                        UPDATE users
                        SET\s
                        username=:username,
                        email=:email,
                        phone_number=:phone_number,
                        birth_day=:birth_day,
                        active=:active
                       \sWHERE user_id=:user_id""")
                .bind("user_id", entity.getId())
                .bind("username", entity.getUsername())
                .bind("email", entity.getEmail())
                .bind("phone_number", entity.getPhoneNumber())
                .bind("birth_day", entity.getBirthDay())
                .bind("active", entity.getActive())
                .execute() > 0);
    }

    @Override
    public boolean delete(User id) {
        throw new UnsupportedOperationException("Chưa hỗ trợ");
    }

    @Override
    public List<User> search(String keyword) {
        throw new UnsupportedOperationException("Chưa hỗ trợ");
    }

    @Override
    public boolean exists(User id) {
        throw new UnsupportedOperationException("Chưa hỗ trợ");
    }


    public boolean updateActiveStatus(User entity) {
        return jdbi.withHandle(handle -> handle.createUpdate("""
                UPDATE users
                SET
                active=:active
                WHERE id=:id""")
                .bind("id", entity.getId())
                .bind("active", entity.getActive())
                .execute() > 0);
    }

    public User findByEmail(String email) {
        return jdbi.withHandle(handle -> handle.createQuery("select * from users where email = :email and active = 1")
                .bind("email", email)
                .mapToBean(User.class)
                .findFirst()
                .orElse(null));
    }

    public User findByUsername(String username) {
        return jdbi.withHandle(handle -> handle.createQuery("select * from users where username=:username and active=:true")
                .bind("username", username).mapToBean(User.class).findFirst().orElse(null));
    }

    public boolean updatePassword(String email, String newPasswordHashed) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("update users set password_hash = :passwordHash where email = :email")
                        .bind("passwordHash", newPasswordHashed)
                        .bind("email", email)
                        .execute() > 0
        );
    }

    public int countUserId(String email) {
        return jdbi.withHandle(handle -> handle.createQuery("select count(id) from users where email = :email")
                .bind("email", email)
                .mapTo(Integer.class)
                .findOnly());
    }
}
