package services;

import dao.FavouriteDAO;
import model.Favourite;

import java.util.List;

public class FavouriteService {
    FavouriteDAO favouriteDAO;

    public FavouriteService() {
        this.favouriteDAO = new FavouriteDAO();
    }

    public void create(int idProduct, int idUser) {
        favouriteDAO.create(idProduct, idUser);
    }

    public void delete(int idFavourite, int idProduct, int idUser) {
        favouriteDAO.delete(idFavourite, idProduct, idUser);
    }

    public List<Favourite> getByUserID(int idUser) {
        return favouriteDAO.getByUserID(idUser);
    }

    public List<java.util.Map<String, Object>> getFavouritesWithProducts(int idUser) {
        return favouriteDAO.getFavouritesWithProductsByUserID(idUser);
    }
}
