package com.hit.srv;

import java.io.PrintWriter;
import java.io.File;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

@WebServlet("/viewUploadedFiles")
public class ViewUploadedFilesServlet extends HttpServlet {
    private static final String UPLOAD_DIRECTORY = "uploads";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
        File uploadDir = new File(uploadPath);

        // Get the list of files in the directory
        File[] files = uploadDir.listFiles();

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.println("<html><body>");
        out.println("<h3>Available Tender Documents:</h3>");
        
        if (files != null && files.length > 0) {
            out.println("<ul>");
            for (File file : files) {
                // For each file, create a download link
                String fileName = file.getName();
                out.println("<li><a href='" + request.getContextPath() + "/uploads/" + fileName + "'>" + fileName + "</a></li>");
            }
            out.println("</ul>");
        } else {
            out.println("<p>No files available</p>");
        }

        out.println("</body></html>");
    }
}

