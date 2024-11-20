package com.hit.srv;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hit.dao.TenderDao;
import com.hit.dao.TenderDaoImpl;
import com.hit.beans.TenderBean;
import com.hit.beans.TenderStatusBean;
import java.util.List;



@WebServlet("/deleteTenderServlet")
public class DeleteTenderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String tenderId = request.getParameter("tenderId");

        TenderDao tenderDao = new TenderDaoImpl();
        boolean isDeleted = tenderDao.deleteTender(tenderId);  // Assuming you have this method in your DAO

        if (isDeleted) {
            request.setAttribute("message", "Tender deleted successfully!");
        } else {
            request.setAttribute("error", "Error occurred while deleting the tender.");
        }
        
        // Redirect back to the tender listing page (admin view)
        request.getRequestDispatcher("adminTenderList.jsp").forward(request, response);
    }
}
