package controller.account_manager;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import services.AccountManagerService;

import java.io.IOException;

@WebServlet(name = "MultiBlockAccountsController", value = "/accountmanager/lock-multiple")
public class MultiToggleStatusAccountsController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        AccountManagerService accountManagerService = new AccountManagerService();
        String ids = request.getParameter("ids");
        boolean status = Boolean.parseBoolean(request.getParameter("status"));
        if (ids != null) {
            String[] idArray = ids.split(",");
            for (String idString : idArray) {
                int id = Integer.parseInt(idString);
                if (status) {
                    accountManagerService.updateStatus(id, 0);
                } else {
                    accountManagerService.updateStatus(id, 1);
                }
            }
        }
        response.setStatus(HttpServletResponse.SC_OK);
    }
}