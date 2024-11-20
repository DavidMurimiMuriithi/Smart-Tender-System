<%@page import="java.util.List, com.hit.dao.TenderDaoImpl, com.hit.beans.TenderBean,com.hit.dao.TenderDaoImpl,com.hit.dao.TenderDao"%>
<!DOCTYPE html>
<html>
<head>
    <title>Tender Report</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
</head>
<body>
    <h2 style="text-align: center;">All Tenders Report</h2>
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>Tender ID</th>
                <th>Name</th>
                <th>Type</th>
                <th>Budget</th>
                <th>Location</th>
                <th>Deadline</th>
                <th>Description</th>
            </tr>
        </thead>
        <tbody>
            <%
                TenderDao dao = new TenderDaoImpl();
                List<TenderBean> tenderList = dao.getAllTenders();
                for (TenderBean tender : tenderList) {
            %>
            <tr>
                <td><%= tender.getId() %></td>
                <td><%= tender.getName() %></td>
                <td><%= tender.getType() %></td>
                <td>KSh <%= tender.getPrice() %></td>
                <td><%= tender.getLocation() %></td>
                <td><%= tender.getDeadline() %></td>
                <td><%= tender.getDesc() %></td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>
    <button onclick="window.print();" class="btn btn-info">Print Report</button>
</body>
</html>
