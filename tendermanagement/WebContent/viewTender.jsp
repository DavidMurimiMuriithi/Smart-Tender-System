<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page
	import="java.sql.*,java.lang.Integer,java.lang.String, com.hit.beans.TenderBean,com.hit.utility.DBUtil,java.util.List,com.hit.dao.TenderDaoImpl,com.hit.dao.TenderDao, javax.servlet.annotation.WebServlet"
	errorPage="errorpage.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<link rel="shortcut icon" type="image/png" href="images/Banner_Hit.png">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Tender Management System</title>
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/annimate.css">
<link href="css/font-awesome.min.css" type="text/css" rel="stylesheet">
<link href="css/SpryTabbedPanels.css" type="text/css" rel="stylesheet">
<link rel="stylesheet" href="css/style2.css">
<style>
th, tr {
	height: 50px;
	border: 2px black solid;
}

td {
	min-width: 115px;
	border: 2px dashed black;
}

table {
	text-align: center;
	border-radius: 10px;
	border: 1px red solid;
	text-align: center;
	background-color: cyan;
	margin: 20px;
	color: blue;
	font-style: normal;
	font-size: 14px;
	padding: 20px;
	cellpadding: 10;
	cellspacing: 10;
}

tr:hover {
	background-color: #DEBEE1;
	color: black;
}
</style>
</head>
<body>

	<%
	String user = (String) session.getAttribute("user");
	String uname = (String) session.getAttribute("username");
	String pword = (String) session.getAttribute("password");

	if (!user.equalsIgnoreCase("admin") || uname.equals("") || pword.equals("")) {
		response.sendRedirect("loginFailed.jsp");
	}
	%>

	<!-- Including the header of the page  -->
	<jsp:include page="header.jsp"></jsp:include>
	<jsp:include page="adminMenu.jsp"></jsp:include>

	<div class="container-fluid">
		<div class="clearfix hidden-sm hidden-xs"
			style="color: white; background-color: green; margin-top: -15px; margin-bottom: 12px">
			<marquee>Welcome to Tender Management Site</marquee>
		</div>

		<!-- Generate Report Button -->
		<form action="generateReport.jsp" method="post">
			<button type="submit" class="btn btn-primary">Generate Report</button>
		</form>
		<br>

		<div class="col-md-8">
			<table style="background-color: white">
				<tr
					style="color: white; font-size: 18px; font-weight: bold; background-color: green">
					<td>Tender Id</td>
					<td>Name</td>
					<td>Type</td>
					<td>Budget</td>
					<td>Location</td>
					<td>Deadline</td>
					<td>Description</td>
					<td>Actions</td>
				</tr>
				<%
				TenderDao dao = new TenderDaoImpl();
				List<TenderBean> tenderList = dao.getAllTenders();
				for (TenderBean tender : tenderList) {
					String tid = tender.getId();
				%>

				<tr>
					<td><a href="viewTenderBidsForm.jsp?tid=<%=tid%>"><%=tid%></a></td>
					<td><%=tender.getName()%></td>
					<td><%=tender.getType()%></td>
					<td>KSh <%=tender.getPrice()%></td>
					<td><%=tender.getLocation()%></td>
					<td><%=tender.getDeadline()%></td>
					<td><textarea rows="3" disabled><%=tender.getDesc()%></textarea></td>
					<td>
						<!-- Delete Tender Form -->
						<form action="deleteTenderServlet" method="post">
							<input type="hidden" name="tenderId" value="<%=tid%>">
							<button type="submit" class="btn btn-danger"
								onclick="return confirm('Are you sure you want to delete this tender?');">
								Delete
							</button>
						</form>
					</td>
				</tr>

				<%
				}
				%>
			</table>
		</div>
	</div>

	<!-- Including the footer of the page -->
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
