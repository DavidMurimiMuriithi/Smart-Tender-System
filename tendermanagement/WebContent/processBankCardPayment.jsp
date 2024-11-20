<%@ page import="com.stripe.Stripe, com.stripe.model.Charge, java.util.HashMap, java.util.Map" %>
<%
    // Set your secret key. This can be found in the Stripe dashboard.
    Stripe.apiKey = "your_stripe_secret_key";

    String cardNumber = request.getParameter("cardNumber");
    String expiryDate = request.getParameter("expiryDate");
    String cvv = request.getParameter("cvv");
    
    try {
        Map<String, Object> chargeParams = new HashMap<>();
        chargeParams.put("amount", 5000); // Amount in cents ($50.00)
        chargeParams.put("currency", "usd");
        chargeParams.put("source", "tok_visa"); // Use a test token or generate one using Stripe's API

        Charge charge = Charge.create(chargeParams);

        out.println("Payment Successful. Charge ID: " + charge.getId());
    } catch (Exception e) {
        out.println("Payment failed: " + e.getMessage());
    }
%>
