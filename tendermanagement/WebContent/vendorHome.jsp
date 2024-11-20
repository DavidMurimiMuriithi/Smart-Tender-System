<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@page import="java.sql.*, com.hit.utility.DBUtil, javax.servlet.annotation.WebServlet,com.hit.beans.VendorBean" errorPage="errorpage.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
  <head>
    <link rel="shortcut icon" type="image/png" href="Bid Color.png">
    <!--link rel="shortcut icon" type="image/ico" href="images/hit_fevicon.ico"-->
	
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> Smart Tender System</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/annimate.css">
    <link href="css/font-awesome.min.css" type="text/css" rel="stylesheet">
    <link href="css/SpryTabbedPanels.css" type="text/css" rel="stylesheet">
    <!--link rel="stylesheet" href="css/styles.css"-->
    <link href="https://fonts.googleapis.com/css?family=Black+Ops+One" rel="stylesheet">
    <link href="css/bootstrap-dropdownhover.min.css">
    <link rel="stylesheet" href="css/style2.css">
  </head>
<body>

	<%
		String user = (String)session.getAttribute("user");
		String uname = (String)session.getAttribute("username");
		String pword = (String)session.getAttribute("password");
		
		if(!user.equalsIgnoreCase("user") || uname.equals("") || pword.equals("")){
			
			response.sendRedirect("loginFailed.jsp");
			
		}
	
	%>
	
	<!-- Including the header of the page  -->
	
	<jsp:include page="header.jsp"></jsp:include>
	
	<jsp:include page="vendorMenu.jsp"></jsp:include>
	
	<div class="clearfix hidden-sm hidden-xs" style="color:white;background-color: green; margin-top:-15px; margin-bottom: 12px"><marquee>Welcome to Smart Tender System</marquee>
 </div> <!--A green color line between header and body part-->
 
     <div class="container-fluid">
     
     	<div class="notice">
        <div class="col-md-3"style="margin-left:2%">
     		<% Connection con = DBUtil.provideConnection(); %>
     		
     		<jsp:include page="notice.jsp"></jsp:include><br>
     		
          <!-- Next marquee starting-->
          <jsp:include page="approved.jsp"></jsp:include><br>
          
        </div>  <!-- End of col-md-3-->
      </div> <!-- End of notice class-->
                 
	<%
	
		VendorBean vendor = (VendorBean)session.getAttribute("vendordata");
	
	%>
      
      <!-- Next part of same container-fluid in which galary or other information will be shown-->
      
          
   <div class="col-md-8">
    <div class="marquee" style="border:2px black hidden; background-color:white">
        <h4 style="background-color:black; margin-top:-1.8px; margin-bottom:1px;padding: 5px; text-align: center;color:red;font-weight:bold">
        &nbsp; <span id="pagetitle">VENDOR ACCOUNT</span></h4><!-- pagetitle id is given here -->
        <div class="marquee-content" style="align:center; padding-top:200px;min-height:750px;background-color:cyan">
     		<h3><center>Welcome,<b style="background-color:white"> <%= vendor.getName()%>!</b>
              You are logged in as a Vendor in the Tender Management System. As a vendor, you can view and bid on tenders, manage your profile, and track the status of your bids.</center></h3>
     		 <ul>
                        <li><b>View Available Tenders</b>: Click on the "Tenders" menu to see all open tenders. You can view tender details, including budget, location, and deadline. Ready to place a bid? Simply click the <b>"BID NOW"</b> button for the tender you're interested in.</li>
                        <li><b>Download Tender Documents</b>: Check and download any attached documents for each tender to help you understand the requirements better.</li>
                        <li><b>Manage Your Bids</b>: Track your submitted bids by going to the "My Bids" section. Here, you can monitor the status of each bid—whether it's under review, approved, or if the tender has been assigned.</li>
                        <li><b>Profile Management</b>: Head over to the "Profile" section to update your company details, change passwords, and maintain your account.</li>
                    </ul>
      </div>
     </div>
     </div>
      
      
      
      
     <a><h1></h1></a>
      
    </div> <!-- End of container-fluid-->
	
	
<!--	
	<!DOCTYPE html>
<html>
<head>
    <title>Vendor Tender Documents</title>
</head>
<body>
    <h2>Tender Documents Available for Download</h2>
    <a href="viewUploadedFiles">View Uploaded Documents</a>
</body>
</html>
	-->
	<!DOCTYPE html>
<html>
<head>
    <title>Vendor Tender Documents</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        h2 {
            color: #333;
        }
        .document-list {
            list-style-type: none;
        }
        .document-list li {
            margin: 10px 0;
        }
        .document-list a {
            text-decoration: none;
            color: blue;
        }
        .document-list a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <h2>Tender Documents Available for Download</h2>
    <ul class="document-list">
        <li><a href="viewUploadedFiles" target="_blank">Tender Document 1</a></li>
        <li><a href="viewUploadedFiles" target="_blank">Tender Document 2</a></li>
        <li><a href="viewUploadedFiles" target="_blank">Tender Document 3</a></li>
        <!-- Add more documents as needed -->
    </ul>
</body>
</html>
	



<!-- Now from here the footer section starts-->
                      
<!-- Including the footer of the page -->
    
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>