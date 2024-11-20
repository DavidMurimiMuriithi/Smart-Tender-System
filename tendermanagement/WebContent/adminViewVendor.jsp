<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List, com.hit.beans.VendorBean, com.hit.dao.VendorDaoImpl, com.hit.dao.VendorDao" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vendor Management</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <style>
        th, tr { height: 50px; border: 2px black solid; }
        td { min-width: 105px; border: 2px dashed black; }
        table { text-align: center; border-radius: 10px; border: 1px red solid; background-color: cyan; margin: 20px; color: blue; }
        tr:hover { background-color: #DEBEE1; color: black; }
        textarea:hover { background-color: #ADBFAF; color: black; }
        .button:hover { background-color: green; color: white; }
        #show { text-align: center; border-radius: 10px; background-color: cyan; margin: 10px; color: black; font-size: 15.5px; padding: 12px; width: 100%; }
        button:hover { background-color: green; color: white; }
    </style>
</head>
<body>
    <% 
        String user = (String) session.getAttribute("user");
        String uname = (String) session.getAttribute("username");
        String pword = (String) session.getAttribute("password");

        if (user == null || !user.equalsIgnoreCase("admin") || uname.equals("") || pword.equals("")) {
            response.sendRedirect("loginFailed.jsp");
        }
    %>

    <!-- Include Header and Menu -->
    <jsp:include page="header.jsp"></jsp:include>
    <jsp:include page="adminMenu.jsp"></jsp:include>

    <!-- Welcome Marquee -->
    <div class="clearfix hidden-sm hidden-xs" style="color:white;background-color: green; margin-top:-15px; margin-bottom: 12px">
        <marquee>Welcome to Smart Tender System</marquee>
    </div>

    <div class="container-fluid">
        <div class="col-md-8">
            <div id="show">These are the Vendors Currently Registered With Us</div>

            <!-- Vendor List Table -->
            <table>
                <tr style="color:white; font-size:22px; font-weight:bold;background-color:#660033">
                    <td>Vendor Id</td> 
                    <td>Vendor Name</td> 
                    <td>Mobile</td> 
                    <td>Email</td> 
                    <td>Company</td> 
                    <td>Address</td> 
                    <td>Actions</td>
                </tr>
                <%
                    VendorDao dao = new VendorDaoImpl();
                    List<VendorBean> vendorList = dao.getAllVendors();
                    for (VendorBean vendor : vendorList) {
                %>
                <tr>
                    <td><a href="adminViewVendorDetail.jsp?vid=<%= vendor.getId() %>"><%= vendor.getId() %></a></td>
                    <td><%= vendor.getName() %></td>
                    <td><%= vendor.getMobile() %></td>
                    <td><%= vendor.getEmail() %></td>
                    <td><%= vendor.getCompany() %></td>
                    <td><textarea readonly><%= vendor.getAddress() %></textarea></td>
                    <td>
                        <!-- Delete Vendor Form -->
                        <form action="deleteVendor" method="post" style="display:inline;">
                            <input type="hidden" name="vendorId" value="<%= vendor.getId() %>" />
                            <button type="submit" class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this vendor?');">Delete</button>
                        </form>
                    </td>
                </tr>
                <% } %>
            </table>

            <!-- Generate Vendor Report -->
            <form action="generateVendorReport" method="post">
                <button type="submit" class="btn btn-primary">Download Vendor Report (CSV)</button>
            </form>
        </div>
    </div>

    <!-- Include Footer -->
    <jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
