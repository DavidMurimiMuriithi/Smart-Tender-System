<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>OTP Verification</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <style>
        body {
            background-color: #f5f5f5;
        }
        .otp-container {
            margin: 0 auto;
            width: 50%;
            padding: 50px;
            background-color: white;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .otp-form input {
            font-size: 18px;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <div class="otp-container">
        <h3 style="text-align:center;">OTP Verification</h3>
        <form action="OtpVerifyServlet" method="post" class="otp-form">
            <label for="otp">Enter OTP:</label>
            <input type="text" id="otp" name="otp" required="required" class="form-control" placeholder="Enter OTP">
            <br>
            <input type="submit" value="Verify OTP" class="btn btn-success btn-block">
        </form>
    </div>
</body>
</html>
