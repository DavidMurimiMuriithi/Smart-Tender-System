package com.hit.srv;


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

@WebServlet("/UploadTenderDocument")
public class UploadTenderDocumentServlet extends HttpServlet {

    private static final String UPLOAD_DIRECTORY = "uploads";
    private static final int MEMORY_THRESHOLD = 1024 * 1024 * 3;  // 3MB
    private static final int MAX_FILE_SIZE = 1024 * 1024 * 40;     // 40MB
    private static final int MAX_REQUEST_SIZE = 1024 * 1024 * 50;  // 50MB

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Checks if the request contains multipart content
        if (!ServletFileUpload.isMultipartContent(request)) {
            // If not, inform the user and stop
            response.getWriter().println("Error: Form must contain enctype=multipart/form-data.");
            return;
        }

        // Configure upload settings
        DiskFileItemFactory factory = new DiskFileItemFactory();
        factory.setSizeThreshold(MEMORY_THRESHOLD);
        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));

        ServletFileUpload upload = new ServletFileUpload(factory);
        upload.setFileSizeMax(MAX_FILE_SIZE);
        upload.setSizeMax(MAX_REQUEST_SIZE);

        // Constructs the directory path to store the upload file
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;

        // Create the directory if it doesn't exist
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        try {
            // Parses the request's content to extract file data
            List<FileItem> formItems = upload.parseRequest(request);

            if (formItems != null && formItems.size() > 0) {
                // Iterates over form's fields
                for (FileItem item : formItems) {
                    // Processes only fields that are file upload fields
                    if (!item.isFormField()) {
                        String fileName = new File(item.getName()).getName();
                        String filePath = uploadPath + File.separator + fileName;
                        File storeFile = new File(filePath);

                        // Save the file on disk
                        item.write(storeFile);

                        response.getWriter().println("Upload has been done successfully! File saved at: " + filePath);
                    }
                }
            }
        } catch (Exception ex) {
            response.getWriter().println("There was an error: " + ex.getMessage());
        }
    }
}

