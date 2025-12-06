package dao;

import java.util.List;

public interface IDAO<T> {
    List<T> getAll();

    T findById(T id);

    boolean create(T entity);

    boolean update(T entity);

    boolean delete(T id);

    List<T> search(String keyword);

    boolean exists(T id);


}
