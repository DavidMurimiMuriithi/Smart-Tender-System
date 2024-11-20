<%@ page import="com.hit.srv.PayPalPaymentSrv" %>
<%
    try {
        String amount = "100.00"; // Example amount
        String approvalUrl = PayPalPaymentSrv.createPayment(amount);
        response.sendRedirect(approvalUrl); // Redirect to PayPal approval URL
    } catch (Exception e) {
        out.println("Payment failed: " + e.getMessage());
    }
%>
