<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OTP Verification</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
</head>
<body>

    <div class="container">
        <h2 class="text-center">OTP Verification</h2>
        
        <!-- Displaying error message, if any -->
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger">${errorMessage}</div>
        </c:if>

        <form action="OtpVerifyServlet" method="post">
            <div class="form-group">
                <label for="otp">Enter the OTP sent to your email:</label>
                <input type="text" class="form-control" name="otp" placeholder="Enter OTP" required>
            </div>
            <button type="submit" class="btn btn-primary">Verify OTP</button>
        </form>
    </div>

</body>
</html>
