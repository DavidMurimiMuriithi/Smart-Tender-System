<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page
	import="java.sql.*,com.hit.dao.BidderDao,com.hit.dao.BidderDaoImpl,java.lang.Integer,java.lang.String,com.hit.beans.VendorBean, com.hit.beans.TenderBean,com.hit.utility.DBUtil,java.util.List,com.hit.dao.TenderDaoImpl,com.hit.dao.TenderDao, javax.servlet.annotation.WebServlet"
	errorPage="errorpage.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<link rel="shortcut icon" type="image/png" href="images/Banner_Hit.png">
<!--link rel="shortcut icon" type="image/ico" href="images/hit_fevicon.ico"-->

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Tender Management System</title>
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/annimate.css">
<link href="css/font-awesome.min.css" type="text/css" rel="stylesheet">
<link href="css/SpryTabbedPanels.css" type="text/css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Black+Ops+One"
	rel="stylesheet">
<link href="css/bootstrap-dropdownhover.min.css">
<link rel="stylesheet" href="css/style2.css">
<style>
button:hover {
	background-color: green;
	color: white;
	font-weight: bold;
}
</style>
</head>
<body>

	<%
	String user = (String) session.getAttribute("user");
	String uname = (String) session.getAttribute("username");
	String pword = (String) session.getAttribute("password");

	if (user == null || !user.equalsIgnoreCase("user") || uname.equals("") || pword.equals("")) {

		response.sendRedirect("loginFailed.jsp");

	}
	%>

	<!-- Including the header of the page  -->

	<jsp:include page="header.jsp"></jsp:include>

	<jsp:include page="vendorMenu.jsp"></jsp:include>

	<div class="clearfix hidden-sm hidden-xs"
		style="color: white; background-color: green; margin-top: -15px; margin-bottom: 12px">
		<marquee>Welcome to Tender Management Site</marquee>
	</div>

	<div class="container-fluid">
		<table class="table table-hover table-stripped bg-danger">
			<tr
				style="color: white; font-size:16px; font-weight: bold; background-color: green">
				<td>Tender Id</td>
				<td>Tender Name</td>
				<td>Type</td>
				<td>Budget</td>
				<td>Location</td>
				<td>Deadline</td>
				<td>Description</td>
				<td>Status</td>
				<td>Action</td>
			</tr>
			<%
			TenderDao tdao = new TenderDaoImpl();
			BidderDao bdao = new BidderDaoImpl();
			List<TenderBean> tenderList = tdao.getAllTenders();
			VendorBean vendor = (VendorBean) session.getAttribute("vendordata");
			String vid = vendor.getId();
			for (TenderBean tender : tenderList) {
				String tid = tender.getId();
				String tname = tender.getName();
				String ttype = tender.getType();
				int tprice = tender.getPrice();
				String tloc = tender.getLocation();
				java.util.Date udeadline = tender.getDeadline();
				java.sql.Date tdeadline = new java.sql.Date(udeadline.getTime());
				String tdesc = tender.getDesc();

				String assignStatus = tdao.getTenderStatus(tid);
				boolean isAssigned = false;
				if (assignStatus.equalsIgnoreCase("assigned"))
					isAssigned = true;
				//TODO next
			%>

			<tr>
				<td><%=tid%></td>
				<td><%=tname%></td>
				<td><%=ttype%></td>
				<td><%=tprice%></td>
				<td><%=tloc%></td>
				<td><%=tdeadline%></td>
				<td><textarea readonly cols="35" rows="2"><%=tdesc%></textarea></td>
				<td style="font-weight:bold;"><%=assignStatus%></td>
				<%
				if (!isAssigned) {
				%>
				<td><a href="bidTenderForm.jsp?tid=<%=tid%>&&vid=<%=vid%>"><button class="btn btn-success">BID NOW</button></a></td>
				<%
				} else {
				%>

				<td><button class="btn btn-danger" disabled>Expired</button></td>

				<%
				}
				}
				%>
			</tr>
		</table>

		<!-- Payment Methods Section -->
		<div class="payment-methods" style="margin-top: 30px;">
			<h4>Select Payment Method</h4>
			<!-- Bank Card Payment -->
			<form action="processBankCardPayment.jsp" method="post">
				<div class="form-group">
					<label for="cardNumber">Card Number:</label>
					<input type="text" name="cardNumber" class="form-control" required>
				</div>
				<div class="form-group">
					<label for="expiryDate">Expiry Date:</label>
					<input type="text" name="expiryDate" class="form-control" required>
				</div>
				<div class="form-group">
					<label for="cvv">CVV:</label>
					<input type="text" name="cvv" class="form-control" required>
				</div>
				<button type="submit" class="btn btn-primary">Pay with Bank Card</button>
			</form>

			<hr>

			<!-- MPesa Payment -->
			<form action="processMpesaPayment.jsp" method="post">
				<div class="form-group">
					<label for="mpesaNumber">Enter MPesa Phone Number:</label>
					<input type="text" name="mpesaNumber" class="form-control" required>
				</div>
				<button type="submit" class="btn btn-success">Pay with MPesa</button>
			</form>

			<hr>

			<!-- PayPal Payment -->
			<form action="processPayPalPayment.jsp" method="post">
				<div class="form-group">
					<label for="paypalEmail">PayPal Email:</label>
					<input type="email" name="paypalEmail" class="form-control" required>
				</div>
				<button type="submit" class="btn btn-info">Pay with PayPal</button>
			</form>
		</div>
	</div>

	<!-- Including the footer of the page -->
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>

