<%@ page import="com.hit.srv.MpesaPaymentSrv" %>
<%
    String phoneNumber = request.getParameter("mpesaNumber");
    String amount = "5"; // Set the amount to be paid

    try {
        String message = MpesaPaymentSrv.initiatePayment(phoneNumber, amount);
        out.println(message);
    } catch (Exception e) {
        out.println("Payment failed: " + e.getMessage());
    }
%>
