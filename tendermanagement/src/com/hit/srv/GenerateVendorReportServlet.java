package com.hit.srv;

import com.hit.beans.VendorBean;
import com.hit.dao.VendorDao;
import com.hit.dao.VendorDaoImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/generateVendorReport")
public class GenerateVendorReportServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Set response type and headers for CSV file
        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", "attachment; filename=vendor_report.csv");

        VendorDao dao = new VendorDaoImpl();

        try {
            // Fetch the list of all vendors
            List<VendorBean> vendorList = dao.getAllVendors();

            PrintWriter writer = response.getWriter();
            
            // Write CSV headers
            writer.println("Vendor Id,Vendor Name,Mobile,Email,Company,Address");

            // Write vendor details with proper CSV formatting
            for (VendorBean vendor : vendorList) {
                writer.println(
                    "\"" + vendor.getId() + "\"," +
                    "\"" + escapeCsv(vendor.getName()) + "\"," +
                    "\"" + escapeCsv(vendor.getMobile()) + "\"," +
                    "\"" + escapeCsv(vendor.getEmail()) + "\"," +
                    "\"" + escapeCsv(vendor.getCompany()) + "\"," +
                    "\"" + escapeCsv(vendor.getAddress()) + "\""
                );
            }

            writer.flush();
            writer.close();

        } catch (Exception e) {
            // Log error and send error message in response
            System.err.println("Error while generating vendor report: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to generate the report.");
        }
    }

    /**
     * Escapes special characters in CSV fields.
     * @param field The field value to escape.
     * @return Escaped field value.
     */
    private String escapeCsv(String field) {
        if (field == null) return "";
        return field.replace("\"", "\"\"");
    }
}
