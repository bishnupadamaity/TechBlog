package com.dream.gadddi.servlets;

import com.dream.gadddi.helper.ConnectionProvider;
import com.dream.gadddi.helper.Helper;
import com.drream.gadddi.dao.UserDao;
import com.drream.gadddi.entities.Message;
import com.drream.gadddi.entities.User;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@MultipartConfig
public class EditServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {

            String userName = request.getParameter("user_name");
            String userEmail = request.getParameter("user_email");
            String userPassword = request.getParameter("user_password");
            String userAbout = request.getParameter("user_about");
            Part part = request.getPart("image");

            String imageName = part.getSubmittedFileName();

            // get the user from the session 
            HttpSession s = request.getSession();

            User user = (User) s.getAttribute("currentUser");
            user.setName(userName);
            user.setAbout(userAbout);
            user.setEmail(userEmail);
            user.setPassword(userPassword);

            // to get old image path for delete operation
            String oldProfile = user.getProfile();

            user.setProfile(imageName);

            // update database
            UserDao userDao = new UserDao(ConnectionProvider.getConnection());

            boolean ans = userDao.updateUser(user);
            if (ans == true) {

                String path = request.getRealPath("/") + "pics" + File.separator + user.getProfile();
                String pathOldFile = request.getRealPath("/") + "pics" + File.separator + oldProfile;

                if (!oldProfile.equals("default.png")) {

                    Helper.deleteFile(pathOldFile);
                }

                if (Helper.saveFile(part.getInputStream(), path)) {
                    out.println("Updated");
                    Message msg = new Message("Profile Updated.", "success", "alert-success");
                    s.setAttribute("msg", msg);

                } else {
                    Message msg = new Message("Something went wrong !", "error", "alert-danger");
                    s.setAttribute("msg", msg);
                }
            } else {
                Message msg = new Message("Something went wrong !", "error", "alert-danger");
                s.setAttribute("msg", msg);

            }
            response.sendRedirect("profile.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
