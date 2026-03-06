package dao;

import model.User;

import java.util.List;

public class UserDAO extends ADAO implements IDAO<User> {
    @Override
    public List<User> getAll() {
        return jdbi.withHandle(handle -> handle.createQuery("""
                         SELECT\s
                             id,
                             email,\s
                             username,
                             password_hash,
                             phone_number,
                             active,\s
                             created_at,
                             birth_day,
                             full_name,
                             administrator
                         FROM users
                        \s""")
                .mapToBean(User.class)
                .list());
    }

    @Override
    public User findById(User entity) {
        return jdbi.withHandle(handle ->
                handle.createQuery("""
                                    SELECT id, email, username,
                                           password_hash,
                                           phone_number,
                                           full_name,
                                           birth_day,
                                           administrator,
                                           active,
                                           created_at,
                                           update_at
                                    FROM users
                                    WHERE id = :id
                                """)
                        .bind("id", entity.getId())
                        .mapToBean(User.class)
                        .findFirst()
                        .orElse(null)
        );
    }

@Override
public boolean create(User entity) {
    int generatedId = jdbi.withHandle(handle -> handle
            .createUpdate(
                    """
                             INSERT INTO users 
                             (email, username, password_hash, phone_number, full_name, birth_day, administrator, active, created_at)
                             VALUES 
                             (:email, :username, :passwordHash, :phoneNumber, :fullName, :birthDay, :administrator, :active, :createdAt)
                            """)
            .bind("email", entity.getEmail())
            .bind("username", entity.getUsername())
            .bind("passwordHash", entity.getPasswordHash())
            .bind("phoneNumber", entity.getPhoneNumber())
            .bind("fullName", entity.getFullName())
            .bind("birthDay", entity.getBirthDay())
            .bind("administrator", entity.getAdministrator())
            .bind("active", entity.getActive())
            .bind("createdAt", entity.getCreatedAt())
            .executeAndReturnGeneratedKeys("id")
            .mapTo(Integer.class)
            .one());
    if (generatedId > 0) {
        entity.setId(generatedId);
        return true;
    }
    return false;
}

@Override
public boolean update(User entity) {
    boolean hashPassword = entity.getPasswordHash() != null && !entity.getPasswordHash().trim().isEmpty();
    StringBuilder sql = new StringBuilder("UPDATE users SET ");
    sql.append("username=:username, ");
    sql.append("full_name=:full_name, ");
    sql.append("email=:email, ");
    if (hashPassword) {
        sql.append("password_hash=:password_hash, ");
    }
    sql.append("phone_number=:phone_number, ");
    sql.append("birth_day=:birth_day, ");
    sql.append("active=:active, ");
    sql.append("update_at=:update_at, ");
    sql.append("administrator=:administrator ");
    sql.append("WHERE id=:id");
    return jdbi.withHandle(handle -> {
        var query = handle.createUpdate(sql.toString())
                .bind("id", entity.getId())
                .bind("username", entity.getUsername())
                .bind("full_name", entity.getFullName())
                .bind("email", entity.getEmail())
                .bind("phone_number", entity.getPhoneNumber())
                .bind("birth_day", entity.getBirthDay())
                .bind("active", entity.getActive())
                .bind("administrator", entity.getAdministrator())
                .bind("update_at", entity.getUpdateAt());
        if (hashPassword) {
            query.bind("password_hash", entity.getPasswordHash());
        }
        return query.execute() > 0;
    });
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
    return jdbi.withHandle(handle -> handle.createQuery("""
                    SELECT
                        id,
                        email,
                        username,
                        password_hash AS passwordHash,
                        phone_number AS phoneNumber,
                        full_name AS fullName,
                        birth_day AS birthDay,
                        administrator,
                        active,
                        created_at AS createdAt,
                        update_at AS updateAt
                    FROM users
                    WHERE email=:email
                    """)
            .bind("email", email)
            .mapToBean(User.class)
            .findFirst()
            .orElse(null));
}

public User findByPhoneNumber(String phoneNumber) {
    return jdbi.withHandle(handle -> handle.createQuery("""
                    SELECT
                        id,
                        email,
                        username,
                        password_hash AS passwordHash,
                        phone_number AS phoneNumber,
                        full_name AS fullName,
                        birth_day AS birthDay,
                        administrator,
                        active,
                        created_at AS createdAt,
                        update_at AS updateAt
                    FROM users
                    WHERE phone_number = :phone
                    """)
            .bind("phone", phoneNumber)
            .mapToBean(User.class)
            .findFirst()
            .orElse(null));
}

public User findByUsername(String username) {
    return jdbi.withHandle(handle -> handle.createQuery("""
                    SELECT
                        id,
                        email,
                        username,
                        password_hash AS passwordHash,
                        phone_number AS phoneNumber,
                        full_name AS fullName,
                        birth_day AS birthDay,
                        administrator,
                        active,
                        created_at AS createdAt,
                        update_at AS updateAt
                    FROM users
                    WHERE username=:username
                    """)
            .bind("username", username)
            .mapToBean(User.class)
            .findFirst()
            .orElse(null));
}

public boolean updatePassword(String email, String newPasswordHashed) {
    return jdbi.withHandle(handle -> handle.createUpdate("""
                    update users set password_hash =:passwordHash where email=:email""")
            .bind("passwordHash", newPasswordHashed)
            .bind("email", email).execute() > 0);
}

public boolean updateActive(int id, int activeNum) {
        return jdbi.withHandle(handle -> handle.createUpdate("""
                    update users set active = :activeNum where id = :id""")
                .bind("activeNum", activeNum)
                .bind("id", id)
                .execute() > 0);
}

    public int countUserId(String email) {
        return jdbi.withHandle(handle -> handle.createQuery("select count(id) from users where email = :email")
                .bind("email", email)
                .mapTo(Integer.class)
                .findOnly());
    }

    public int countNewUsersLastWeek() {
        return jdbi.withHandle(handle -> handle.createQuery(
                        "select COUNT(id) from users where created_at >= DATE_SUB(NOW(), INTERVAL 7 DAY)")
                .mapTo(Integer.class)
                .findOnly());
    }
}
