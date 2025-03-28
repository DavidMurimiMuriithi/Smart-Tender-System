package com.hit.srv;

import com.paypal.api.payments.*;
import com.paypal.base.rest.APIContext;
import com.paypal.base.rest.PayPalRESTException;

import java.util.List;
import java.util.ArrayList;

public class PayPalPaymentSrv {
    public static String createPayment(String amount) throws PayPalRESTException {
        // Initialize the API context with your client credentials
        APIContext apiContext = new APIContext("", "", "sandbox");//YOUR API

        // Set up the payment amount
        Amount paymentAmount = new Amount();
        paymentAmount.setCurrency("USD");
        paymentAmount.setTotal(amount);

        // Create a transaction object
        Transaction transaction = new Transaction();
        transaction.setAmount(paymentAmount);
        transaction.setDescription("Payment for tender");

        // Create a list of transactions
        List<Transaction> transactions = new ArrayList<>();
        transactions.add(transaction);

        // Set up the payer
        Payer payer = new Payer();
        payer.setPaymentMethod("paypal");

        // Create the payment object
        Payment payment = new Payment();
        payment.setIntent("sale");
        payment.setPayer(payer);
        payment.setTransactions(transactions);

        // Set the redirect URLs
        RedirectUrls redirectUrls = new RedirectUrls();
        redirectUrls.setCancelUrl("https://your_domain/cancel");
        redirectUrls.setReturnUrl("https://your_domain/success");
        payment.setRedirectUrls(redirectUrls);

        // Create the payment and get the response
        Payment createdPayment = payment.create(apiContext);

        // Get the approval URL from the links in the created payment
        for (Links link : createdPayment.getLinks()) {
            if (link.getRel().equalsIgnoreCase("approval_url")) {
                return link.getHref(); // Return the approval URL
            }
        }

        throw new PayPalRESTException("Approval URL not found");
    }
}
