package com.hit.utility;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Base64;
import org.json.JSONObject; // Make sure to include the org.json library in your project

public class MpesaUtil {
    public static String getAccessToken() throws Exception {
        String consumerKey = "YxOXsJGNYqGasHB8JfrHWSxRbab6pGPkbl3jUzoecRmeAcWd"; // Replace with your actual consumer key
        String consumerSecret = "hwzSZndr4NnsunIoZRy08LJGyb3GqPUzMdaIPeN4IjryVMyndxO8Vc752cd3aEKK"; // Replace with your actual consumer secret
        
        String auth = consumerKey + ":" + consumerSecret;
        byte[] encodedAuth = Base64.getEncoder().encode(auth.getBytes());
        String authHeader = "Basic " + new String(encodedAuth);
        
        URL url = new URL("https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials");
        HttpURLConnection con = (HttpURLConnection) url.openConnection();
        con.setRequestMethod("GET");
        con.setRequestProperty("Authorization", authHeader);
        
        int responseCode = con.getResponseCode();
        if (responseCode == HttpURLConnection.HTTP_OK) {
            // Read the response from the input stream
            BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
            String inputLine;
            StringBuffer response = new StringBuffer();

            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();

            // Parse the access token from the JSON response
            JSONObject jsonResponse = new JSONObject(response.toString());
            return jsonResponse.getString("access_token");
        } else {
            throw new Exception("Failed to get access token. Response code: " + responseCode);
        }
    }
}

