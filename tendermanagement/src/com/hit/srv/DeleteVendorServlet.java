
package com.hit.srv;

import com.hit.dao.VendorDao;
import com.hit.dao.VendorDaoImpl;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/deleteVendor")
public class DeleteVendorServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String vendorId = request.getParameter("vendorId");

        VendorDao dao = new VendorDaoImpl();
        boolean isDeleted = dao.deleteVendor(vendorId);

        if (isDeleted) {
            response.sendRedirect("adminViewVendor.jsp?message=Vendor Deleted Successfully");
        } else {
            response.sendRedirect("adminViewVendor.jsp?error=Error Deleting Vendor");
        }
    }
}
