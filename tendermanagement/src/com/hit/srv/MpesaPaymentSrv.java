package com.hit.srv;

import com.hit.utility.MpesaUtil;

import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import org.json.JSONObject;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Base64;

public class MpesaPaymentSrv {
    public static String initiatePayment(String phoneNumber, String amount) throws Exception {
        // Get access token from MpesaUtil
        String accessToken = MpesaUtil.getAccessToken();
        
        // Prepare the URL for the Mpesa STK push request
        URL url = new URL("https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest");
        HttpURLConnection con = (HttpURLConnection) url.openConnection();
        con.setRequestMethod("POST");
        con.setRequestProperty("Authorization", "Bearer " + accessToken);
        con.setRequestProperty("Content-Type", "application/json");

        // Prepare BusinessShortCode, Timestamp, and Password
        String shortCode = "174379"; // Replace with your actual shortcode
        String passkey = ""; // Replace with your actual passkey
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String timestamp = sdf.format(new Date()); // Generate current timestamp
        String password = Base64.getEncoder().encodeToString((shortCode + passkey + timestamp).getBytes());

        // Prepare the payment payload
        JSONObject requestBody = new JSONObject();
        requestBody.put("BusinessShortCode", 174379); 
        requestBody.put("Password", password);
        requestBody.put("Timestamp", timestamp);
        requestBody.put("TransactionType", "CustomerPayBillOnline");
        requestBody.put("Amount", amount); // Payment amount
        requestBody.put("PartyA", phoneNumber); // Customer's phone number
        requestBody.put("PartyB", 174379); // Your PayBill/Till number (BusinessShortCode)
        requestBody.put("PhoneNumber", phoneNumber); // Customer's phone number
        requestBody.put("CallBackURL", "https://mydomain.com/path"); // Replace with your callback URL
        requestBody.put("AccountReference", "TenderPayment"); // Customize as needed
        requestBody.put("TransactionDesc", "Payment for tender"); // Customize as needed

        // Send the payment request
        con.setDoOutput(true);
        OutputStream os = con.getOutputStream();
        os.write(requestBody.toString().getBytes());
        os.flush();
        os.close();

        // Check the response code from the Mpesa API
        int responseCode = con.getResponseCode();
        if (responseCode == HttpURLConnection.HTTP_OK) {
            // Parse the response and return success message
            return "Payment initiated successfully";
        } else {
            throw new Exception("Payment initiation failed");
        }
    }
}
