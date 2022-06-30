package servlets;

import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.Role;
import models.User;
import services.RoleService;
import services.UserService;

public class UserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserService userService = new UserService();
        RoleService roleService = new RoleService();

        HttpSession session = request.getSession();

        String pageStatus = (String) session.getAttribute("pageStatus");

        if (pageStatus == null) {
            session.setAttribute("pageStatus", "display");
            response.sendRedirect("User");
            return;
        }

        switch (pageStatus) {
            case "display": 
                request.setAttribute("defaultTitle", true);
                request.setAttribute("enableForm", false);
                request.setAttribute("cancelForm", false);
                break;
            case "addUser": 
                request.setAttribute("addUser", true);
                request.setAttribute("enableForm", true);
                request.setAttribute("cancelForm", true);
                break;
            case "editUser": 
                request.setAttribute("editUser", true);
                request.setAttribute("enableForm", true);                
                request.setAttribute("cancelForm", true);
                break;
        }

        try {
            List<User> users = userService.getAll();
            List<Role> roles = roleService.getAll();
            request.setAttribute("users", users);
            request.setAttribute("roles", roles);
        } catch (Exception ex) {
            Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        getServletContext().getRequestDispatcher("/WEB-INF/user.jsp").forward(request, response);
        return;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserService userService = new UserService();
        String action = request.getParameter("action");

        switch (action) {
            case "addUser":
                session.setAttribute("userToEdit", null); 
                session.setAttribute("pageStatus", "addUser");
                break;       
            case "editUser": {
                try {
                    String key = request.getParameter("key");
                    User user = userService.get(key);                    
                    session.setAttribute("userToEdit", user);
                    session.setAttribute("pageStatus", "editUser");
                } catch (Exception ex) {
                    Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                break;
            }
            case "deleteUser":
                try {
                    String key = request.getParameter("key");
                    userService.delete(key);
                    session.setAttribute("pageStatus", "display");
                } catch (Exception ex) {
                    Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                break;
            case "saveUser":
                String email = request.getParameter("email");      
                boolean isActive = ("active".equals(request.getParameter("isActive")));
                String firstName = request.getParameter("firstName");
                String lastName = request.getParameter("lastName");
                String password = request.getParameter("password");
                int role = Integer.parseInt(request.getParameter("roleName"));

                User user = new User(email, isActive, firstName, lastName, password, role);

                String pageStatus = (String) session.getAttribute("pageStatus"); 
                try {
                    if ("addUser".equals(pageStatus)) { 
                        userService.insert(user);
                    } else if ("editUser".equals(pageStatus)) { 
                        userService.update(user);
                    }
                } catch (Exception ex) {
                    Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                session.setAttribute("pageStatus", "display");
                break;
            case "cancel":
                session.setAttribute("pageStatus", "display");
                break;
        }
        response.sendRedirect("User");
        return;
    }
}